//
//  ViewController.m
//  MTDetail
//
//  Created by Mekor on 16/3/17.
//  Copyright © 2016年 CityNight. All rights reserved.
//

#import "ViewController.h"
#import "ProductViewController.h"
#import "OneTableViewController.h"
#import "TwoTableViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) UIView* headerView;
@property (nonatomic, weak) UIView* titleView;
@property (nonatomic, weak) UIScrollView* containerView;

@property (nonatomic, weak) UITableView* currentTableView; // 当前tableview
@property (nonatomic, assign) NSUInteger currentPage; // 当前页

@end

static CGFloat const headerH = 120;
static CGFloat const titleH = 40;


@implementation ViewController
#pragma mark - setter && getter
- (void)setCurrentTableView:(UITableView *)currentTableView {
    _currentTableView = currentTableView;
    
    [_currentTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

-(void)dealloc {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_currentTableView removeObserver:self forKeyPath:@"contentOffset"];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof BaseViewController * _Nonnull vc, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [vc.tableView removeFromSuperview];
        [vc.tableView removeObserver:self forKeyPath:@"contentOffset"];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    
    UIView* headerView = [UIView new];
    [self.view addSubview:headerView];
    _headerView = headerView;
    _headerView.backgroundColor = [UIColor redColor];
    _headerView.frame = CGRectMake(0, 60, screenSize.width, headerH);
        // 添加背景
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:_headerView.bounds];
    bgImageView.image = [UIImage imageNamed:@"bgImage.gif"];
    [_headerView addSubview:bgImageView];
    
    UIView* titleView = [UIView new];
    [self.view addSubview:titleView];
    _titleView = titleView;
    _titleView.backgroundColor = [UIColor greenColor];
    _titleView.frame = CGRectMake(0, CGRectGetMaxY(_headerView.frame), screenSize.width, titleH);
    
    UIScrollView* containerView = [UIScrollView new];
    [self.view addSubview:containerView];
    _containerView = containerView;
    
    containerView.pagingEnabled = YES;
    containerView.delegate = self;
    _containerView.frame = CGRectMake(0, CGRectGetMaxY(_titleView.frame), screenSize.width, screenSize.height - 60 - titleH);
    
    [self setControllers:[NSArray arrayWithObjects:[ProductViewController new],[OneTableViewController new],[TwoTableViewController new], nil]];
    
    _currentPage = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


#pragma mark - 监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGPoint newP = [change[@"new"] CGPointValue];
    CGPoint oldP = [change[@"old"] CGPointValue];
    NSLog(@"newY=%lf",newP.y);
    if (newP.y <= 0 || newP.y > headerH + titleH) {
        return;
    }
    
    
    if (newP.y > oldP.y) { // 上滑
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect r = _titleView.frame;
            r.origin.y = 60;
            _titleView.frame = r;
            
            CGRect r1 = _containerView.frame;
            r1.origin.y = 60 + titleH;
            _containerView.frame = r1;
        }];
        
    } else if (newP.y < oldP.y) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect r = _titleView.frame;
            r.origin.y = 60 + headerH;
            _titleView.frame = r;
            
            CGRect r1 = _containerView.frame;
            r1.origin.y = 60 + titleH + headerH;
            _containerView.frame = r1;
        }];
    }
}

#pragma mark - private

-(void)setControllers:(NSArray *)vcs {
        // 设置子控制器
    [self setUpChildControlllerWithControllers:vcs];
}
    // 设置子控制器
- (void)setUpChildControlllerWithControllers:(NSArray *)vcs
{
    CGSize size = _containerView.bounds.size;
    NSInteger index = 0;
    CGRect frame = _containerView.bounds;
    for (BaseViewController *personChildVc in vcs) {
        frame.origin.x = index *size.width;
        personChildVc.view.frame = frame;
        [_containerView addSubview:personChildVc.view];
        [self addChildViewController:personChildVc];
        self.currentTableView = personChildVc.tableView;
        index++;
    }
    
    _containerView.contentSize = CGSizeMake(vcs.count * size.width, size.height);
}

#pragma mark - scrollview delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSUInteger page = scrollView.contentOffset.x / screenSize.width;
    
    if (_currentPage != page) {
        _currentPage = page;
        BaseViewController *vc = self.childViewControllers[_currentPage];
        
        _currentTableView = vc.tableView;
            //        if (_currentPage == 0) {
            //            UITableViewController *vc = self.childViewControllers[]
            //            self.currentTableView = _tableView;
            //        } else if (_currentPage == 1) {
            //            self.currentTableView = _tableView1;
            //        }
    }
}

#pragma mark - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"r"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"r"];
    }
    
        //    if (tableView == _tableView) {
        //        cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
        //    } else {
    cell.textLabel.text = [NSString stringWithFormat:@"%zd+++", indexPath.row];
        //    }
    
    return cell;
}

@end
