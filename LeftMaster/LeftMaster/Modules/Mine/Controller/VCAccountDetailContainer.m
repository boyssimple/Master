//
//  VCOrderList.m
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCAccountDetailContainer.h"
#import "ViewTabAccount.h"
#import "AppDelegate.h"

@interface VCAccountDetailContainer ()<UIScrollViewDelegate,ViewTabAccountDelegate>
@property (nonatomic, strong) ViewTabAccount *tabOrder;
@property (nonatomic, strong) UIScrollView *mainScroll;
@property (nonatomic, strong) NSArray *vcList;
@property(nonatomic,assign)NSInteger curIndex;
@end

@implementation VCAccountDetailContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.billNo = self.billNo;
    self.title = @"对帐单明细";
    [self.view addSubview:self.tabOrder];
    [self.view addSubview:self.mainScroll];
    
    for (NSInteger i = 0 ;i<self.vcList.count;i++) {
        NSString *vcName = [self.vcList objectAtIndex:i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
        [self addChildViewController:vc];
    }
    self.mainScroll.contentSize = CGSizeMake(DEVICEWIDTH * self.vcList.count, 0);
    
    
    self.tabOrder.curIndex = self.curIndex;
    CGPoint point = CGPointMake(self.curIndex*DEVICEWIDTH, self.mainScroll.contentOffset.y);
    [self.mainScroll setContentOffset:point animated:NO];
    
    [self scrollViewDidEndScrollingAnimation:self.mainScroll];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / DEVICEWIDTH;
    UIViewController *vc = (UIViewController*)[self.childViewControllers objectAtIndex:index];
    self.tabOrder.curIndex = index;
    if ([vc isViewLoaded]) {
        return;
    }
    vc.view.frame = CGRectMake(DEVICEWIDTH * index, 0, DEVICEWIDTH, scrollView.height);
    [self.mainScroll addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - ViewTabOrderDelegate
- (void)clickTab:(NSInteger)index{
    CGPoint point = CGPointMake(index*DEVICEWIDTH, self.mainScroll.contentOffset.y);
    [self.mainScroll setContentOffset:point animated:TRUE];
}

- (UIScrollView*)mainScroll{
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [ViewTabAccount calHeight] + NAV_STATUS_HEIGHT, DEVICEWIDTH, DEVICEHEIGHT- [ViewTabAccount calHeight] - NAV_STATUS_HEIGHT)];
        _mainScroll.contentSize = CGSizeMake(_mainScroll.contentSize.width, 1000);
        _mainScroll.pagingEnabled = YES;
        _mainScroll.delegate = self;
        _mainScroll.showsHorizontalScrollIndicator = FALSE;
    }
    return _mainScroll;
}


- (NSArray*)vcList{
    if (!_vcList) {
        _vcList = @[@"VCAccountOrderDetail",@"VCAccountPayDetail"];
    }
    return _vcList;
}


- (ViewTabAccount*)tabOrder{
    if (!_tabOrder) {
        _tabOrder = [[ViewTabAccount alloc]initWithFrame:CGRectMake(0, NAV_STATUS_HEIGHT, DEVICEWIDTH, [ViewTabAccount calHeight])];
        _tabOrder.curIndex = 0;
        _tabOrder.delegate = self;
        _tabOrder.dataSource = @[@"订单明细",@"付款明细"];
    }
    return _tabOrder;
}

/*
 
 
 */
@end
