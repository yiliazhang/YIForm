//
//  ViewFactory.h
//  SoamO2OClient
//
//  Created by apple on 2020/8/17.
//  Copyright © 2020 Goldwind. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewFactory : NSObject

/// 创建 label
/// @param text 文本内容
/// @param font 字体
/// @param color 字体颜色
/// @param textAlignment 对其方式
+ (UILabel *)labelWithText:(nullable NSString *)text font:(UIFont * _Nullable)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;

+ (UITextView *)textViewWithText:(nullable NSString *)text font:(UIFont * _Nullable)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment;
/// 创建 imageView
/// @param imageName 图片名称
+ (UIImageView *)imageViewWithImageName:(nullable NSString *)imageName;

/// 创建通用 button
/// @param title 标题
/// @param target
/// @param action <#action description#>
+ (UIButton *)buttonWithTitle:(nullable NSString *)title target:(nullable id)target action:(SEL)action;

/// Description
/// @param title <#title description#>
/// @param target <#target description#>
/// @param action <#action description#>
/// @param backgroundColor <#backgroundColor description#>
/// @param titleColor <#titleColor description#>
/// @param font <#font description#>
/// @param cornerRadius 圆角半径
+ (UIButton *)buttonWithTitle:(NSString *)title target:(nullable id)target action:(SEL)action titleColor:(UIColor *)titleColor titleFont:(UIFont *)font backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius;

/// 通用 footer button
/// @param title button title
/// @param target
/// @param action 
+ (UIView *)footerButtonViewWithTitle:(nullable NSString *)title target:(nullable id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
