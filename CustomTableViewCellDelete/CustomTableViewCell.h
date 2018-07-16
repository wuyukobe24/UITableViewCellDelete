//
//  CustomTableViewCell.h
//  CustomTableViewCellDelete
//
//  Created by WangXueqi on 2018/7/13.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * bankImage;
@property(nonatomic,strong)UILabel * label;
@property(nonatomic,assign)NSIndexPath * indexPath;
- (void)reloadFirstSectionIndexPath:(NSIndexPath *)indexPath;
- (void)reloadSecondSectionIndexPath:(NSIndexPath *)indexPath;
@end
