//
//  TableViewController.m
//  YIForm_Example
//
//  Created by Yilia on 2020/10/27.
//  Copyright © 2020 yiliazhang. All rights reserved.
//

#import "TableViewController.h"
#import "GWAuthInfoCell.h"
#import "YITableViewCell.h"
@interface TableViewController ()
///
@property (nonnull, strong, nonatomic) YIFormSection *section;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (YIFormSection *)randomSection {
    NSMutableArray *rows = [NSMutableArray array];
    int r = 0;
    int maxRow = 3;
    while (r < maxRow) {
        //        __weak typeof(self) weakSelf = self;
        NSString *title = [NSString stringWithFormat:@"random %d", r];
        YIFormRow *row = [self telephoneRow];
        if (r == 1) {
            row.disabled = YES;
            row.separatorStyle = UITableViewCellSeparatorStyleNone;
            row.title = @"disabled - random";
        }
        //        row.contentEdgeMargins = UIEdgeInsetsMake(20, 40, 10, 30);
        row.separatorLeftInset = 20;
        row.separatorRightInset = 20;
        [rows addObject:row];
        r++;
    }
    YIFormSection *section = Section();
    section.headerHeight = 20;
    section.footerHeight = 20;
    [section addRows:rows];
    section.cornerRadius = 20;
    section.horizontalInset = 50;
    return section;
}

- (__kindof YIFormRow *)telephoneRow {
    GWAuthInfoRow *row2 = [[GWAuthInfoRow alloc] init];
    row2.selectionStyle = UITableViewCellSelectionStyleNone;
    row2.message = @"您提交的认证信息未通过审核，请修订、完善";
    row2.tip = @"对结果有疑问请致电：020-12231232";
    return row2;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.section.rows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"authcell";
    YITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[YITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.row = self.section.rows[indexPath.row];
    [cell update];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (YIFormSection *)section {
    if (!_section) {
        _section = [self randomSection];
    }
    return _section;
}
@end
