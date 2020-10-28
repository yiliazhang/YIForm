//
//  YIFormManager.m
//  YIForm
//
//  Created by Yilia on 2020/10/12.
//

#import "YIFormManager.h"

inline YIFormSection *Section() {
    return [[YIFormSection alloc] init];
}

inline __kindof YIFormRow *Row(id rowClass) {
    return [[rowClass alloc] init];
}

@interface YIFormManager()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak, nullable) UITableView *tableView;
///
//@property (nonatomic, nullable, copy) instancetype (^testBlock)(id response);
///
//@property (nonatomic, nullable, copy) void (^cellUpdate)(void);
///
@property (nonnull, strong, nonatomic) NSMutableSet<NSString *> *sectionTags;
///
@property (nonnull, strong, nonatomic) NSMutableSet<NSString *> *rowTags;
///
@property (nonnull, strong, nonatomic) NSMutableArray<YIFormSection *> *sections;
//@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle;
@end

NSString * const XLFormErrorDomain = @"XLFormErrorDomain";
NSString * const XLValidationStatusErrorKey = @"XLValidationStatusErrorKey";

NSString * const XLFormSectionsKey = @"formSections";

@implementation YIFormManager

-(void)dealloc
{
    //    [self removeObserver:self forKeyPath:XLFormSectionsKey];
    
    //    [_formSections removeAllObjects];
    //    _formSections = nil;
    //    [_allSections removeAllObjects];
    //    _allSections = nil;
    //    [_allRowsByTag removeAllObjects];
    //    _allRowsByTag = nil;
}

+ (instancetype)managerForTableView:(UITableView *)tableView {
    return [[YIFormManager alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _sections = [NSMutableArray array];
        tableView.delegate = self;
        tableView.dataSource = self;
        //        self.separatorStyle = tableView.separatorStyle;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView = tableView;
    }
    return self;
}
// MARK: - 检索

-(NSIndexPath *)indexPathForRow:(YIFormRow *)row {
    if (self.sections.count == 0) {
        return nil;
    }
    NSUInteger sectionIndex = -1;
    NSUInteger rowIndex = -1;
    
    for (int index = 0; index < self.sections.count; index++) {
        YIFormSection *section = self.sections[index];
        if ([section.rows containsObject:row]) {
            sectionIndex = index;
            rowIndex = [section.rows indexOfObject:row];
        }
    }
    
    if (sectionIndex == -1 || rowIndex == -1) {
        return nil;
    }
    return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
}

- (NSUInteger)indexForSection:(YIFormSection *)section {
    __block NSUInteger sectionIndex = -1;
    if (self.sections.count == 0) {
        return sectionIndex;
    }
    [self.sections enumerateObjectsUsingBlock:^(YIFormSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:section]) {
            sectionIndex = idx;
            *stop = YES;
        }
    }];
    return sectionIndex;
}


- (nullable __kindof YIFormRow *)rowWithTag:(NSString *)tag {
    __block YIFormRow *result = nil;
    
    [self.sections enumerateObjectsUsingBlock:^(YIFormSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (result) {
            *stop = YES;
        }
        [obj.rows enumerateObjectsUsingBlock:^(__kindof YIFormRow * _Nonnull row, NSUInteger idx, BOOL * _Nonnull stop1) {
            if (row.tag && row.tag.length > 0 && row.tag == tag) {
                result = row;
                *stop = YES;
            }
        }];
        
    }];
    return result;
}

- (nullable YIFormRow *)rowAtIndexPath:(NSIndexPath *)indexPath {
    return self.sections[indexPath.section].rows[indexPath.row];
}

/// tag 对应 section
/// @param tag section tag
- (nullable YIFormSection *)sectionWithTag:(NSString *)tag {
    __block YIFormSection *section = nil;
    if (tag.length == 0) {
        return section;
    }
    if (self.sections.count == 0) {
        return section;
    }
    [self.sections enumerateObjectsUsingBlock:^(YIFormSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag && [obj.tag isEqualToString:tag]) {
            section = obj;
            *stop = YES;
        }
    }];
    return section;
}

// MARK: - 增删

- (void)addSections:(NSArray<YIFormSection *> *)sections {
    if (sections.count == 0) {
        return;
    }
    
    for (YIFormSection *section in sections) {
        section.formManager = self;
    }
    [_sections addObjectsFromArray:sections];
}

- (void)removeAll {
    [_sections removeAllObjects];
}

- (void)removeSectionsAt:(NSIndexSet *)indexes {
    [_sections removeObjectsAtIndexes:indexes];
}

/// 移除 sections
/// @param sections section 数组
- (void)removeSections:(NSArray<YIFormSection *> *)sections {
    
}

