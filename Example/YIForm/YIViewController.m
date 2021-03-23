//
//  YIViewController.m
//  YIForm
//
//  Created by yiliazhang on 10/12/2020.
//  Copyright (c) 2020 yiliazhang. All rights reserved.
//

#import "YIViewController.h"
#import <YIForm/YIForm.h>
#import "YIAttachFormRow.h"
#import "YIFormRowText.h"
#import <Masonry/Masonry.h>
#import "GWAuthInfoCell.h"
#import "YIFormTextCell.h"
#import "YIMessageViewController.h"

#define kUploadAttachmentsURLDocumentTypes @[@"com.microsoft.word.docx", @"org.openxmlformats.wordprocessingml.document", @"org.openxmlformats.spreadsheetml.sheet", @"org.openxmlformats.presentationml.presentation", @"com.microsoft.word.doc", @"com.microsoft.powerpoint.ppt", @"com.adobe.pdf", @"com.microsoft.powerpoint.​pptx", @"com.microsoft.excel.xlsx", @"com.microsoft.excel.xls", @"public.png", @"public.jpeg", @"public.audio", @"com.microsoft.waveform-​audio", @"public.movie"]

@interface YIViewController ()<UIDocumentPickerDelegate, UIDocumentInteractionControllerDelegate>
///
@property (nonnull, strong, nonatomic) YIFormManager *formManager;
///
@property (nonnull, strong, nonatomic) UITableView *tableView;
/// tag
@property (nonatomic, copy) NSString *currrentFileUploadRowTag;


// Deletable items with confirmation

@property (strong, readwrite, nonatomic) YIFormRow *itemToDelete;
@property (copy, readwrite, nonatomic) void (^deleteConfirmationHandler)(void);

@end

@implementation YIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(switchTableEdit:)];
    
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
    self.formManager = [YIFormManager managerForTableView:self.tableView];
    [self refreshAction:nil];
}

- (IBAction)refreshAction:(id)sender {
    [self.formManager removeAll];
    NSArray *sections = @[
        [self accessoryTypeSection],
        [self specialCellClassSection],
        [self customAccessorySection],
        [self randomSection],
        [self deletableSection],
        [self deleteConfirmSection],
        [self insertSection],
        [self movableSection],
        [self movableAndDeletableSection],
        [self copyCutPastSection],
    ];
    [self.formManager addSections:sections];
    [self.tableView reloadData];
}

- (IBAction)removeAction:(id)sender {
    
}
- (void)switchTableEdit:(UIBarButtonItem *)sender {
    self.editing = !self.editing;
    self.tableView.editing = self.editing;
    [sender setTitle:self.editing ? @"完成" : @"编辑"];
}

