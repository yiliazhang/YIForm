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
@protocol YIFormRowProtocol <NSObject>

@required

@property (nonatomic) BOOL disabled;
/// 对应的cell
@property (strong, nonatomic, readonly) YIFormCell *cell;
///
@property (nullable, strong, nonatomic) NSString *tag;

@property(nonatomic, strong, nullable) id value;
/// 行高 default is 44.0f
@property (nonatomic, assign) CGFloat height;
/// cell 内容与边缘间距
@property (nonatomic, assign) UIEdgeInsets contentEdgeMargins;
/// seperator style
@property (nonatomic) UITableViewCellSeparatorStyle seperatorStyle;

// cell class
@property (nonatomic, strong, readonly) id cellClass;

/// cell style
@property (nonatomic, assign  ) UITableViewCellStyle cellStyle;
// row 对应的值 更新后
@property (nonatomic, copy, nullable) YIOnChangeBlock onChangeBlock;


// RETableViewManager
@property (copy, readwrite, nonatomic) void (^selectionHandler)(__kindof YIFormRow *item);
@property (copy, readwrite, nonatomic) void (^accessoryButtonTapHandler)(__kindof YIFormRow *item);
@property (copy, readwrite, nonatomic) void (^insertionHandler)(__kindof YIFormRow *item);
@property (copy, readwrite, nonatomic) void (^deletionHandler)(__kindof YIFormRow *item);
@property (copy, readwrite, nonatomic) void (^deletionHandlerWithCompletion)(__kindof YIFormRow *item, void (^)(void));
@property (copy, readwrite, nonatomic) BOOL (^moveHandler)(YIFormRow *item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
@property (copy, readwrite, nonatomic) void (^moveCompletionHandler)(YIFormRow *item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
@property (copy, readwrite, nonatomic) void (^cutHandler)(__kindof YIFormRow *item);
@property (copy, readwrite, nonatomic) void (^copyHandler)(__kindof YIFormRow *item);
@property (copy, readwrite, nonatomic) void (^pasteHandler)(__kindof YIFormRow *item);


/// row 所在section
@property (nonatomic, weak, null_unspecified) YIFormSection *section;
@optional

//+(CGFloat)formDescriptorCellHeightForRowDescriptor:(__kindof YIFormRow *)row;
//-(BOOL)formDescriptorCellCanBecomeFirstResponder;
//-(BOOL)formDescriptorCellBecomeFirstResponder;
//-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller;
//-(NSString *)formDescriptorHttpParameterName;

//-(void)highlight;
//-(void)unhighlight;

@end


@interface YIFormRow : NSObject<YIFormRowProtocol>

//@property(nonatomic) BOOL hidden;
/// 是否 disabled 默认NO
@property (nonatomic) BOOL disabled;

///
@property (nullable, strong, nonatomic) NSString *tag;

/// title
@property (nonatomic, copy) NSString *title;

/// 值
@property(nonatomic, strong, nullable) __kindof id value;

/// 行高 default is 44.0f
@property (nonatomic, assign) CGFloat height;
/// cell 内缩进
@property (nonatomic, assign) UIEdgeInsets contentEdgeMargins;
/// 分割线 左 缩进
@property (nonatomic) CGFloat seperatorLeftInset;
/// 分割线 右 缩进
@property (nonatomic) CGFloat seperatorRightInset;


// XLForm

@property (nonatomic, assign  ) UITableViewCellStyle cellStyle;

@property (nonatomic, copy, nullable) YIOnChangeBlock onChangeBlock;
//@property (nonatomic, assign) BOOL useValueFormatterDuringInput;
//@property (nonatomic, strong, nullable) NSFormatter *valueFormatter;

//-(void)addValidator:(nullable id<XLFormValidatorProtocol>)validator;
//-(void)removeValidator:(nullable id<XLFormValidatorProtocol>)validator;

//@property (nonatomic, nullable, copy) NSString * noValueDisplayText;
//@property (nonatomic, nullable, copy) NSString * selectorTitle;
//@property (nonatomic, nullable, strong) NSArray * selectorOptions;

// RETableViewManager
@property (nonatomic) UITableViewCellSeparatorStyle seperatorStyle;
@property (assign, readwrite, nonatomic) UITableViewCellStyle style;
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
/// row 对应的cell
@property (strong, nonatomic, readonly) __kindof YIFormCell *cell;
/// row 所在section
@property (nonatomic, weak, null_unspecified) YIFormSection *section;
//- (__kindof YIFormCell *)cellForTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