/// 移除 row
/// @param formRow row
-(void)removeRow:(YIFormRow *)formRow {
    
}

/// 移除 tag 对应的 row
/// @param tag row tag
- (void)removeRowWithTag:(nonnull NSString *)tag {
    YIFormRow *row = [self rowWithTag:tag];
    if (row) {
        [self.sections enumerateObjectsUsingBlock:^(YIFormSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.rows containsObject:row]) {
                [obj removeRows:@[row]];
                *stop = YES;
            }
        }];
    }
}

// MARK: - 刷新 和 其他

- (void)reloadRows:(NSArray<YIFormRow *> *)rows {
    for (YIFormRow *row in rows) {
        [self updateFormRow:row];
    }
}

- (void)reloadSections:(NSArray<YIFormSection *> *)sections {
    if (self.sections.count == 0) {
        return;
    }
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (int index = 0; index < sections.count; index++) {
        YIFormSection *section = sections[index];
        if ([self.sections containsObject:section]) {
            [indexSet addIndex:index];
        }
    }
    if (indexSet.count > 0) {
        [self reloadSectionsAt:indexSet];
    }
}

- (void)reloadRowsAt:(NSArray<NSIndexPath *> *)indexPaths {
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

- (void)reloadSectionsAt:(NSIndexSet *)indexes {
    [self.tableView reloadSections:indexes withRowAnimation:UITableViewRowAnimationNone];
}


/// 更新row 对应的 cell
/// @param formRow row
-(__kindof YIFormCell *)updateFormRow:(YIFormRow *)formRow
{
    //    YIFormCell * cell = [formRow cellForTableView:self.tableView];
    YIFormCell * cell = formRow.cell;
    if (cell != nil) {
        cell.separatorColor = [self separatorColorFor:formRow];
        [self configureCell:cell];
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
    }
    return cell;
}

/// cell 配置
/// @param cell cell
-(void)configureCell:(YIFormCell *) cell
{
    [cell update];
    
    if(cell.row != nil && cell.row.cellConfig != nil) {
        [cell.row.cellConfig enumerateKeysAndObjectsUsingBlock:^(NSString *keyPath, id value, BOOL * __unused stop) {
            [cell setValue:(value == [NSNull null]) ? nil : value forKeyPath:keyPath];
        }];
    }
    
    if (cell.row.disabled){
        [cell.row.cellConfigIfDisabled enumerateKeysAndObjectsUsingBlock:^(NSString *keyPath, id value, BOOL * __unused stop) {
            [cell setValue:(value == [NSNull null]) ? nil : value forKeyPath:keyPath];
        }];
    }
}

- (UIColor *)separatorColorFor:(YIFormRow *)row {
    if (!row.separatorColor) {
        return self.tableView.separatorColor;
    }
    return row.separatorColor;
}

// MARK: -

- (void)formRowValueHasChanged:(YIFormRow *)formRow oldValue:(id)oldValue newValue:(id)newValue
{
    [self updateFormRow:formRow];
}
#pragma mark -
#pragma mark Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YIFormRow *rowDescriptor = [self rowAtIndexPath:indexPath];
    CGFloat height = rowDescriptor.height;
    if (height > YIFormRowInitialHeight){
        return height;
    }
    return self.tableView.rowHeight;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YIFormRow *rowDescriptor = [self rowAtIndexPath:indexPath];
    CGFloat height = rowDescriptor.height;
    if (height > YIFormRowInitialHeight){
        return height;
    }
    return self.tableView.estimatedRowHeight;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    YIFormRow * rowDescriptor = self.sections[indexPath.section].rows[indexPath.row];
    return [self updateFormRow:rowDescriptor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = self.sections.count;
    return count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sections.count == 0) {
        return 0;
    }
    NSInteger count = self.sections[section].rows.count;
    return count;
}
// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (self.sections.count <= sectionIndex) {
        return nil;
    }
    YIFormSection *section = self.sections[sectionIndex];
    
    return section.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionIndex
{
    if (self.sections.count <= sectionIndex) {
        return nil;
    }
    YIFormSection *section = self.sections[sectionIndex];
    
    return section.footerView;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    YIFormSection *sourceSection = self.sections[sourceIndexPath.section];
    YIFormRow *item = sourceSection.rows[sourceIndexPath.row];
    [sourceSection removeRowsAt:[NSIndexSet indexSetWithIndex:sourceIndexPath.row]];
    
    YIFormSection *destinationSection = self.sections[destinationIndexPath.section];
    [destinationSection insertRow:item at:destinationIndexPath.row];
    
    if (item.moveCompletionHandler)
        item.moveCompletionHandler(item, sourceIndexPath, destinationIndexPath);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sections.count <= indexPath.section) {
        return NO;
    }
    YIFormSection *section = self.sections[indexPath.section];
    YIFormRow *item = section.rows[indexPath.row];
    if (item.disabled) {
        return NO;
    }
    return item.moveHandler != nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < [self.sections count]) {
        YIFormSection *section = self.sections[indexPath.section];
        if (indexPath.row < [section.rows count]) {
            YIFormRow *item = section.rows[indexPath.row];
            if ([item isKindOfClass:[YIFormRow class]]) {
                if (item.disabled) {
                    return NO;
                }
                return item.editingStyle != UITableViewCellEditingStyleNone || item.moveHandler;
            }
        }
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        YIFormSection *section = self.sections[indexPath.section];
        YIFormRow *item = section.rows[indexPath.row];
        if (item.deletionHandlerWithCompletion) {
            item.deletionHandlerWithCompletion(item, ^{
                [section removeRowsAt:[NSIndexSet indexSetWithIndex:indexPath.row]];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        } else {
            if (item.deletionHandler)
                item.deletionHandler(item);
            [section removeRowsAt:[NSIndexSet indexSetWithIndex:indexPath.row]];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
    
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        YIFormSection *section = self.sections[indexPath.section];
        YIFormRow *item = section.rows[indexPath.row];
        if (item.insertionHandler)
            item.insertionHandler(item);
        
        [section insertRow:[item copy] at:indexPath.row];
        __weak typeof(self) weak = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weak.tableView.editing = !weak.tableView.editing;
            weak.tableView.editing = !weak.tableView.editing;
        });
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        //        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //        UITableViewCell<YIFormCellProtocol> * cell = item.cell;
        //        if ([cell formDescriptorCellCanBecomeFirstResponder]){
        //            [cell formDescriptorCellBecomeFirstResponder];
        //        }
        
        
    }
}

