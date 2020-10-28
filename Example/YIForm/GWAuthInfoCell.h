//
//  GWAuthInfoCell.h
//  SoamO2OEngineer
//
//  Created by Yilia on 2020/10/23.
//  Copyright © 2020 Goldwind. All rights reserved.
//

#import "YIFormCell.h"
#import <YIForm.h>
NS_ASSUME_NONNULL_BEGIN
@interface GWAuthInfoRow : YIFormRow
/// message
@property (nonatomic, copy) NSString *message;
/// tip
@property (nonatomic, copy) NSString *tip;
///
@property (nonatomic) NSInteger cornerRadius;
///
@property (nonnull, strong, nonatomic) UIColor *contentViewBackgroundColor;
@end

@interface GWAuthInfoCell : YIFormCell

///
@property (nonnull, strong, nonatomic) UITextView *messageLabel;
///
@property (nonnull, strong, nonatomic) UITextView *tipLabel;
@end

NS_ASSUME_NONNULL_END
