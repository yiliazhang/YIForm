//
//  YIFormCell.m
//  YIForm
//
//  Created by Yilia on 2020/10/12.
//

#import "YIFormCell.h"
#import "YIFormRow.h"
#import "YIFormSection.h"
#import "YIFormManager.h"
@interface YIFormCell()
///
@property (nonnull, strong, nonatomic) UIView *containerView;

///
@property (nonnull, strong, nonatomic) UIView *customContentView;
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
        
        [self.contentView addSubview:self.customContentView];

        [self.customContentView addSubview:self.containerView];
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

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.row.section.formManager displayRows:nil];
}

- (void)configure {
    
}

- (void)update {
    self.customContentView.backgroundColor = self.row.section.cornerRadius == 0 ? self.row.containerBackgroundColor : UIColor.clearColor;
//    self.containerView.backgroundColor = self.row.section.cornerRadius == 0 ? self.row.containerBackgroundColor : UIColor.clearColor;
    
    [self.customContentView.topAnchor constraintEqualToAnchor:self.customContentView.superview.topAnchor].active = YES;
    [self.customContentView.bottomAnchor constraintEqualToAnchor:self.customContentView.superview.bottomAnchor].active = YES;
    [self.customContentView.leftAnchor constraintEqualToAnchor:self.customContentView.superview.leftAnchor constant:self.row.section.horizontalInset].active = YES;
    [self.customContentView.rightAnchor constraintEqualToAnchor:self.customContentView.superview.rightAnchor constant:-self.row.section.horizontalInset].active = YES;
    
    [self.containerView.topAnchor constraintEqualToAnchor:self.containerView.superview.topAnchor constant:self.row.contentEdgeMargins.top].active = YES;
    [self.containerView.bottomAnchor constraintEqualToAnchor:self.containerView.superview.bottomAnchor constant:-self.row.contentEdgeMargins.bottom].active = YES;
    [self.containerView.leftAnchor constraintEqualToAnchor:self.containerView.superview.leftAnchor constant:self.row.contentEdgeMargins.left].active = YES;
    [self.containerView.rightAnchor constraintEqualToAnchor:self.containerView.superview.rightAnchor constant:-self.row.contentEdgeMargins.right].active = YES;
    if (self.row.separatorStyle == UITableViewCellSeparatorStyleSingleLine) {
        if (![self.subviews containsObject:self.separatorLineView]) {
            [self addSubview: self.separatorLineView];
        }
        CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
        [self.separatorLineView.heightAnchor constraintEqualToConstant:lineHeight].active = YES;
        [self.separatorLineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        [self.separatorLineView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.separatorLeftMargin].active = YES;
        [self.separatorLineView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:self.separatorRightMargin].active = YES;
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

- (CGFloat)separatorLeftMargin {
    return self.leftMargin + self.row.separatorLeftInset;
    
}

- (CGFloat)separatorRightMargin {
    return self.rightMargin - self.row.separatorRightInset;
    
}
- (UIView *)separatorLineView {
    if (!_separatorLineView) {
        _separatorLineView = [[UIView alloc] init];
        _separatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _separatorLineView;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    self.separatorLineView.backgroundColor = separatorColor;
}

- (UIView *)customContentView {
    if (!_customContentView) {
        _customContentView = [[UIView alloc] init];
        _customContentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _customContentView;
}

-(UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _containerView;
}

@end
