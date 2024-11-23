//
//  GWAuthInfoCell.m
//  SoamO2OEngineer
//
//  Created by Yilia on 2020/10/23.
//  Copyright © 2020 Yilia. All rights reserved.
//

#import "GWAuthInfoCell.h"
#import "ViewFactory.h"
#import "UIView+GWReoundRect.h"

#import <Masonry/Masonry.h>
@implementation GWAuthInfoRow

- (id)cellClass {
    return [GWAuthInfoCell class];
}

@end

@interface GWAuthInfoCell()
///
//@property (nonnull, strong, nonatomic) UITextView *messageLabel;
/////
//@property (nonnull, strong, nonatomic) UITextView *tipLabel;
@end

@implementation GWAuthInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configure {
    [super configure];
    
    
    
    [self.containerView addSubview:self.messageLabel];
    [self.containerView addSubview:self.tipLabel];
    
    
    self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.messageLabel.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:10].active = YES;
    [self.messageLabel.topAnchor constraintEqualToAnchor:self.containerView.topAnchor constant:10].active = YES;
    [self.messageLabel.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor constant:-10].active = YES;

    self.tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tipLabel.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:10].active = YES;
    [self.tipLabel.topAnchor constraintEqualToAnchor:self.messageLabel.bottomAnchor constant:10].active = YES;
    [self.tipLabel.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor constant:-10].active = YES;
    [self.tipLabel.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor constant:-10].active = YES;
    
    
    
    
    
}

- (void)update {
    [super update];
    
//    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(@10);
//        make.width.equalTo(@30);
//        make.right.equalTo(@(-15));
//    }];
//    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.messageLabel.mas_bottom);
//        make.left.right.equalTo(self.messageLabel);
//        make.height.equalTo(@30);
//        make.width.equalTo(@130);
//        make.bottom.equalTo(@(-10));
//    }];
    GWAuthInfoRow *row = self.row;
    self.messageLabel.text = row.message;
    self.tipLabel.text = row.tip;
    self.contentView.backgroundColor = [UIColor redColor];
//    if (row.cornerRadius > 0) {
//        [self.containerView roundRectWithRadius:row.cornerRadius];
//    }
}


- (UITextView *)messageLabel {
    if (!_messageLabel) {
//        UITextView *label = [ViewFactory textViewWithText:@"" font:[UIFont systemFontOfSize:14] textColor:UIColor.yellowColor textAlignment:NSTextAlignmentLeft];
//        label.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
        UILabel *label = [ViewFactory labelWithText:@"" font:[UIFont systemFontOfSize:14] textColor:UIColor.blueColor textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = UIColor.whiteColor;
        label.numberOfLines = 0;
        _messageLabel = label;
    }
    return _messageLabel;
}

- (UITextView *)tipLabel {
    if (!_tipLabel) {
//        UITextView *label = [ViewFactory textViewWithText:@"" font:[UIFont systemFontOfSize:13] textColor:UIColor.greenColor textAlignment:NSTextAlignmentLeft];
//        label.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
        UILabel *label = [ViewFactory labelWithText:@"" font:[UIFont systemFontOfSize:14] textColor:UIColor.blackColor textAlignment:NSTextAlignmentLeft];
        label.backgroundColor = UIColor.whiteColor;
        label.numberOfLines = 0;
        _tipLabel = label;
    }
    return _tipLabel;
}

@end
