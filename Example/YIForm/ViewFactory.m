//
//  ViewFactory.m
//  SoamO2OClient
//
//  Created by apple on 2020/8/17.
//  Copyright © 2020 Goldwind. All rights reserved.
//

#import "ViewFactory.h"

#import <Masonry/Masonry.h>
@implementation ViewFactory

/// 创建 label
/// @param text 文本内容
/// @param font 字体
/// @param color 字体颜色
/// @param textAlignment 对其方式
+ (UILabel *)labelWithText:(NSString *)text font:(UIFont * _Nullable)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = UILabel.new;
    label.text = text;
    label.font = font;
    label.textColor = color;
    label.textAlignment = textAlignment;
    //    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

/// 创建 imageView
/// @param imageName 图片名称
+ (UIImageView *)imageViewWithImageName:(NSString *)imageName {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: imageName]];
    return imageView;
}

/// 创建通用 button
/// @param title 标题
/// @param target <#target description#>
/// @param action <#action description#>
+ (UIButton *)buttonWithTitle:(NSString *)title target:(nullable id)target action:(SEL)action {
    UIButton *button = UIButton.new;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#0d7ce3"]] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title target:(nullable id)target action:(SEL)action titleColor:(UIColor *)titleColor titleFont:(UIFont *)font backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius {
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/// 通用 footer button
/// @param title button title
/// @param target
/// @param action 
+ (UIView *)footerButtonViewWithTitle:(nullable NSString *)title target:(nullable id)target action:(SEL)action {
    UIView *view = [[UIView alloc] init];
    UIButton *button = [ViewFactory buttonWithTitle:title target:target action:action];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.height.equalTo(@45);
        make.bottom.equalTo(@(-10));
    }];
    return view;
}

+ (UITextView *)textViewWithText:(nullable NSString *)text font:(UIFont * _Nullable)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment {
    UITextView *textView = [[UITextView alloc] init];
    textView.text = text;
    textView.font = font;
    textView.textColor = color;
    textView.textAlignment = textAlignment;
    textView.editable = NO;
    textView.scrollEnabled = NO;
    return textView;
}

@end
