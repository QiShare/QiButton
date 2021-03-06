//
//  QiButtonTableViewController.m
//  QiButton
//
//  Created by wangyongwang on 2018/8/2.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import "QiButtonTableViewController.h"
#import "QiButtonDetailViewController.h"

static NSString* const kButtonTableViewCellReuseIDString = @"kButtonTableViewCellReuseIDString";
static CGFloat const kButtonTableViewCellHeight = 120.0;

@interface QiButtonTableViewController ()

/**TableView数据数组*/
@property (nonatomic,copy) NSArray *titleArray;


@end

@implementation QiButtonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareData];
    [self setupUI];
}

- (void)prepareData{
    [[UIButton new] addTarget:self action:@selector(buttonWithType:) forControlEvents:UIControlEventTouchUpInside];
    self.titleArray = @[@"UIButton基础使用",@"UIButton ContentMode",@"UIButton 多个状态点击",@"UIButton 动画",@"UIButton 扩大点击区域",@"UIButton 图片文字排列"];
    //,@"UIButton image缓存",@"UIButton 自己实现"
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor grayColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kButtonTableViewCellReuseIDString];
    self.tableView.estimatedRowHeight = kButtonTableViewCellHeight;
}

#pragma mark - Action functions
#pragma mark - push 到指定控制器
- (void)pushToViewControllerWithIndexPath:(NSIndexPath *)indexPath{
    
    QiButtonDetailViewController *buttonDetailVC = [QiButtonDetailViewController new];
    buttonDetailVC.buttonType = indexPath.row;
    [self.navigationController pushViewController:buttonDetailVC animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushToViewControllerWithIndexPath:indexPath];
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kButtonTableViewCellHeight;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titleArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kButtonTableViewCellReuseIDString forIndexPath:indexPath];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:32.f];
    cell.backgroundColor = (indexPath.row % 2) ? [UIColor whiteColor] : [UIColor lightGrayColor];
    
    return cell;
    
}
@end