#pragma mark -
#pragma mark Table view delegate

// Display customization

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    YIFormSection *section = self.sections[indexPath.section];
    YIFormRow *item = section.rows[indexPath.row];
    YIFormCell *formCell = (YIFormCell *)cell;
    UIColor *color = item.containerBackgroundColor;
    CGFloat cornerRadius = section.cornerRadius;
    if (cornerRadius == 0 ) {
        return;
    }
    formCell.separatorColor = UIColor.clearColor;
    
    cell.backgroundColor = UIColor.clearColor;
    CGRect bounds = CGRectInset(cell.bounds, section.horizontalInset, 0);
    CAShapeLayer *bgLayer = [self layerForTableView:tableView indexPath:indexPath bounds:bounds cornerRadius:cornerRadius containerViewBackgroundColor:color separatorColor:[self separatorColorFor:item] separatorStyle:item.separatorStyle separatorLeftInset:item.separatorLeftInset separatorRightInset:item.separatorRightInset];
    CAShapeLayer *selectedBgLayer = [self layerForTableView:tableView indexPath:indexPath bounds:bounds cornerRadius:cornerRadius containerViewBackgroundColor:color separatorColor:[self separatorColorFor:item] separatorStyle:item.separatorStyle separatorLeftInset:item.separatorLeftInset separatorRightInset:item.separatorRightInset];
    
    cell.backgroundView = [self viewWithLayer:bgLayer frame:bounds];
    cell.selectedBackgroundView = [self viewWithLayer:selectedBgLayer frame:bounds];
}

- (CAShapeLayer *)layerForTableView:(UITableView *)tableView
                     indexPath:(NSIndexPath *)indexPath
                        bounds:(CGRect)bounds
                  cornerRadius:(CGFloat)cornerRadius
                    containerViewBackgroundColor:(UIColor *)containerViewBackgroundColor
                separatorColor:(UIColor *)separatorColor
                separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
            separatorLeftInset:(CGFloat)separatorLeftInset
            separatorRightInset:(CGFloat)separatorRightInset
{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//    layer.backgroundColor = formCell.containerView.backgroundColor.CGColor;
//    formCell.containerView.backgroundColor = UIColor.clearColor;
    
    CGMutablePathRef pathRef = CGPathCreateMutable();

    BOOL addLine = NO;
    if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    } else if (indexPath.row == 0) {
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        addLine = YES;
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
    } else {
        CGPathAddRect(pathRef, nil, bounds);
        addLine = YES;
    }
    layer.path = pathRef;
    CFRelease(pathRef);
//    layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = containerViewBackgroundColor.CGColor;
    if (addLine == YES && separatorStyle == UITableViewCellSeparatorStyleSingleLine ) {
        CALayer *lineLayer = [[CALayer alloc] init];
        CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
        lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+separatorLeftInset, bounds.size.height-lineHeight, bounds.size.width-(separatorRightInset + separatorLeftInset), lineHeight);
        lineLayer.backgroundColor = separatorColor.CGColor;
        [layer addSublayer:lineLayer];
    }
    return layer;
}

