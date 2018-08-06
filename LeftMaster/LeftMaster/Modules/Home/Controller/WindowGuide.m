//
//  WindowGuide.m
//  LeftMaster
//
//  Created by simple on 2018/4/19.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "WindowGuide.h"
#import "CollCellGuide.h"
#import "RequestBeanSlidePicList.h"

@interface WindowGuide()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CommonDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIPageControl* pageControl;
@property (nonatomic, strong) UICollectionView* collectionView;

@property (nonatomic, strong) UIButton* dismissButton;
@end

@implementation WindowGuide

- (id)init
{
    self = [super initWithFrame:(CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size}];
    if (self) {
        self.dataSource = [NSMutableArray array];
        self.windowLevel = UIWindowLevelAlert;
        _mainView = [[UIView alloc] initWithFrame:self.frame];
        _mainView.backgroundColor = [UIColor whiteColor];
        guideWindow = self;
        [self addSubview:_mainView];
        [self setupSubviews];
        [self loadData];
    }
    
    return self;
}

- (void)loadData{
    RequestBeanSlidePicList *requestBean = [RequestBeanSlidePicList new];
    requestBean.page_current = 1;
    requestBean.page_size = 10;
    __weak typeof(self) weakself = self;
    
    [NetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanSlidePicList *response = responseBean;
            if (response.success) {
                if (response.data) {
                    NSArray *rows = [response.data jk_arrayForKey:@"rows"];
                    if (rows) {
                        [weakself.dataSource removeAllObjects];
                        for (NSDictionary *data in rows) {
                            [weakself.dataSource addObject:[data jk_stringForKey:@"FILE_PATH"]];
                        }
                        [weakself resetBase];
                    }
                }
            }
        }
    }];
}

- (void)resetBase{
    self.pageControl.numberOfPages = self.dataSource.count;
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    
    self.pageControl.frame = CGRectMake((CGRectGetWidth(self.mainView.frame) - size.width) / 2,
                                        CGRectGetHeight(self.mainView.frame) - size.height,
                                        size.width, size.height);
    if(self.dataSource.count == 1){
        self.dismissButton.hidden = NO;
    }
    [self.collectionView reloadData];
}

- (void)setupSubviews{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.mainView.bounds collectionViewLayout:layout];
    self.collectionView.bounces = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    if (@available(*,iOS 11)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.collectionView registerClass:[CollCellGuide class] forCellWithReuseIdentifier:GuaidViewCellID];
    
    [self.mainView addSubview:self.collectionView];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.numberOfPages = self.dataSource.count;
    [self.mainView addSubview:self.pageControl];
    
    CGSize size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    
    self.pageControl.frame = CGRectMake((CGRectGetWidth(self.mainView.frame) - size.width) / 2,
                                        CGRectGetHeight(self.mainView.frame) - size.height,
                                        size.width, size.height);
    
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dismissButton setTitle:@"立即体验" forState:UIControlStateNormal];
    [self.dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.dismissButton sizeToFit];
    CGRect r = self.dismissButton.frame;
    r.size.width = 150*RATIO_WIDHT320;
    r.size.height = 30*RATIO_WIDHT320;
    r.origin.x = (DEVICEWIDTH - r.size.width)/2.0;
    r.origin.y = DEVICEHEIGHT - r.size.height - 20*RATIO_WIDHT320;
    self.dismissButton.frame = r;
    self.dismissButton.hidden = YES;
    self.dismissButton.layer.cornerRadius = r.size.height*0.5;
    self.dismissButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.dismissButton.layer.borderWidth = 1;
    
    [self.mainView addSubview:self.dismissButton];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollCellGuide* cell = [collectionView dequeueReusableCellWithReuseIdentifier:GuaidViewCellID forIndexPath:indexPath];
    [cell.imageView pt_setImage:self.dataSource[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.bounds.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    long current = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    
    self.pageControl.currentPage = lroundf(current);
    self.dismissButton.hidden = self.dataSource.count != current + 1;
}

- (void)dealloc{
    NSLog(@"[DEBUG] delloc:%@",self);
}

- (void)show {
    [self makeKeyAndVisible];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        guideWindow.alpha = 0;
    } completion:^(BOOL finished) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"true" forKey:@"isFirst"];
        [defaults synchronize];
        if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
            [self.delegate clickActionWithIndex:0];
        }
        [guideWindow removeAllSubviews];
        guideWindow = nil;
        [self resignKeyWindow];
        
    }];
    
}

@end
