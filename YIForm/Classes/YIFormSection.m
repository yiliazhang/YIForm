//
//  YIFormSection.m
//  YIForm
//
//  Created by Yilia on 2020/10/12.
//

#import "YIFormSection.h"


CGFloat const YIFormSectionHeaderHeightAutomatic = 0.01;
CGFloat const YIFormSectionFooterHeightAutomatic = 0.01;
@interface YIFormSection()

//@property(nonatomic, assign) BOOL hidden;
///
@property (nonnull, strong, nonatomic) NSMutableArray<__kindof YIFormRow *> *rows;
@end


@implementation YIFormSection

- (instancetype)init {
    self = [super init];
    if (self) {
        _rows = [NSMutableArray array];
        _headerHeight = YIFormSectionHeaderHeightAutomatic;
        _footerHeight = YIFormSectionFooterHeightAutomatic;
        _cornerRadius = 0;
        _horizontalInset = 0;
    }
    return self;
}

- (void)removeRows:(NSArray<__kindof YIFormRow *> * _Nonnull)rows {
    if (rows.count == 0) {
        return;
    }
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    for (NSUInteger index = 0; index < self.rows.count; index++) {
        YIFormRow *row = self.rows[index];
        if ([rows containsObject:row]) {
            [indexSet addIndex:index];
        }
    }
    
    if (indexSet.count > 0) {
        [_rows removeObjectsAtIndexes:indexSet];
    }
}

- (void)addRows:(NSArray<__kindof YIFormRow *> * _Nonnull)rows {
    if (rows.count == 0) {
        return;
    }
    
    for (YIFormRow *row in rows) {
        row.section = self;
    }
    
    [_rows addObjectsFromArray:rows];
}

- (void)removeRowsAt:(NSIndexSet *)indexes {
    if (indexes.count == 0) {
        return;
    }
    [_rows removeObjectsAtIndexes:indexes];
}

- (void)insertRow:(__kindof YIFormRow *)row at:(NSInteger)index {
    if (!row) {
        return;
    }
    [_rows insertObject:row atIndex:index];
}

/// 所有的tags
- (NSArray *)rowTags {
    NSMutableSet *tags = [NSMutableSet set];
    [self.rows enumerateObjectsUsingBlock:^(__kindof YIFormRow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag) {
            [tags addObject:obj.tag];
        }
    }];
    return [tags allObjects];
}

- (NSArray<__kindof YIFormRow *> *)rowsWithTags:(NSArray<NSString *> *)tags {
    NSMutableArray *rows = [NSMutableArray array];
    for (NSString *tag in tags) {
        YIFormRow *row = [self rowWithTag:tag];
        if (row) {
            [rows addObject:row];
        }
    }
    return [rows copy];
}

- (__kindof YIFormRow *)rowWithTag:(NSString *)tag {
    for (__kindof YIFormRow *row in self.rows) {
        if ([row.tag isEqualToString:tag]) {
            
            return row;
        }
    }
    return nil;
}

- (NSArray<__kindof YIFormRow *> *)rows {
    return [_rows copy];
}

- (void)reload {
//    [self.formManager r];
}
@end
