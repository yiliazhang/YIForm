//
//  YIFormSection.h
//  YIForm
//
//  Created by Yilia on 2020/10/12.
//

#import <Foundation/Foundation.h>
#import "YIFormRow.h"


extern CGFloat const YIFormSectionHeaderHeightAutomatic;
extern CGFloat const YIFormSectionFooterHeightAutomatic;

@class YIFormManager;
NS_ASSUME_NONNULL_BEGIN

@interface YIFormSection : NSObject
/// 默认 NO
@property (nonatomic, assign) BOOL disabled;
///
@property (strong, nonatomic, nullable) NSString *tag;
/// 对应的rows
@property (strong, nonatomic, readonly) NSArray<__kindof YIFormRow *> *rows;
/**
 A view object to display in the header of the specified section of the table view.
 */
@property (strong, readwrite, nonatomic) UIView *headerView;

/**
 A view object to display in the footer of the specified section of the table view.
 */
@property (strong, readwrite, nonatomic) UIView *footerView;

/**
 The height of the header of the specified section of the table view.
 */
@property (assign, readwrite, nonatomic) CGFloat headerHeight;

/**
 The height of the footer of the specified section of the table view.
 */
@property (assign, readwrite, nonatomic) CGFloat footerHeight;
/**
 Section index in UITableView.
 */
@property (assign, readonly, nonatomic) NSUInteger index;

/// section 圆 半径
@property (nonatomic) CGFloat cornerRadius;

/// 对应的 formManager
@property (nonatomic, weak, null_unspecified) YIFormManager * formManager;

/// 添加 rows
/// @param rows 数组
- (instancetype)addRows:(NSArray<__kindof YIFormRow *> *)rows;

/// 删除rows
/// @param rows 数组
- (instancetype)removeRows:(NSArray<__kindof YIFormRow *> *)rows;

/// 删除对应的indexes 的rows
/// @param indexes 数组
- (instancetype)removeRowsAt:(NSIndexSet *)indexes;

/// 在 index 处插入 row
/// @param row row
/// @param index index
- (void)insertRow:(__kindof YIFormRow *)row at:(NSInteger)index;

/// tags 对应的row
/// @param tags tags 数组
- (NSArray<YIFormRow *> *)rowsWithTags:(NSArray<NSString *> *)tags;

/// tag 对应的row
/// @param tag tag
- (nullable __kindof YIFormRow *)rowWithTag:(NSString *)tag;

/// cell 内容与边缘间距
@property (nonatomic, assign) CGFloat horizontalInset;


@end

NS_ASSUME_NONNULL_END
