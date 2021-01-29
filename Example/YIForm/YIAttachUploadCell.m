//
//  YIAttachUploadCell.m
//  YIForm_Example
//
//  Created by Yilia on 2020/10/15.
//  Copyright © 2020 yiliazhang. All rights reserved.
//

#import "YIAttachUploadCell.h"
#import <YIFormManager.h>
#import "UIView+GWReoundRect.h"

#define kUploadAttachmentsURLDocumentTypes @[@"com.microsoft.word.docx", @"org.openxmlformats.wordprocessingml.document", @"org.openxmlformats.spreadsheetml.sheet", @"org.openxmlformats.presentationml.presentation", @"com.microsoft.word.doc", @"com.microsoft.powerpoint.ppt", @"com.adobe.pdf", @"com.microsoft.powerpoint.​pptx", @"com.microsoft.excel.xlsx", @"com.microsoft.excel.xls", @"public.png", @"public.jpeg", @"public.audio", @"com.microsoft.waveform-​audio", @"public.movie"]
@import Masonry;
@interface YIAttachUploadCell()<UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate>
///
@property (nonnull, strong, nonatomic) UIButton *uploadButton;
///
@property (nonnull, strong, nonatomic) UIButton *fileButton;
///
@property (nonnull, strong, nonatomic) UILabel *titleLabel;
@end
@implementation YIAttachUploadCell
@synthesize row;
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
    [self.containerView roundRectWithRadius:20];
    self.containerView.backgroundColor = [UIColor blueColor];
    [self.containerView addSubview:self.uploadButton];
    [self.containerView addSubview:self.fileButton];
    [self.containerView addSubview:self.titleLabel];
    
    [self.fileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.top.equalTo(@15);
        make.bottom.equalTo(@(-15));
        make.width.equalTo(@100);
        make.height.equalTo(@50).priorityHigh();
    }];
    
    [self.uploadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fileButton);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.right.equalTo(self.fileButton.mas_left).offset(-5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(self.containerView);
        make.right.equalTo(self.uploadButton.mas_left);
    }];
}

- (void)update {
    [super update];
    NSURL *file = self.row.value;
    NSString *title = (file != nil) ? @"已上传" : @"暂无文件";
    UIColor *textColor = self.row.disabled ? UIColor.redColor : UIColor.grayColor;
    self.titleLabel.textColor = textColor;
    self.titleLabel.text = self.row.title;
    [self.fileButton setTitle:title forState:UIControlStateNormal];
}

// 刷新
- (IBAction)fileAction:(id)sender {
    if (self.row.disabled) {
        return;
    }
    YIAttachFormRow *row = self.row;
    if (row.value) {
        [self preview:self.row.value];
        if (row.previewBlock) {
            row.previewBlock(row.value);
        }
    } else {
        [self uploadAction:sender];
    }
}

- (IBAction)uploadAction:(id)sender {
    if (self.row.disabled) {
        return;
    }
    UIDocumentPickerViewController *documentBrowserController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:kUploadAttachmentsURLDocumentTypes inMode:UIDocumentPickerModeImport];
    documentBrowserController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    documentBrowserController.delegate = self;
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (viewController) {
        [viewController presentViewController:documentBrowserController animated:YES completion:nil];
    }
}
- (void)preview:(NSURL *)url {
    UIDocumentInteractionController *_docVc = [UIDocumentInteractionController interactionControllerWithURL:url];
    _docVc.delegate = self;
    [_docVc presentPreviewAnimated:YES];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
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
        button.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (target && sel) {
        [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}


#pragma mark -- UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return viewController;
}
- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller
{
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return viewController.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return viewController.view.frame;
}

#pragma mark - UIDocumentPickerDelegate
/// 共享文档回调
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls{
    if (urls.count == 0) {
        return;
    }
    self.row.value = urls[0];
    [self.row.section.formManager reloadRows:@[self.row]];
    
    if (self.row.uploadBlock) {
        self.row.uploadBlock(urls[0]);
    }
}
@end
