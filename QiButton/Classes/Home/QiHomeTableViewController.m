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
    return 300.f;
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
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 256)/255.f green:(arc4random() % 256)/255.f blue:(arc4random() % 256)/255.f alpha:1.f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushToViewControllerWithIndexPath:indexPath];
}

@end
