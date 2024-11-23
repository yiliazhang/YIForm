//
//  UIView+GWReoundRect.h
//  SoamO2OEngineer
//
//  Created by apple on 2020/7/16.
//  Copyright © 2020 Yilia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GWReoundRect)

- (void)roundRectWithRadius:(CGFloat)radius shadowColor:(UIColor *)shodowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius;


/// ///  subView 需要调用 clipToBounds
/// @param radius 半径
/// @param borderWidth 边宽
/// @param borderColor 边颜色
/// @param shodowColor 阴影 色
/// @param shadowOffset 阴影 偏量
/// @param shadowOpacity 阴影 透明度
/// @param shadowRadius  阴影 半径
- (void)roundRectWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor shadowColor:(UIColor *)shodowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius;

- (void)roundRectWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

- (void)roundRectWithRadius:(CGFloat)radius;
@end

NS_ASSUME_NONNULL_END
