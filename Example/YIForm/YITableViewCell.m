//
//  YITableViewCell.m
//  YIForm_Example
//
//  Created by Yilia on 2020/10/27.
//  Copyright © 2020 yiliazhang. All rights reserved.
//

#import "YITableViewCell.h"
#import "ViewFactory.h"
#import "UIView+GWReoundRect.h"

#import <Masonry/Masonry.h>

#import "GWAuthInfoCell.h"
@interface YITableViewCell()
@end

@implementation YITableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.messageLabel];
        [self.contentView addSubview:self.tipLabel];
        
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.equalTo(@0);
//            make.left.equalTo(@(40));
//            make.right.equalTo(@(-40));
//        }];
//
//
//        self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.messageLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = YES;
//        [self.messageLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10].active = YES;
//        [self.messageLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10].active = YES;
//
//        self.tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.tipLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:10].active = YES;
//        [self.tipLabel.topAnchor constraintEqualToAnchor:self.messageLabel.bottomAnchor constant:10].active = YES;
//        [self.tipLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-10].active = YES;
//        [self.tipLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-10].active = YES;
//
//
//
//        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
//        [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
//        [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
//        [self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:40].active = YES;
//        [self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-40].active = YES;
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.equalTo(@10);
                    make.right.equalTo(@(-10));
        }];
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self.messageLabel);
                    make.top.equalTo(self.messageLabel.mas_bottom);
                    make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
        
        
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    self.contentView.frame = CGRectMake(40, 0, frame.size.width - 80, frame.size.height);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)update {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(@(40));
        make.right.equalTo(@(-40));
    }];
    
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


- (UILabel *)messageLabel {
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

- (UILabel *)tipLabel {
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
