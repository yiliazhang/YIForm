//
//  YIFormCell.m
//  YIForm
//
//  Created by Yilia on 2020/10/12.
//

#import "YIFormCell.h"
#import "YIFormRow.h"
#import "YIFormSection.h"
@interface YIFormCell()

///
@property (nonnull, strong, nonatomic) UIView *separatorLineView;
@end
@implementation YIFormCell

+ (NSString *)reuseIdentifier {
    static NSString *reuseIdentifier = @"YIFormCell";
    return reuseIdentifier;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configure];
    }
    return self;
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
}

- (void)update {
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.topMargin].active = YES;
    [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:self.bottomMargin].active = YES;
    [self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.leftMargin].active = YES;
    [self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:self.rightMargin].active = YES;
    if (self.row.separatorStyle == UITableViewCellSeparatorStyleSingleLine) {
        if (![self.subviews containsObject:self.separatorLineView]) {
            [self addSubview: self.separatorLineView];
            self.separatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
        }
        CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
        CGFloat left = self.leftMargin + self.row.separatorLeftInset;
        CGFloat right = self.rightMargin - self.row.separatorRightInset;
        [self.separatorLineView.heightAnchor constraintEqualToConstant:lineHeight].active = YES;
        [self.separatorLineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [self.separatorLineView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:left].active = YES;
        [self.separatorLineView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:right].active = YES;
    } else {
        [self.separatorLineView removeFromSuperview];
    }
}

- (CGFloat)topMargin {
    CGFloat top = 0;
    if (self.row.contentEdgeMargins.top != 0) {
        top = self.row.contentEdgeMargins.top;
    }
    return top;
}

- (CGFloat)leftMargin {
    CGFloat left = 0;
    if (self.row.contentEdgeMargins.left != 0) {
        left = self.row.contentEdgeMargins.left;
    }
    if (self.row.section.horizontalInset != 0) {
        left += self.row.section.horizontalInset;
    }
    return left;
}

- (CGFloat)bottomMargin {
    CGFloat bottom = 0;
    if (self.row.contentEdgeMargins.bottom != 0) {
        bottom = -self.row.contentEdgeMargins.bottom;
    }
    return bottom;
}

- (CGFloat)rightMargin {
    CGFloat right = 0;
    if (self.row.contentEdgeMargins.right != 0) {
        right = -self.row.contentEdgeMargins.right;
    }
    if (self.row.section.horizontalInset != 0) {
        right -= self.row.section.horizontalInset;
    }
    return right;
}

- (UIView *)separatorLineView {
    if (!_separatorLineView) {
        _separatorLineView = [[UIView alloc] init];
    }
    return _separatorLineView;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    self.separatorLineView.backgroundColor = separatorColor;
}
@end
