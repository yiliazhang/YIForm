//
//  YIFormRow.m
//  YIForm
//
//  Created by Yilia on 2020/10/12.
//

#import "YIFormRow.h"
#import "YIFormManager.h"
#import "YIFormSection.h"
CGFloat YIFormRowInitialHeight = -2;
@interface YIFormRow()<NSCopying>

@property(nonatomic) BOOL hidden;
///
@property (strong, nonatomic) __kindof YIFormCell *cell;

@property (nonatomic, assign) BOOL isDirtyDisablePredicateCache;
@property (nonatomic, copy  ) NSNumber *disablePredicateCache;
@property (nonatomic, assign) BOOL isDirtyHidePredicateCache;
@property (nonatomic, copy  ) NSNumber *hidePredicateCache;
@end



NSString * const XLValueKey = @"value";
NSString * const XLDisablePredicateCacheKey = @"disabled";
NSString * const XLHidePredicateCacheKey = @"hidden";

@implementation YIFormRow

-(void)dealloc
{
    [self removeObserver:self forKeyPath:XLValueKey];
    [self removeObserver:self forKeyPath:XLDisablePredicateCacheKey];
    [self removeObserver:self forKeyPath:XLHidePredicateCacheKey];
    
    _cell = nil;
}


-(instancetype)init {
    self = [super init];
    if (self) {
        _height = YIFormRowInitialHeight;
        _seperatorLeftInset = 0;
        _seperatorRightInset = 0;
//        _disabled = NO;
//        _hidden = @NO;
        _selectionStyle = UITableViewCellSelectionStyleDefault;
        _cellStyle = UITableViewCellStyleDefault;
        _seperatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _validators = [NSMutableArray new];
//        _cellConfig = [NSMutableDictionary dictionary];
//        _cellConfigIfDisabled = [NSMutableDictionary dictionary];
//        _cellConfigAtConfigure = [NSMutableDictionary dictionary];
        _isDirtyDisablePredicateCache = YES;
        _disablePredicateCache = nil;
        _isDirtyHidePredicateCache = YES;
        _hidePredicateCache = nil;
        _contentEdgeMargins = UIEdgeInsetsZero;
        [self addObserver:self
               forKeyPath:XLValueKey
                  options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:0];
        [self addObserver:self
               forKeyPath:XLDisablePredicateCacheKey
                  options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:0];
        [self addObserver:self
               forKeyPath:XLHidePredicateCacheKey
                  options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:0];
    }
    return self;
}

#pragma mark - KVO


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!self.section) {
        return;
    } else if (object == self &&
               ([keyPath isEqualToString:XLValueKey] ||
                [keyPath isEqualToString:XLHidePredicateCacheKey] ||
                [keyPath isEqualToString:XLDisablePredicateCacheKey])) {
        if ([[change objectForKey:NSKeyValueChangeKindKey] isEqualToNumber:@(NSKeyValueChangeSetting)]){
            id newValue = [change objectForKey:NSKeyValueChangeNewKey];
            id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
            if ([keyPath isEqualToString:XLValueKey]) {
                [self.section.formManager formRowValueHasChanged:object oldValue:oldValue newValue:newValue];
                if (self.onChangeBlock) {
                    self.onChangeBlock(oldValue, newValue, self);
                }
//            }
//            else {
//                [self.section.formManager.delegate formRowDescriptorPredicateHasChanged:object
//                                                                                            oldValue:oldValue
//                                                                                            newValue:newValue
//                                                                                       predicateType:([keyPath isEqualToString:XLHidePredicateCacheKey] ? XLPredicateTypeHidden : XLPredicateTypeDisabled)];
            }
        }
    }
}

+ (instancetype)rowWithTag:(nullable NSString *)tag {
    return [[YIFormRow alloc] initWithTag:tag];
}

- (instancetype)initWithTag:(nullable NSString *)tag {
    self = [self init];
    self.tag = tag;
    return self;
}


