//
//  YIFormRow.h
//  YIForm
//
//  Created by Yilia on 2020/10/12.
//

#import <Foundation/Foundation.h>
#import "YIFormCell.h"
@class YIFormAction;
@class YIFormSection;
NS_ASSUME_NONNULL_BEGIN

extern CGFloat YIFormRowInitialHeight;

typedef void(^YIOnChangeBlock)(id __nullable oldValue, id __nullable newValue, YIFormRow * row);

@interface YIFormRow : NSObject

//@property(nonatomic) BOOL hidden;
/// 是否 disabled 默认NO
@property (nonatomic) BOOL disabled;
/// 是否 required 默认NO
@property (nonatomic) BOOL required;

///
@property (nullable, strong, nonatomic) NSString *tag;

/// title
@property (nullable, nonatomic, copy) NSString *title;

/// 对应的cell
@property (nonnull, strong, nonatomic, readonly) Class cellClass;
/// 当前cellclass
@property (strong, nonatomic, readonly) Class currentCellClass;
/// 值
@property(nonatomic, strong, nullable) id value;

/// 行高 default is 44.0f
@property (nonatomic, assign) CGFloat height;
/// cell 内缩进
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
/// 分割线 左 缩进
@property (nonatomic) CGFloat separatorLeftInset;
/// 分割线 右 缩进
@property (nonatomic) CGFloat separatorRightInset;
/// 自动刷新 默认 NO
@property (nonatomic) BOOL autoRefresh;
// XLForm

@property (nonatomic, assign  ) UITableViewCellStyle cellStyle;

@property (nonatomic, copy, nullable) YIOnChangeBlock onChangeBlock;

@property (nonatomic, strong) NSMutableDictionary * cellConfig;
//@property (nonatomic, strong) NSMutableDictionary * cellConfigForSelector;
@property (nonatomic, strong) NSMutableDictionary * cellConfigIfDisabled;
@property (nonatomic, strong) NSMutableDictionary * cellConfigAtConfigure;

// RETableViewManager
///
@property (strong, nonatomic) UIColor *containerBackgroundColor;
///
@property (nullable, strong, nonatomic) UIColor *separatorColor;
@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle;
@property (assign, readwrite, nonatomic) UITableViewCellSelectionStyle selectionStyle;
@property (assign, readwrite, nonatomic) UITableViewCellAccessoryType accessoryType;
@property (assign, readwrite, nonatomic) UITableViewCellEditingStyle editingStyle;
@property (strong, readwrite, nonatomic) UIView *accessoryView;

@property (copy, nonatomic) void (^selectionHandler)(__kindof YIFormRow *item);

@property (copy, nonatomic) void (^accessoryButtonTapHandler)(__kindof YIFormRow *item);
@property (copy, nonatomic) void (^insertionHandler)(__kindof YIFormRow *item);
// deletionHandler deletionHandlerWithCompletion 配置 二选一
@property (copy, nonatomic) void (^deletionHandler)(__kindof YIFormRow *item);
@property (copy, nonatomic) void (^deletionHandlerWithCompletion)(__kindof YIFormRow *item, void (^)(void));
@property (copy, readwrite, nonatomic) BOOL (^moveHandler)(YIFormRow *item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
@property (copy, readwrite, nonatomic) void (^moveCompletionHandler)(YIFormRow *item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
@property (copy, readwrite, nonatomic) void (^cutHandler)(__kindof YIFormRow *item);
@property (copy, readwrite, nonatomic) void (^copyHandler)(__kindof YIFormRow *item);
@property (copy, readwrite, nonatomic) void (^pasteHandler)(__kindof YIFormRow *item);

/// row 对应 indexPath
@property (strong, nonatomic, readonly) NSIndexPath *indexPath;
/// row 对应的cell
@property (strong, nonatomic, readonly) __kindof YIFormCell *cell;
/// row 所在section
@property (nonatomic, weak, null_unspecified) YIFormSection *section;

- (void)reload;

/// special cell class init
/// @param cellClass subclass of YIFormCell
- (instancetype)initWithCellClass:(Class)cellClass;

+ (instancetype)row;

+ (instancetype)rowWithCellClass:(Class)cellClass;

+ (instancetype)rowWithContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets;

+ (instancetype)rowWithCellClass:(nullable Class)cellClass title:(nullable NSString *)title value:(nullable NSString *)value contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets;
@end

NS_ASSUME_NONNULL_END
