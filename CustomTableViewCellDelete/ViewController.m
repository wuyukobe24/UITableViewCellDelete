//
//  ViewController.m
//  CustomTableViewCellDelete
//
//  Created by WangXueqi on 2018/7/13.
//  Copyright © 2018年 JingBei. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "NSObject+Category.h"

#define K_Screen_Width               [UIScreen mainScreen].bounds.size.width
#define K_Screen_Height              [UIScreen mainScreen].bounds.size.height
static NSString * const CustomTableViewCellID = @"CustomTableViewCellID";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * customTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.customTableView];
}

- (UITableView *)customTableView {
    if (!_customTableView) {
        _customTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_Screen_Width, K_Screen_Height) style:UITableViewStylePlain];
        _customTableView.delegate = self;
        _customTableView.dataSource = self;
        [_customTableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:CustomTableViewCellID];
        _customTableView.tableFooterView = [[UIView alloc]init];
        _customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _customTableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CustomTableViewCellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell reloadFirstSectionIndexPath:indexPath];
    }else{
        [cell reloadSecondSectionIndexPath:indexPath];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    }
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_Screen_Width, 20)];
    headerLabel.backgroundColor = [UIColor lightGrayColor];
    headerLabel.text = @"区头";
    return headerLabel;
}

#pragma mark - 设置删除代理方法
/**使用系统默认的删除按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete){

    }
}
//自定义系统默认的删除按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"自定义按钮";
}
*/

//自定义多个左滑菜单选项
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction;
    deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [tableView setEditing:NO animated:YES];//退出编辑模式，隐藏左滑菜单
    }];
    if (indexPath.row == 1) {//在不同的cell上添加不同的按钮
        UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"分享" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            [tableView setEditing:NO animated:YES];//退出编辑模式，隐藏左滑菜单
        }];
        shareAction.backgroundColor = [UIColor blueColor];
        return @[deleteAction,shareAction];
    }
    return @[deleteAction];
}
/**自定义设置iOS11系统下的左滑删除按钮大小*/
//开始编辑左滑删除
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (@available(iOS 11.0, *)) {
        for (UIView * subView in self.customTableView.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
                subView.backgroundColor = [UIColor clearColor];//如果自定义只有一个按钮就要去掉按钮默认红色背景
                //设置按钮frame
                for (UIView * sonView in subView.subviews) {
                    if ([sonView isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {
                        CGRect cRect = sonView.frame;
                        cRect.origin.y = sonView.frame.origin.y + 10;
                        cRect.size.height = sonView.frame.size.height - 20;
                        sonView.frame = cRect;
                    }
                }
                //自定义按钮的文字大小
                if (subView.subviews.count == 1 && section == 0) {//表示有一个按钮
                    UIButton * deleteButton = subView.subviews[0];
                    deleteButton.titleLabel.font = [UIFont systemFontOfSize:20];
                }
                //自定义按钮的图片
                if (subView.subviews.count == 1 && section == 1) {//表示有一个按钮
                    UIButton * deleteButton = subView.subviews[0];
                    [deleteButton setImage:[UIImage imageNamed:@"login_btn_message"] forState:UIControlStateNormal];;
                }
                //自定义按钮的文字图片
                if (subView.subviews.count >= 2 && section == 0) {//表示有两个按钮
                    UIButton * deleteButton = subView.subviews[1];
                    UIButton * shareButton = subView.subviews[0];
                    [self setUpDeleteButton:deleteButton];
                    [self setUpShareButton:shareButton];
                }
            }
        }
    }
}

//结束编辑左滑删除
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {

}

//判断是否显示左滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
