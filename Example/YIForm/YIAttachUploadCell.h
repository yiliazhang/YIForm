//
//  YIAttachUploadCell.h
//  YIForm_Example
//
//  Created by Yilia on 2020/10/15.
//  Copyright © 2020 yiliazhang. All rights reserved.
//

#import <YIForm/YIForm.h>
#import "YIAttachFormRow.h"

NS_ASSUME_NONNULL_BEGIN

@interface YIAttachUploadCell : YIFormCell
///
@property (nonatomic, weak) YIAttachFormRow *row;
+ (NSString *)reuseIdentifier;
@end

NS_ASSUME_NONNULL_END
