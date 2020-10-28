//
//  YIFormCell.h
//  YIForm
//
//  Created by Yilia on 2020/10/12.
//

#import <UIKit/UIKit.h>

@class YIFormRow;

NS_ASSUME_NONNULL_BEGIN
@protocol YIFormCellProtocol <NSObject>

@required



//-(BOOL)formDescriptorCellCanBecomeFirstResponder;
//-(BOOL)formDescriptorCellBecomeFirstResponder;
//-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller;

//-(void)highlight;

//-(void)unhighlight;




@end

@interface YIFormCell : UITableViewCell<YIFormCellProtocol>
@property (strong, nonatomic, readonly) UIView *containerView;
///
//@property (nonnull, strong, nonatomic, readonly) UIView *customContentView;
///
@property (strong, nonatomic) UIColor *separatorColor;
@property (nonatomic, weak) __kindof YIFormRow * row;

/// top 距 tableview 缩进
@property (nonatomic, readonly) CGFloat topMargin;
/// left 距 tableview 缩进
@property (nonatomic, readonly) CGFloat leftMargin;

/// right 距 tableview 缩进
@property (nonatomic, readonly) CGFloat rightMargin;

/// bottom 距 tableview 缩进
@property (nonatomic, readonly) CGFloat bottomMargin;
/// 分割线 左 距 tableview 缩进
@property (nonatomic, readonly) CGFloat separatorLeftMargin;

/// 分割线 右 距 tableview 缩进
@property (nonatomic, readonly) CGFloat separatorRightMargin;

/// 初始化配置 添加UI 布局等
-(void)configure;

/// 更新数据 或 UI布局
-(void)update;

@end

NS_ASSUME_NONNULL_END