- (UIView *)viewWithLayer:(CALayer *)layer frame:(CGRect)rect {
    UIView *testView = [[UIView alloc] initWithFrame:rect];
    [testView.layer insertSublayer:layer atIndex:0];
    return testView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    YIFormSection *formSection = self.sections[section];
    if (formSection.headerView) {
        return formSection.headerView.frame.size.height;
    }
    //    if (formSection.headerHeight != YIFormSectionHeaderHeightAutomatic) {
    return formSection.headerHeight;
    //    }
    
    
    //    return self.tableView.estimatedSectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    YIFormSection *formSection = self.sections[section];
    
    if (formSection.footerView) {
        return formSection.footerView.frame.size.height;
    }
    //    if (formSection.footerHeight != YIFormSectionFooterHeightAutomatic) {
    return formSection.footerHeight;
    //    }
    
    
    return self.tableView.estimatedSectionFooterHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (self.sections.count <= sectionIndex) {
        return UITableViewAutomaticDimension;
    }
    YIFormSection *section = self.sections[sectionIndex];
    if (section.headerView) {
        return section.headerView.frame.size.height;
        
    }
    //    if (section.headerHeight != YIFormSectionHeaderHeightAutomatic) {
    return section.headerHeight;
    //    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionIndex
{
    if (self.sections.count <= sectionIndex) {
        return UITableViewAutomaticDimension;
    }
    YIFormSection *section = self.sections[sectionIndex];
    if (section.footerView) {
        return section.footerView.frame.size.height;
    }
    //    if (section.footerHeight != YIFormSectionFooterHeightAutomatic) {
    return section.footerHeight;
    //    }
    
    return UITableViewAutomaticDimension;
}

// Accessories (disclosures).

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    YIFormSection *section = self.sections[indexPath.section];
    id item = section.rows[indexPath.row];
    if ([item respondsToSelector:@selector(setAccessoryButtonTapHandler:)]) {
        YIFormRow *actionItem = (YIFormRow *)item;
        if (actionItem.accessoryButtonTapHandler)
            actionItem.accessoryButtonTapHandler(item);
    }
}

// Selection
//
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{}
//
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{}
//
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return indexPath;
//}
//
//- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return indexPath;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YIFormSection *section = self.sections[indexPath.section];
    id item = section.rows[indexPath.row];
    if ([item respondsToSelector:@selector(setSelectionHandler:)]) {
        YIFormRow *actionItem = (YIFormRow *)item;
        if (actionItem.selectionHandler)
            actionItem.selectionHandler(item);
    }
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}

// Editing

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YIFormSection *section = self.sections[indexPath.section];
    YIFormRow *item = section.rows[indexPath.row];
    
    if (![item isKindOfClass:[YIFormRow class]])
        return UITableViewCellEditingStyleNone;
    
    return item.editingStyle;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"Delete", @"Delete");
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}
//
//- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
//{
//}

// Moving/reordering

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    YIFormSection *sourceSection = self.sections[sourceIndexPath.section];
    YIFormRow *item = sourceSection.rows[sourceIndexPath.row];
    if (item.moveHandler) {
        BOOL allowed = item.moveHandler(item, sourceIndexPath, proposedDestinationIndexPath);
        if (!allowed)
            return sourceIndexPath;
    }
    
    return proposedDestinationIndexPath;
}

// Indentation

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

// Copy/Paste.  All three methods must be implemented by the delegate.

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id anItem = self.sections[indexPath.section].rows[indexPath.row];
    
    if ([anItem respondsToSelector:@selector(setCopyHandler:)]) {
        YIFormRow *item = anItem;
        if (item.copyHandler || item.pasteHandler)
            return YES;
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    id anItem = self.sections[indexPath.section].rows[indexPath.row];
    if ([anItem respondsToSelector:@selector(setCopyHandler:)]) {
        YIFormRow *item = anItem;
        if (item.disabled) {
            return NO;
        }
        if (item.copyHandler && action == @selector(copy:))
            return YES;
        
        if (item.pasteHandler && action == @selector(paste:))
            return YES;
        
        if (item.cutHandler && action == @selector(cut:))
            return YES;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    YIFormRow *item = self.sections[indexPath.section].rows[indexPath.row];
    
    if (action == @selector(copy:)) {
        if (item.copyHandler)
            item.copyHandler(item);
    }
    
    if (action == @selector(paste:)) {
        if (item.pasteHandler)
            item.pasteHandler(item);
    }
    
    if (action == @selector(cut:)) {
        if (item.cutHandler)
            item.cutHandler(item);
    }
    
}

@end
