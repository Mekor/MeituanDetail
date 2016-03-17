//
//  TwoTableViewController.m
//  PersonalCenter
//
//  Created by Mekor on 16/3/17.
//  Copyright © 2016年 Gozap. All rights reserved.
//

#import "TwoTableViewController.h"

@interface TwoTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor = [UIColor greenColor];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
        self.tableView.backgroundColor = [UIColor blueColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 444;
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
