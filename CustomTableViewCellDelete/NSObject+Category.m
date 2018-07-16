//
//  NSObject+Category.m
//  CustomTableViewCellDelete
//
//  Created by WangXueqi on 2018/7/13.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import "NSObject+Category.h"

@implementation NSObject (Category)

- (void)setUpDeleteButton:(UIButton *)button {
    [button.titleLabel setFont:[UIFont fontWithName:@"SFUIText-Regular" size:12.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"login_btn_-account"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blackColor]];
    [self setUpButtonTitleAndImageLocation:button];
}

- (void)setUpShareButton:(UIButton *)button {
    [button.titleLabel setFont:[UIFont fontWithName:@"SFUIText-Regular" size:12.0]];
    [button setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"login_btn_message"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [self setUpButtonTitleAndImageLocation:button];
}

- (void)setUpButtonTitleAndImageLocation:(UIButton *)button {
    CGSize imageSize = button.imageView.image.size;
    CGSize titleSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}];
    button.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height/2, -imageSize.width/2, -imageSize.height/2, imageSize.width/2);
    button.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height/2, titleSize.width/2, titleSize.height/2, titleSize.width/2);
}

@end
