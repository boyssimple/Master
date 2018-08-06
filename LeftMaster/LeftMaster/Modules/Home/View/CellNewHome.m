//
//  CellCategoryHome.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellNewHome.h"
#import "CollCellNewHome.h"
#import "VCGoods.h"

@interface CellNewHome()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collView;
@end

@implementation CellNewHome



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10*RATIO_WIDHT320;
        layout.minimumInteritemSpacing = 10*RATIO_WIDHT320;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) collectionViewLayout:layout];
        [_collView registerClass:[CollCellNewHome class] forCellWithReuseIdentifier:@"CollCellNewHome"];
        _collView.contentInset = UIEdgeInsetsMake(15*RATIO_WIDHT320, 10*RATIO_WIDHT320, 15*RATIO_WIDHT320, 10*RATIO_WIDHT320);
        _collView.backgroundColor = [UIColor clearColor];
        _collView.delegate = self;
        _collView.dataSource = self;
        _collView.scrollEnabled = NO;
        [self.contentView addSubview:_collView];
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self.collView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CollCellNewHome";
    CollCellNewHome *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateData:data];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = [CollCellNewHome calHeight];
    CGFloat w = (DEVICEWIDTH - 30*RATIO_WIDHT320)/2.0;
    return CGSizeMake(w, h);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    VCGoods *vc = [[VCGoods alloc]init];
    vc.goods_id = [data jk_stringForKey:@"GOODS_ID"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:TRUE];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.collView.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = self.width;
    r.size.height = self.height;
    self.collView.frame = r;
}

+ (CGFloat)calHeight:(NSArray*)arrays{
    NSInteger sec = arrays.count /2;
    if(arrays.count % 2 !=0){
        sec += 1;
    }
    return [CollCellNewHome calHeight]*sec + 30*RATIO_WIDHT320 + (sec-1)*10*RATIO_WIDHT320;
}

@end

