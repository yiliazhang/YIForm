//
//  YIAttachFormRow.h
//  YIForm_Example
//
//  Created by Yilia on 2020/10/15.
//  Copyright © 2020 yiliazhang. All rights reserved.
//

#import <YIForm/YIForm.h>
NS_ASSUME_NONNULL_BEGIN

@interface YIAttachFormRow : YIFormRow

/// 选择事件回调
@property (nonatomic, copy) void(^uploadBlock)(YIAttachFormRow *item);

/// 选择事件回调
@property (nonatomic, copy) void(^previewBlock)(YIAttachFormRow *item);

@end

NS_ASSUME_NONNULL_END
