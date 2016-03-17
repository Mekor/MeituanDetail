//
//  OneTableViewController.m
//  PersonalCenter
//
//  Created by Mekor on 16/3/17.
//  Copyright © 2016年 Gozap. All rights reserved.
//

#import "OneTableViewController.h"

@interface OneTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation OneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
        self.tableView.backgroundColor = [UIColor greenColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"r"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"r"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Person%zd+++", indexPath.row];
    
    return cell;
}

@end
