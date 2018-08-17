//
//  RequestBeanUploadImg.h
//  LeftMaster
//
//  Created by simple on 2018/8/15.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBeanUploadImg : AJRequestBeanBase
@property(nonatomic,strong)UIImage *img;
@end

@interface ResponseBeanUploadImg : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
