//
//  QiHomeTableViewController.m
//  QiButton
//
//  Created by wangyongwang on 2018/8/2.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiHomeTableViewController.h"
#import "QiButtonTableViewController.h"

static NSString* const kHomeCellReuseIDString = @"kHomeCellReuseIDString";
static CGFloat const kHomeCellHeight = 300.0;

@interface QiHomeTableViewController ()

/**TableView 数据数组*/
@property (nonatomic,copy) NSArray *titleArray;

@end

@implementation QiHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = @[@"UIButton"];
    self.title = @"首页";
    [self prepareData];
    [self setupUI];
}


- (void)prepareData{
    
    self.titleArray = @[@"UIButton"];
    
}

- (void)setupUI{
    
    self.title = @"首页";
}

#pragma mark - Action ----------------------
#pragma mark - push 到指定控制器
- (void)pushToViewControllerWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            QiButtonTableViewController *buttonTableVC = [QiButtonTableViewController new];
            [self.navigationController pushViewController:buttonTableVC animated:YES];
        }
    }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHomeCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeCellReuseIDString forIndexPath:indexPath];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:60.f];
    cell.backgroundColor = WWRandomColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushToViewControllerWithIndexPath:indexPath];
}

@end
