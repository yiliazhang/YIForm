//
//  YITableViewCell.h
//  YIForm_Example
//
//  Created by Yilia on 2020/10/27.
//  Copyright © 2020 yiliazhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YIFormRow.h"
NS_ASSUME_NONNULL_BEGIN

@interface YITableViewCell : UITableViewCell

@property (nonatomic, strong) __kindof YIFormRow * row;
@property (nonnull, strong, nonatomic) UILabel *messageLabel;
///
@property (nonnull, strong, nonatomic) UILabel *tipLabel;

- (void)configure;

- (void)update;
@end

NS_ASSUME_NONNULL_END
