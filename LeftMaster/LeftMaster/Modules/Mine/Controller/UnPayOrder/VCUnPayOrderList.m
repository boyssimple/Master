//
//  VCOrderList.m
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCUnPayOrderList.h"
#import "VCOrderContaier.h"
#import "YNPageScrollMenuView.h"
#import "YNPageConfigration.h"

#define TabHeight 40*RATIO_WIDHT750

@interface VCUnPayOrderList ()<UIScrollViewDelegate,YNPageScrollMenuViewDelegate>
@property(nonatomic,strong)YNPageScrollMenuView *vTab;
@property (nonatomic, strong) UIScrollView *mainScroll;
@property (nonatomic, strong) NSArray *vcList;
@end

@implementation VCUnPayOrderList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"欠款订单";
    [self.view addSubview:self.mainScroll];
    [self.view addSubview:self.vTab];
    
    for (NSInteger i = 0 ;i<self.vcList.count;i++) {
        NSString *vcName = [self.vcList objectAtIndex:i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
        [self addChildViewController:vc];
    }
    self.mainScroll.contentSize = CGSizeMake(DEVICEWIDTH * self.vcList.count, 0);
    
    
//    self.tabOrder.curIndex = 0;
    CGPoint point = CGPointMake(0*DEVICEWIDTH, self.mainScroll.contentOffset.y);
    [self.mainScroll setContentOffset:point animated:NO];
    
    [self scrollViewDidEndScrollingAnimation:self.mainScroll];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / DEVICEWIDTH;
    VCOrderContaier *vc = (VCOrderContaier*)[self.childViewControllers objectAtIndex:index];
//    self.tabOrder.curIndex = index;
    [_vTab selectedItemIndex:index animated:TRUE];
    if ([vc isViewLoaded]) {
        return;
    }
    vc.view.frame = CGRectMake(DEVICEWIDTH * index, 0, DEVICEWIDTH, scrollView.height);
    [self.mainScroll addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


- (UIScrollView*)mainScroll{
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, TabHeight + NAV_STATUS_HEIGHT, DEVICEWIDTH, DEVICEHEIGHT- TabHeight - NAV_STATUS_HEIGHT)];
        _mainScroll.contentSize = CGSizeMake(_mainScroll.contentSize.width, 1000);
        _mainScroll.pagingEnabled = YES;
        _mainScroll.delegate = self;
        _mainScroll.showsHorizontalScrollIndicator = FALSE;
    }
    return _mainScroll;
}

- (void)pagescrollMenuViewItemOnClick:(UILabel *)label index:(NSInteger)index{
    CGPoint point = CGPointMake(index*DEVICEWIDTH, self.mainScroll.contentOffset.y);
    [self.mainScroll setContentOffset:point animated:TRUE];
}

- (NSArray*)vcList{
    if (!_vcList) {
        _vcList = @[@"VCUnPayOrderContaier",@"VCHandlingOrderContainer"];
    }
    return _vcList;
}


- (YNPageScrollMenuView*)vTab{
    if(!_vTab){
        YNPageConfigration *config = [YNPageConfigration defaultConfig];
        
        config.showBottomLine = YES;
        config.bottomLineBgColor = APP_Gray_COLOR;
        config.bottomLineHeight = 1;
        config.scrollMenu = NO;
        config.aligmentModeCenter = NO;
        config.lineWidthEqualFontWidth = YES;
        config.showBottomLine = YES;
        config.itemFont = [UIFont systemFontOfSize:14*RATIO_WIDHT750];
        config.selectedItemColor = APP_COLOR;
        config.normalItemColor = APP_BLACK_COLOR;
        NSArray *datas = @[@"待付款",@"已支付"];
        
        _vTab = [YNPageScrollMenuView pagescrollMenuViewWithFrame:CGRectMake(0, NAV_STATUS_HEIGHT, DEVICEWIDTH, TabHeight) titles:datas configration:config delegate:self currentIndex:0];
    }
    return _vTab;
}
@end
