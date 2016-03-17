//
//  ProductViewController.m
//  PersonalCenter
//
//  Created by Mekor on 16/3/17.
//  Copyright © 2016年 Gozap. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong) UITableView *leftTableView;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor redColor];
    
    self.tableView.frame =CGRectMake(self.view.bounds.size.width *0.25, 0, self.view.bounds.size.width *0.25*3, self.view.bounds.size.height);
        // 创建leftTableView
    self.leftTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width *0.25, self.view.bounds.size.height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        tableView;
    });
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.leftTableView) {
        return 1;
    }
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return 5;
    }
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"r"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"r"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Person%zd+++", indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.leftTableView == tableView) {
        return nil;
    }
    return [NSString stringWithFormat:@"section%zd",section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:0 animated:NO];
    }
}
@end
