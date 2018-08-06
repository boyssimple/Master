//
//  CellCategoryHome.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellCategoryHome.h"
#import "VCCategory.h"
#import "CollCellCategoryHome.h"

@interface CellCategoryHome()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collView;
@end

@implementation CellCategoryHome



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 20*RATIO_WIDHT320;
        layout.minimumInteritemSpacing = 10*RATIO_WIDHT320;
        _collView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) collectionViewLayout:layout];
        [_collView registerClass:[CollCellCategoryHome class] forCellWithReuseIdentifier:@"CollCellCategoryHome"];
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
    static NSString*identifier = @"CollCellCategoryHome";
    CollCellCategoryHome *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateData:data];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat h = [CollCellCategoryHome calHeight];
    CGFloat w = (DEVICEWIDTH - 20*RATIO_WIDHT320 - 3*RATIO_WIDHT320*10)/4.0;
    return CGSizeMake(w, h);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    VCCategory *vc = [[VCCategory alloc]init];
    vc.cateId = [data jk_stringForKey:@"GOODSTYPE_ID"];
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

+ (CGFloat)calHeight:(NSInteger)num{
    NSInteger col = num/4;
    if (num % 4 != 0) {
        col += 1;
    }
    
    return 30*RATIO_WIDHT320 + [CollCellCategoryHome calHeight]*col + (col-1)*20*RATIO_WIDHT320;
}

@end
