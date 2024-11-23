//
//  UIView+GWReoundRect.m
//  SoamO2OEngineer
//
//  Created by apple on 2020/7/16.
//  Copyright © 2020 Yilia. All rights reserved.
//

#import "UIView+GWReoundRect.h"

@implementation UIView (GWReoundRect)

/// ///  subView 需要调用 clipToBounds
/// @param radius <#radius description#>
/// @param shodowColor <#shodowColor description#>
/// @param shadowOffset <#shadowOffset description#>
/// @param shadowOpacity <#shadowOpacity description#>
/// @param shadowRadius <#shadowRadius description#>
- (void)roundRectWithRadius:(CGFloat)radius shadowColor:(UIColor *)shodowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius {
    NSAssert(![self.backgroundColor isEqual:[UIColor clearColor]], @"请设置背景色");
    self.layer.cornerRadius = radius;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowColor = shodowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
}



- (void)roundRectWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor shadowColor:(UIColor *)shodowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius {
    NSAssert(![self.backgroundColor isEqual:[UIColor clearColor]], @"请设置背景色");
    self.layer.cornerRadius = radius;
    self.layer.shadowOffset = shadowOffset;
    self.layer.shadowColor = shodowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
    
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)roundRectWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
    [self roundRectWithRadius:radius];
}

- (void)roundRectWithRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

@end
