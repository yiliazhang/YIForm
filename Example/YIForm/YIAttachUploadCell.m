//
//  YIAttachUploadCell.m
//  YIForm_Example
//
//  Created by Yilia on 2020/10/15.
//  Copyright © 2020 yiliazhang. All rights reserved.
//

#import "YIAttachUploadCell.h"
#import <YIFormManager.h>
#import "YIAttachFormRow.h"
@import Masonry;
@interface YIAttachUploadCell()
///
@property (nonnull, strong, nonatomic) UIButton *uploadButton;
///
@property (nonnull, strong, nonatomic) UIButton *fileButton;
///
@property (nonnull, strong, nonatomic) UILabel *titleLabel;
@end
@implementation YIAttachUploadCell
+ (NSString *)reuseIdentifier {
    static NSString *reuseIdentifier = @"YIAttachUploadCell";
    return reuseIdentifier;
}

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
    //self.accessoryType = UITableViewCellAccessoryNone;
    [self.contentView addSubview:self.uploadButton];
    [self.contentView addSubview:self.fileButton];
    [self.contentView addSubview:self.titleLabel];
    
    
    [self.fileButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.top.equalTo(@15);
            make.bottom.equalTo(@(-15));
        make.width.equalTo(@150);
            make.height.equalTo(@60).priorityHigh();
    }];
    
    [self.uploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fileButton);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.right.equalTo(self.fileButton.mas_left).offset(-5);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.uploadButton.mas_left);
    }];
}

- (void)update {
    [super update];
    YIAttachFormRow *row = (YIAttachFormRow *)self.row;
    NSArray *files = row.value;
    NSString *title = files.count > 0 ? @"已上传" : @"暂无文件";
    
    self.titleLabel.text = self.row.title;
    [self.fileButton setTitle:title forState:UIControlStateNormal];
}

// 刷新
- (IBAction)fileAction:(id)sender {
    
    YIAttachFormRow *row = self.row;
    if (row.value) {
        // TODO: - preview
        if (row.previewBlock) {
            row.previewBlock(row);
        }
    } else {
        [self uploadAction:sender];
    }
}

- (IBAction)uploadAction:(id)sender {
    YIAttachFormRow *row = self.row;
    if (row.uploadBlock) {
        row.uploadBlock(row);
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = [UIColor redColor];
    }
    return _titleLabel;
                       
}

- (UIButton *)uploadButton {
    if (!_uploadButton) {
        UIButton *button = [self buttonWithTitle:@"" imageName:@"authentication_uploadPic" backgroundImageName:nil target:self selector:@selector(uploadAction:)];
        _uploadButton = button;
    }
    return _uploadButton;;
}

- (UIButton *)fileButton {
    if (!_fileButton) {
        UIButton *button = [self buttonWithTitle:@"请上传文件" imageName:nil backgroundImageName:nil target:self selector:@selector(fileAction:)];
        [button setBackgroundColor:[UIColor greenColor]];
        _fileButton = button;
    }
    return _fileButton;;
}

- (nonnull UIButton *)buttonWithTitle:(nullable NSString *)title
                       imageName:(nullable NSString *)imageName
             backgroundImageName:(nullable NSString *)backgroundImageName
                          target:(nullable id)target
                        selector:(nullable SEL)sel {
    UIButton *button = UIButton.new;
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (backgroundImageName) {
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    }
    if (title) {
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (target && sel) {
        [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
@end