- (YIFormSection *)randomSection {
    NSMutableArray *rows = [NSMutableArray array];
    int r = 0;
    int maxRow = 3;
    while (r < maxRow) {
        //        __weak typeof(self) weakSelf = self;
        NSString *title = [NSString stringWithFormat:@"random %d", r];
        YIFormRow *row = [self rowWithTitle:title tag:title];
//        YIFormRow *row = [self telephoneRow];
        if (r == 1) {
            row.disabled = YES;
            row.separatorStyle = UITableViewCellSeparatorStyleNone;
            row.title = @"disabled - random";
        }
                row.contentEdgeInsets = UIEdgeInsetsMake(20, 40, 10, 30);
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


- (YIFormSection *)customAccessorySection {
    // 有accesoryView 的情况下就不要设置 contentEdgeMargins 或 horizontalInset
    NSMutableArray *rows = [NSMutableArray array];
    int r = 0;
    int maxRow = 3;
    while (r < maxRow) {
        NSString *title = [NSString stringWithFormat:@"customAccessory %d", r];
        YIFormRow *row = [self rowWithTitle:title tag:title];
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, 0, 50, 30);
        [button setTitle:@"点击" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(accessoryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor blackColor];
        row.accessoryView = button;
        
        [rows addObject:row];
        r++;
    }
    
    YIFormSection *section = Section();
    [section addRows:rows];
    section.headerView = [self headerViewWithTitle:@" custom Accessory \r\n 有accesoryView 的情况下就不要设置 contentEdgeMargins 或 horizontalInset"];
    section.footerView = [self footerView];
    
    return section;
}

- (YIFormSection *)accessoryTypeSection {
    // 有accesoryView 的情况下就不要设置 contentEdgeMargins 或 horizontalInset
    NSMutableArray *rows = [NSMutableArray array];
    int r = 0;
    int maxRow = 3;
    while (r < maxRow) {
        NSString *title = [NSString stringWithFormat:@"accessoryType %d", r];
        YIFormRow *row = [self rowWithTitle:title tag:title];
        row.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        row.accessoryButtonTapHandler = ^(__kindof YIFormRow * _Nonnull item) {
            NSLog(@"accessoryButtonTapHandler");
        };
        [rows addObject:row];
        r++;
    }
    
    YIFormSection *section = Section();
    [section addRows:rows];
    section.headerView = [self headerViewWithTitle:@"accessoryType \r\n 有accesoryView 的情况下就不要设置 contentEdgeMargins 或 horizontalInset"];
    section.footerHeight = 20;
    return section;
}

- (YIFormSection *)specialCellClassSection {
    // 有accesoryView 的情况下就不要设置 contentEdgeMargins 或 horizontalInset
    NSMutableArray *rows = [NSMutableArray array];
    int r = 0;
    int maxRow = 3;
    while (r < maxRow) {
        NSString *title = [NSString stringWithFormat:@"accessoryType %d", r];
        YIFormRow *row = [self rowWithTitle:title specialCellClass:[YIFormTextCell class]];
        row.title = @"asfasf";
        row.value = @"dddd";
        row.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        row.accessoryButtonTapHandler = ^(__kindof YIFormRow * _Nonnull item) {
            NSLog(@"accessoryButtonTapHandler");
        };
        [rows addObject:row];
        r++;
    }
    
    YIFormSection *section = Section();
    [section addRows:rows];
    section.headerView = [self headerViewWithTitle:@"accessoryType \r\n 有accesoryView 的情况下就不要设置 contentEdgeMargins 或 horizontalInset"];
    section.footerHeight = 20;
    return section;
}

- (YIFormSection *)insertSection {
    NSMutableArray *rows = [NSMutableArray array];
    int r = 0;
    int maxRow = 3;
    while (r < maxRow) {
        //        __weak typeof(self) weakSelf = self;
        NSString *title = [NSString stringWithFormat:@"insert %d", r];
        YIFormRow *row = [self rowWithTitle:title tag:title];
        
        if (r == 1) {
            row.disabled = YES;
            row.title = @"disabled - insert";
        }
        row.insertionHandler = ^(YIFormRow *item) {
            NSLog(@"Insertion handler callback");
        };
        row.editingStyle = UITableViewCellEditingStyleInsert;
        [rows addObject:row];
        r++;
    }
    YIFormSection *section = Section();
    section.headerView = [self headerViewWithTitle:@"insert 功能"];
    section.footerHeight = 20;
    [section addRows:rows];
    return section;
}

- (YIFormSection *)movableSection {
    NSMutableArray *rows = [NSMutableArray array];
    int r = 0;
    int maxRow = 3;
    while (r < maxRow) {
        //        __weak typeof(self) weakSelf = self;
        NSString *title = [NSString stringWithFormat:@"movable %d", r];
        YIFormRow *row = [self rowWithTitle:title tag:title];
        row.moveHandler = ^BOOL(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
            return YES;
        };
        row.moveCompletionHandler = ^(YIFormRow *item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
            NSLog(@"Moved item: %@ from [%li,%li] to [%li,%li]", item.title, (long) sourceIndexPath.section, (long) sourceIndexPath.row, (long) destinationIndexPath.section, (long) destinationIndexPath.row);
        };
        if (r == 1) {
            row.disabled = YES;
            row.title = @"disabled - movable";
        }
        [rows addObject:row];
        r++;
    }
    YIFormSection *section = Section();
    section.headerView = [self headerViewWithTitle:@"move 功能"];
    section.footerHeight = 20;
    [section addRows:rows];
    return section;
}

- (YIFormSection *)deletableSection {
    NSMutableArray *rows = [NSMutableArray array];
    int r = 0;
    int maxRow = 7;
    while (r < maxRow) {
        //        __weak typeof(self) weakSelf = self;
        NSString *title = [NSString stringWithFormat:@"deletable %d", r];
        YIFormRow *row = [self rowWithTitle:title tag:title];
        
        if (r == 1) {
            row.disabled = YES;
            row.title = @"disabled - deletable";
            row.separatorColor = [UIColor greenColor];
        } else if (r == 2) {
            
            row.separatorColor = [UIColor blackColor];
        } else if (r == 3) {
            row.separatorColor = [UIColor clearColor];
        } else if (r == 4) {
            row.separatorColor = [UIColor blueColor];
        } else {
            row.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        row.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 20);
        row.separatorLeftInset = 5;
        row.separatorRightInset = 20;
        
        row.editingStyle = UITableViewCellEditingStyleDelete;
        row.deletionHandler = ^(YIFormRow *item) {
            NSLog(@"Item removed: %@", item.title);
        };
        [rows addObject:row];
        r++;
    }
    YIFormSection *section = Section();
    [section addRows:rows];
    section.cornerRadius = 10;
    section.horizontalInset = 20;
    return section;
}

- (YIFormSection *)deleteConfirmSection {
    NSMutableArray *rows = [NSMutableArray array];
    int r = 0;
    int maxRow = 1;
    while (r < maxRow) {
        __weak typeof(self) weakSelf = self;
        NSString *title = [NSString stringWithFormat:@"deleteConfirm %d", r];
        YIFormRow *row = [self rowWithTitle:title tag:title];
        row.editingStyle = UITableViewCellEditingStyleDelete;
        row.deletionHandlerWithCompletion = ^(YIFormRow *item, void (^completion)(void)) {
            [weakSelf showAlert:item];
            weakSelf.itemToDelete = item;
            // Assign completion block to deleteConfirmationHandler for future use
            weakSelf.deleteConfirmationHandler = completion;
        };
        
        [rows addObject:row];
        r++;
    }
    YIFormSection *section = Section();
    section.headerView = [self headerViewWithTitle:@"delete 删除功能"];
    section.footerHeight = 20;
    [section addRows:rows];
    return section;
}

- (YIFormSection *)movableAndDeletableSection {
    NSMutableArray *rows = [NSMutableArray array];
    int r = 0;
    int maxRow = 2;
    while (r < maxRow) {
        NSString *title = [NSString stringWithFormat:@"movableAndDeletable %d", r];
        YIFormRow *row = [self rowWithTitle:title tag:title];
        row.editingStyle = UITableViewCellEditingStyleDelete;
        
        row.moveHandler = ^BOOL(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
            return YES;
        };
        row.moveCompletionHandler = ^(YIFormRow *item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath) {
            NSLog(@"Moved item: %@ from [%li,%li] to [%li,%li]", item.title, (long) sourceIndexPath.section, (long) sourceIndexPath.row, (long) destinationIndexPath.section, (long) destinationIndexPath.row);
        };
        [rows addObject:row];
        r++;
    }
    YIFormSection *section = Section();
    section.headerView = [self headerViewWithTitle:@"move delete 功能"];
    section.headerHeight = 20;
    section.footerHeight = 20;
    [section addRows:rows];
    return section;
}


- (YIFormSection *)copyCutPastSection {
    YIAttachFormRow *copyItem = [[YIAttachFormRow alloc] init];
    copyItem.title = @"copy";
    copyItem.selectionHandler = ^(__kindof YIFormRow * _Nonnull item) {
        //        [item deselectRowAnimated:YES];
    };
    copyItem.copyHandler = ^(YIFormRow *item) {
        [UIPasteboard generalPasteboard].string = @"Copied item #1";
    };
    
    
    YIAttachFormRow *pasteItem = [[YIAttachFormRow alloc] init];
    pasteItem.title = @"paste";
    pasteItem.selectionHandler = ^(__kindof YIFormRow * _Nonnull item) {
        //        [item deselectRowAnimated:YES];
    };
    pasteItem.pasteHandler = ^(YIFormRow *item) {
        item.title = [UIPasteboard generalPasteboard].string;
        [item reload];
    };
    
    YIAttachFormRow *cutCopyPasteItem = [[YIAttachFormRow alloc] init];
    cutCopyPasteItem.title = @"paste";
    cutCopyPasteItem.copyHandler = ^(YIFormRow *item) {
        [UIPasteboard generalPasteboard].string = @"Copied item #3";
    };
    cutCopyPasteItem.pasteHandler = ^(YIFormRow *item) {
        item.title = [UIPasteboard generalPasteboard].string;
        [item reload];
    };
    cutCopyPasteItem.cutHandler = ^(YIFormRow *item) {
        item.title = @"(Empty)";
        [UIPasteboard generalPasteboard].string = @"Copied item #3";
        //        [item reload];
    };
    
    YIFormSection *section = Section();
    section.headerView = [self headerViewWithTitle:@"copy cut paste 功能"];
    section.disabled = self.tableView.editing;
    section.headerHeight = 20;
    section.footerHeight = 20;
    [section addRows:@[copyItem, pasteItem, cutCopyPasteItem]];
    return section;
}

- (UIView *)headerViewWithTitle:(NSString *)title {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor redColor];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectInset(headerView.bounds, 20, 5)];
    [headerView addSubview:label];
    label.text = title;
    label.numberOfLines = 0;
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"点" forState:UIControlStateNormal];
    
    
    return headerView;
}

- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor orangeColor];
    footerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 5);
    return footerView;
}
- (__kindof YIFormRow *)telephoneRow {
    GWAuthInfoRow *row2 = [[GWAuthInfoRow alloc] init];
    row2.selectionStyle = UITableViewCellSelectionStyleNone;
    row2.message = @"您提交的认证信息未通过审核，请修订、完善";
    row2.tip = @"对结果有疑问请致电：020-12231232";
    return row2;
}

- (__kindof YIFormRow *)rowWithTitle:(NSString *)title tag:(NSString *)tag {
    //    YIFormRowText *row00 = Row(YIFormRowText.class);
    //    row00.height = arc4random()%50 + 10;
    //    row00.title = [NSString stringWithFormat:@"%@ height:%.2f",title, row00.height];
    //    Row(YIAttachFormRow.class)
    __weak typeof(self) weakSelf = self;
    YIAttachFormRow *row = [YIAttachFormRow row];
    row.tag = tag;
    row.title = title;
    row.containerBackgroundColor = [UIColor orangeColor];
    row.previewBlock = ^(NSURL *fileURL) {
    };
    
    row.uploadBlock = ^(NSURL *fileURLs) {
    };
    
    row.selectionHandler = ^(__kindof YIFormRow * _Nonnull item) {
        NSLog(@"selectionHandler");
    };
    
    return row;
}
- (__kindof YIFormRow *)rowWithTitle:(NSString *)title specialCellClass:(id)cellClass {
    //    YIFormRowText *row00 = Row(YIFormRowText.class);
    //    row00.height = arc4random()%50 + 10;
    //    row00.title = [NSString stringWithFormat:@"%@ height:%.2f",title, row00.height];
    //    Row(YIAttachFormRow.class)
    __weak typeof(self) weakSelf = self;
    YIAttachFormRow *row = [YIAttachFormRow rowWithCellClass:cellClass];
    row.title = title;
    row.containerBackgroundColor = [UIColor whiteColor];
//    row.containerBackgroundColor = [UIColor orangeColor];
    row.previewBlock = ^(NSURL *fileURL) {
    };
    
    row.uploadBlock = ^(NSURL *fileURLs) {
    };
    
    row.selectionHandler = ^(__kindof YIFormRow * _Nonnull item) {
        NSLog(@"selectionHandler");
    };
    
    return row;
}
- (void)accessoryButtonAction:(id)sender {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击" message:[NSString stringWithFormat:@"Hello,你点到我了"] preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        YIMessageViewController *viewController = [[YIMessageViewController alloc] init];
        [viewController showOnViewController:weakSelf];
    }];
    // Add the actions.
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}


- (void)showAlert:(YIFormRow *)item {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Confirmation" message:[NSString stringWithFormat:@"Are you sure you want to delete %@", item.title] preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (self.deleteConfirmationHandler) {
            self.deleteConfirmationHandler();
            NSLog(@"Item removed: %@", self.itemToDelete.title);
        }
    }];
    // Add the actions.
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView = tableView;
    }
    return _tableView;
}

@end
