//
//  VCWriteOrderAgain.h
//  LeftMaster
//
//  Created by simple on 2018/4/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCBase.h"

@interface VCWriteOrderAgain : VCBase
@property(nonatomic,strong)NSString *orderId;
- (void)reloadDatas:(NSArray*)datas;
@end
