//
//  Custom.h
//  LeftMaster
//
//  Created by simple on 2018/4/25.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Custom : NSObject
@property(nonatomic,strong)NSString *fd_bill_org_id;
@property(nonatomic,strong)NSString *fd_bill_org_name;
@property(nonatomic,strong)NSString *fd_customer_id;
@property(nonatomic,assign)BOOL fd_default;
@property(nonatomic,strong)NSString *fd_name;
@property(nonatomic,assign)BOOL selected;

- (void)parse:(NSDictionary*)data;
@end
