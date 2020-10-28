//
//  YIMessageViewController.m
//  YIForm_Example
//
//  Created by Yilia on 2020/10/26.
//  Copyright © 2020 yiliazhang. All rights reserved.
//

#import "YIMessageViewController.h"

#import <Masonry/Masonry.h>
#import <YIForm.h>

#import "GWAuthInfoCell.h"
#import "YIAttachFormRow.h"
@interface YIMessageViewController ()

///
@property (nonnull, strong, nonatomic) YIFormManager *formManager;
///
@property (nonnull, strong, nonatomic) UITableView *tableView;
@end

@implementation YIMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.formManager = [YIFormManager managerForTableView:self.tableView];
    [self formdatas];
}

- (void)setupView {
    [super setupView];
    [self.containerView addSubview:self.tableView];
//    UIView *bottomView = [ViewFactory footerButtonViewWithTitle:@"进入修订完善" target:self action:@selector(toCompleteAction:)];
//    [self.containerView addSubview:bottomView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.containerView);
        make.bottom.equalTo(self.containerView);
    }];
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tableView.mas_bottom);
//        make.left.right.bottom.equalTo(self.containerView);
//    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 继续完善
- (IBAction)toCompleteAction:(id)sender {
    
}


- (void)formdatas {
    
    [self.formManager removeAll];
//    if (![NSArray isValid: self.sections]) {
//        return;
//    }
//    NSMutableArray *rows = [NSMutableArray array];
    YIAttachFormRow *row1 = [[YIAttachFormRow alloc] init];
    
    GWAuthInfoRow *row2 = [[GWAuthInfoRow alloc] init];
    row2.selectionStyle = UITableViewCellSelectionStyleNone;
    row2.message = @"您提交的认证信息未通过审核，请修订、完善";
    row2.tip = @"对结果有疑问请致电：020-12231232";
//    row2.cornerRadius = 4;
//    row2.contentViewBackgroundColor = [UIColor blueColor];
    
    
    
    
    YIFormSection *section = [[YIFormSection alloc] init];
    // section.headerView = [self sectionHeaderView];
    section.horizontalInset = 40;
//    section.cornerRadius = 4;
    [section addRows:@[row1, row2]];
    //section.headerHeight = section.headerView.frame.size.height;
//    [section addRows:@[row]];
    [self.formManager addSections:@[section]];
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView = tableView;
    }
    return _tableView;
}
@end
