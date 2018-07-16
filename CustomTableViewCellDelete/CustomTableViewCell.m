//
//  CustomTableViewCell.m
//  CustomTableViewCellDelete
//
//  Created by WangXueqi on 2018/7/13.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "NSObject+Category.h"

@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reloadFirstSectionIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    [self addSubview:self.bankImage];
}

- (void)reloadSecondSectionIndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    [self addSubview:self.label];
}

- (UIImageView *)bankImage {
    if (!_bankImage) {
        _bankImage = [[UIImageView alloc]init];
        _bankImage.image = [UIImage imageNamed:@"head_background"];
    }
    return _bankImage;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.backgroundColor = [UIColor orangeColor];
        _label.text = @"自定义";
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat H = CGRectGetHeight(self.frame);
    CGFloat W = CGRectGetWidth(self.frame);
    self.bankImage.frame = CGRectMake(10, 10, W-20, H-20);
    self.label.frame = CGRectMake(0, 10, W, H-20);
    /**自定义设置iOS8-10系统下的左滑删除按钮大小*/
    for (UIView * subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            subView.backgroundColor = [UIColor clearColor];//去掉默认红色背景
            //设置按钮frame
            CGRect cRect = subView.frame;
            cRect.origin.y = self.contentView.frame.origin.y + 10;
            cRect.size.height = self.contentView.frame.size.height - 20;
            subView.frame = cRect;
            //自定义按钮的文字大小
            if (subView.subviews.count == 1 && self.indexPath.section == 0) {//表示有一个按钮
                UIButton * deleteButton = subView.subviews[0];
                deleteButton.titleLabel.font = [UIFont systemFontOfSize:20];
            }
            //自定义按钮的图片
            if (subView.subviews.count == 1 && self.indexPath.section == 1) {//表示有一个按钮
                UIButton * deleteButton = subView.subviews[0];
                [deleteButton setImage:[UIImage imageNamed:@"login_btn_message"] forState:UIControlStateNormal];
                [deleteButton setTitle:@"" forState:UIControlStateNormal];
            }
            //自定义按钮的文字图片
            if (subView.subviews.count >= 2 && self.indexPath.section == 0) {//表示有两个按钮
                UIButton * deleteButton = subView.subviews[1];
                UIButton * shareButton = subView.subviews[0];
                [deleteButton setTitle:@"" forState:UIControlStateNormal];
                [shareButton setTitle:@"" forState:UIControlStateNormal];
                [self setUpDeleteButton:deleteButton];
                [self setUpShareButton:shareButton];
            }
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
