//
//  YIViewController.m
//  YIForm
//
//  Created by yiliazhang on 10/12/2020.
//  Copyright (c) 2020 yiliazhang. All rights reserved.
//

#import "YIViewController.h"
#import <YIForm/YIFormManager.h>
#import "YIAttachFormRow.h"
#import "YIFormRowText.h"


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
    
    // Do any additional setup after loading the view, typically from a nib.
    self.formManager = [YIFormManager managerForTableView:self.tableView];
    //    self.formManager.delegate = self;
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [self refreshAction:nil];
}

- (IBAction)refreshAction:(id)sender {
    [self.formManager removeAll];
    NSArray *sections = @[
        [self accessoryTypeSection],
//        [self customAccessorySection],
//        [self randomSection],
//        [self deletableSection],
//        [self deleteConfirmSection],
//        [self insertSection],
//        [self movableSection],
//        [self movableAndDeletableSection],
//        [self copyCutPastSection],
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
        if (r == 1) {
            row.disabled = YES;
            row.separatorStyle = UITableViewCellSeparatorStyleNone;
            row.title = @"disabled - random";
        }
        row.contentEdgeMargins = UIEdgeInsetsMake(20, 40, 10, 30);
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
    section.horizontalInset = 20;
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
    int maxRow = 3;
    while (r < maxRow) {
        //        __weak typeof(self) weakSelf = self;
        NSString *title = [NSString stringWithFormat:@"deletable %d", r];
        YIFormRow *row = [self rowWithTitle:title tag:title];
        
        if (r == 1) {
            row.disabled = YES;
            row.title = @"disabled - deletable";
        }
        row.contentEdgeMargins = UIEdgeInsetsMake(20, 40, 10, 30);
        
        row.separatorLeftInset = 20;
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
    section.cornerRadius = 20;
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
        //        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    };
    
    YIAttachFormRow *cutCopyPasteItem = [[YIAttachFormRow alloc] init];
    cutCopyPasteItem.title = @"paste";
    cutCopyPasteItem.copyHandler = ^(YIFormRow *item) {
        [UIPasteboard generalPasteboard].string = @"Copied item #3";
    };
    cutCopyPasteItem.pasteHandler = ^(YIFormRow *item) {
        item.title = [UIPasteboard generalPasteboard].string;
        //        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    };
    cutCopyPasteItem.cutHandler = ^(YIFormRow *item) {
        item.title = @"(Empty)";
        [UIPasteboard generalPasteboard].string = @"Copied item #3";
        //        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
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
    
    return headerView;
}

- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor orangeColor];
    footerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 5);
    return footerView;
}

- (__kindof YIFormRow *)rowWithTitle:(NSString *)title tag:(NSString *)tag {
    //    YIFormRowText *row = [[YIFormRowText alloc] init];
    //    row.height = arc4random()%50 + 10;
    //    row.title = [NSString stringWithFormat:@"%@ height:%.2f",title, row.height];
    
    __weak typeof(self) weakSelf = self;
    YIAttachFormRow *row = [[YIAttachFormRow alloc] init];
    row.tag = tag;
    row.title = title;
    row.previewBlock = ^(YIAttachFormRow * _Nonnull item) {
        NSArray<NSURL *> *items = item.value;
        if (items.count > 0) {
            [self preview:items[0]];
        }
    };
    
    row.uploadBlock = ^(YIAttachFormRow * _Nonnull item) {
        weakSelf.currrentFileUploadRowTag = item.tag;
        [self chooseDocument];
    };
    
    row.selectionHandler = ^(__kindof YIFormRow * _Nonnull item) {
        NSLog(@"selectionHandler");
    };
    
    return row;
}

- (void)accessoryButtonAction:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击" message:[NSString stringWithFormat:@"Hello,你点到我了"] preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
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


- (void)preview:(NSURL *)url {
    UIDocumentInteractionController *_docVc = [UIDocumentInteractionController interactionControllerWithURL:url];
    _docVc.delegate = self;
    [_docVc presentPreviewAnimated:YES];
}

#pragma mark -- UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}
- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller
{
    return self.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    return self.view.frame;
}
/// 跳转到文件浏览系统
- (void)chooseDocument {
    UIDocumentPickerViewController *documentBrowserController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:kUploadAttachmentsURLDocumentTypes inMode:UIDocumentPickerModeImport];
    documentBrowserController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    documentBrowserController.delegate = self;
    [self presentViewController:documentBrowserController animated:YES completion:nil];
}


#pragma mark - UIDocumentPickerDelegate
/// 共享文档回调
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls API_AVAILABLE(ios(11.0)) {
    //    __weak __typeof(self)weakSelf = self;
    //    NSArray <GWUploadAttachmentsURLModel *> *uploadFiles = [GWUploadAttachmentsURLModel uploadFilesWithPickDocumentsAtURLs:urls];
    //    [self chooseDocumentResult:uploadFiles.firstObject];
    NSParameterAssert(self.currrentFileUploadRowTag);
    
    YIAttachFormRow *row = [self.formManager rowWithTag:self.currrentFileUploadRowTag];
    if (row) {
        row.value = urls;
        [self.formManager reloadRows:@[row]];
    }
}

@end