- (__kindof YIFormCell *)cellForTableView:(UITableView *)tableView {
    if (!_cell) {
        id cellClass = self.cellClass;
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *cellClassString = cellClass;
        NSString *cellResource = nil;
        
        if ([cellClass isKindOfClass:[NSString class]]) {
            if ([cellClassString rangeOfString:@"/"].location != NSNotFound) {
                NSArray *components = [cellClassString componentsSeparatedByString:@"/"];
                cellResource = [components lastObject];
                NSString *folderName = [components firstObject];
                NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:folderName];
                bundle = [NSBundle bundleWithPath:bundlePath];
            } else {
                cellResource = [cellClassString componentsSeparatedByString:@"."].lastObject;
            }
        } else {
            cellResource = [NSStringFromClass(cellClass) componentsSeparatedByString:@"."].lastObject;
        }
        NSString *reuseIdentifier = [cellClass reuseIdentifier];
        _cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!_cell) {
            _cell = [[cellClass alloc] initWithStyle:self.cellStyle reuseIdentifier:[cellClass reuseIdentifier]];
        }
    }
    _cell.row = self;
    
    if (self.accessoryView) {
        _cell.accessoryView = self.accessoryView;
    }
    return _cell;
}

- (__kindof YIFormCell *)cell {
    if (!_cell) {
        id cellClass = self.cellClass;
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *cellClassString = cellClass;
        NSString *cellResource = nil;
        
        if ([cellClass isKindOfClass:[NSString class]]) {
            if ([cellClassString rangeOfString:@"/"].location != NSNotFound) {
                NSArray *components = [cellClassString componentsSeparatedByString:@"/"];
                cellResource = [components lastObject];
                NSString *folderName = [components firstObject];
                NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:folderName];
                bundle = [NSBundle bundleWithPath:bundlePath];
            } else {
                cellResource = [cellClassString componentsSeparatedByString:@"."].lastObject;
            }
        } else {
            cellResource = [NSStringFromClass(cellClass) componentsSeparatedByString:@"."].lastObject;
        }
        
//        _cell = [[cellClass alloc] initWithStyle:self.cellStyle reuseIdentifier:[cellClass reuseIdentifier]];
        _cell = [[cellClass alloc] initWithStyle:self.cellStyle reuseIdentifier:nil];
        
    }
    _cell.row = self;
    _cell.accessoryType = self.accessoryType;
    if (self.accessoryView) {
        _cell.accessoryView = self.accessoryView;
    }
    _cell.selectionStyle = self.disabled ? UITableViewCellSelectionStyleNone : self.selectionStyle;
    return _cell;
}

// In the implementation
-(id)copyWithZone:(NSZone *)zone
{
    YIFormRow *rowDescriptorCopy = [[YIFormRow alloc] init];
    rowDescriptorCopy.title = [self.title copy];
//    [rowDescriptorCopy.cellConfig addEntriesFromDictionary:self.cellConfig];
//    [rowDescriptorCopy.cellConfigAtConfigure addEntriesFromDictionary:self.cellConfigAtConfigure];
//    rowDescriptorCopy.valueTransformer = [self.valueTransformer copy];
    rowDescriptorCopy.hidden = self.hidden;
    rowDescriptorCopy.disabled = self.disabled;
//    rowDescriptorCopy.required = self.isRequired;
    rowDescriptorCopy.isDirtyDisablePredicateCache = YES;
    rowDescriptorCopy.isDirtyHidePredicateCache = YES;
//    rowDescriptorCopy.validators = [self.validators mutableCopy];
    
    // =====================
    // properties for Button
    // =====================
//    rowDescriptorCopy.action = self.action;
    
    
    // ===========================
    // property used for Selectors
    // ===========================
    
//    rowDescriptorCopy.noValueDisplayText = [self.noValueDisplayText copy];
//    rowDescriptorCopy.selectorTitle = [self.selectorTitle copy];
//    rowDescriptorCopy.selectorOptions = [self.selectorOptions copy];
//    rowDescriptorCopy.leftRightSelectorLeftOptionSelected = [self.leftRightSelectorLeftOptionSelected copy];
    
    return rowDescriptorCopy;
}

- (id)cellClass {
    return YIFormCell.class;
}

- (BOOL)disabled {
    if (self.section.disabled) {
        return YES;
    }
    return _disabled;
}
@end
