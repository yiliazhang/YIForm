//
//  YIOneViewController.m
//  YIForm_Example
//
//  Created by Yilia on 2020/10/26.
//  Copyright © 2020 yiliazhang. All rights reserved.
//

#import "YIPopViewController.h"
#import <Masonry/Masonry.h>

@interface YIPopViewController ()
///
@property (nonnull, strong, nonatomic) UIButton *closeButton;
///
@property (nonatomic, weak) __kindof UIViewController *viewController;

@end

@implementation YIPopViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView {
    
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.46];
    
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(18);
        make.right.equalTo(self.view).offset(-18);
        make.height.greaterThanOrEqualTo(@300);
        make.bottom.lessThanOrEqualTo(@(-60));
    }];
    
    [self.view addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.containerView);
        make.bottom.equalTo(self.containerView.mas_top).offset(-15);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    
//    [self.containerView roundRectWithRadius:3];
}

- (void)showOnViewController:(UIViewController *)viewController {
    self.viewController = viewController;
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [viewController presentViewController:self animated:NO completion:nil];
}

- (void)dismissCompletion:(void (^ __nullable)(void))completion {
    [self dismissViewControllerAnimated:NO completion:completion];
}

// 关闭
- (IBAction)closeAction:(id)sender {
    [self dismissCompletion:self.closeActionBlock];
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc] init];
        [_closeButton setImage:[UIImage imageNamed:@"close_service"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (void)setHideCloseButton:(BOOL)hideCloseButton {
    self.closeButton.hidden = hideCloseButton;
}

@end
