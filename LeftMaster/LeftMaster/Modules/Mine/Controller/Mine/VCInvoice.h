//
//  VCInvoice.h
//  LeftMaster
//
//  Created by simple on 2018/4/12.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCBase.h"

@interface VCInvoice : VCBase
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,assign)NSInteger status;
@end
