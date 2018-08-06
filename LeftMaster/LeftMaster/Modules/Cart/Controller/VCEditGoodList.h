//
//  VCEditGoodList.h
//  LeftMaster
//
//  Created by simple on 2018/4/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCBase.h"
#import "VCWriteOrderAgain.h"

@interface VCEditGoodList : VCBase
@property(nonatomic,strong)NSMutableArray *goodsList;
@property(nonatomic,strong)VCWriteOrderAgain *superVC;
@end
