//
//  YIFormManager.h
//  YIForm
//
//  Created by Yilia on 2020/10/12.
//

#import <Foundation/Foundation.h>
#import "YIFormMacro.h"

NS_ASSUME_NONNULL_BEGIN

/// 创建 section
FOUNDATION_EXPORT __kindof YIFormSection *Section(void);
/// 创建 row
/// @param rowClass row class
FOUNDATION_EXPORT __kindof YIFormRow *Row(id rowClass);


typedef NS_ENUM(NSUInteger, XLPredicateType) {
    XLPredicateTypeDisabled = 0,
    XLPredicateTypeHidden
};

@interface YIFormManager : NSObject
// 默认 NO
@property (nonatomic) BOOL disabled;
/// 对应tableView
@property (nullable, weak, nonatomic, readonly) UITableView *tableView;

/// 初始化方法
/// @param tableView  tableView
+ (instancetype)managerForTableView:(UITableView *)tableView;

/// 初始化方法
/// @param tableView  tableView
- (instancetype)initWithTableView:(UITableView *)tableView;


// MARK: - 刷新

/// 重新加载 sections
/// @param sections section 数组
- (void)reloadSections:(NSArray<YIFormSection *> *)sections;
/// 重新加载
/// @param rows row 数组
- (void)reloadRows:(NSArray<YIFormRow *> *)rows;

/// 重新加载 sections
/// @param indexes indexes
- (void)reloadSectionsAt:(NSIndexSet *)indexes;

/// 重新加载
/// @param indexPaths indexPaths
- (void)reloadRowsAt:(NSArray<NSIndexPath *> *)indexPaths;

// MARK: - 检索
/// <#Description#>
/// @param row <#row description#>
-(NSIndexPath *)indexPathForRow:(YIFormRow *)row;

-(NSUInteger)indexForSection:(YIFormSection *)section;
///
/// tag 对应 section
/// @param tag section tag
- (nullable YIFormSection *)sectionWithTag:(NSString *)tag;
/// tag 对应 row
/// @param tag row tag
- (nullable __kindof YIFormRow *)rowWithTag:(NSString *)tag;

/// indexPath 对应的 row
/// @param indexPath indexPath
- (nullable YIFormRow *)rowAtIndexPath:(NSIndexPath *)indexPath;
// MARK: - 增 删

/// 添加 sections
/// @param sections section 数组
- (void)addSections:(NSArray<YIFormSection *> *)sections;
/// 移除 sections
/// @param sections section 数组
- (void)removeSections:(NSArray<YIFormSection *> *)sections;
/// 移除indexes 对应的 sections
/// @param indexes index 数组
- (void)removeSectionsAt:(NSIndexSet *)indexes;

/// 移除所有
- (void)removeAll;

/// 移除 row
/// @param formRow row
-(void)removeRow:(YIFormRow *)formRow;

/// 移除 tag 对应的 row
/// @param tag row tag
-(void)removeRowWithTag:(nonnull NSString *)tag;

// MARK: -

/// @param formRow formRow
/// @param oldValue oldValue
/// @param newValue newValue
-(void)formRowValueHasChanged:(YIFormRow *)formRow oldValue:(id)oldValue newValue:(id)newValue;
@end

NS_ASSUME_NONNULL_END
