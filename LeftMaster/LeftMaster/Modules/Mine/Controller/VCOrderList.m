//
//  VCOrderList.m
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCOrderList.h"
#import "VCOrderContaier.h"
#import "ViewTabOrder.h"

@interface VCOrderList ()<UIScrollViewDelegate,ViewTabOrderDelegate>
@property (nonatomic, strong) ViewTabOrder *tabOrder;
@property (nonatomic, strong) UIScrollView *mainScroll;
@property (nonatomic, strong) NSArray *vcList;
@end

@implementation VCOrderList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"订单";
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
    VCOrderContaier *vc = (VCOrderContaier*)[self.childViewControllers objectAtIndex:index];
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
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [ViewTabOrder calHeight] + NAV_STATUS_HEIGHT, DEVICEWIDTH, DEVICEHEIGHT- [ViewTabOrder calHeight] - NAV_STATUS_HEIGHT)];
        _mainScroll.contentSize = CGSizeMake(_mainScroll.contentSize.width, 1000);
        _mainScroll.pagingEnabled = YES;
        _mainScroll.delegate = self;
        _mainScroll.showsHorizontalScrollIndicator = FALSE;
    }
    return _mainScroll;
}


- (NSArray*)vcList{
    if (!_vcList) {
        _vcList = @[@"VCUnConfirm",@"VCUnVerify",@"VCUnSend",@"VCUnReceive",@"VCOrderContaier"];
    }
    return _vcList;
}


- (ViewTabOrder*)tabOrder{
    if (!_tabOrder) {
        _tabOrder = [[ViewTabOrder alloc]initWithFrame:CGRectMake(0, NAV_STATUS_HEIGHT, DEVICEWIDTH, [ViewTabOrder calHeight])];
        _tabOrder.curIndex = 0;
        _tabOrder.delegate = self;
    }
    return _tabOrder;
}

/*


 */
@end
