//
//  YIOneViewController.h
//  YIForm_Example
//
//  Created by Yilia on 2020/10/26.
//  Copyright © 2020 yiliazhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YIPopViewController : UIViewController
// 是否 隐藏 关闭按钮 默认 NO
@property(nonatomic) BOOL hideCloseButton;
// 容器view ,子view 在其中布局
@property (nonatomic, strong) UIView *containerView;
/// 关闭
@property (nonatomic, nonnull) void (^closeActionBlock)(void);

// 布局
- (void)setupView;
// 显示
- (void)showOnViewController:(UIViewController *)viewController;
// 消失
- (void)dismissCompletion:(void (^ __nullable)(void))completion;
// 关闭
- (IBAction)closeAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
