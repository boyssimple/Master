
//
//  NetUrl.h
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#ifndef NetUrl_h
#define NetUrl_h



#if DEBUG
#define Base_Url @"113.204.168.170:4322/"
#else
#define Base_Url @"masterzuo.cartechfin.com/"
#endif


//用户
#define net_user_login @"system/UserMobileTran.do?login"                      //用户登录
#define net_user_customer @"shop/CustomerInfoMobileTran.do?getUserCustomer"   //当前业务员列表
#define net_user_cart_list @"system/UserMobileTran.do?queryMyCar"              //获取购物车
#define net_user_cart_add @"system/UserMobileTran.do?addGoodsToMyCar"              //添加购物车
#define net_user_cart_batch_add @"system/UserMobileTran.do?addGoodsToMyCarBatch"              //批量加入购物车
#define net_user_cart_setup @"system/UserMobileTran.do?setMyCarGoodsNum"              //设置购物车


#define net_user_cart_del @"system/UserMobileTran.do?deleteGoodsFromMyCar"              //删除购物车
#define net_user_msg @"system/UserMobileTran.do?queryMessagesUnreadNum"              //获取消息
#define net_user_msg_list @"system/UserMobileTran.do?queryMessages"              //获取消息列表
#define net_user_sms_send @"system/UserMobileTran.do?sendSms"              //发送验证码
#define net_user_update_password @"system/UserMobileTran.do?updatePass"              //修改密码


//商品
#define net_goods_category @"shop/GoodsMobileTran.do?getGoodsTypeList"  //获取分类列表
#define net_goods_list @"shop/GoodsMobileTran.do?getGoodsList"          //获取商品列表
#define net_user_alwaysbuy_goods @"shop/GoodsMobileTran.do?getEchoGoodsList"          //获取常购商品列表
#define net_goods_detail @"shop/GoodsMobileTran.do?getGoodsInfo"       //获取商品详情
#define net_goods_carouse_list @"shop/GoodsCarouselMobileTran.do?getGoodsCarouselList"       //获取轮播图
#define net_goods_guide_list @"shop/GoodsCarouselMobileTran.do?getBaseSlidePicList"       //获取引导图
#define net_user_query_order @"shop/OrderMobileTran.do?queryMyOrder"       //获取订单
#define net_order_goods_list @"shop/OrderMobileTran.do?queryOrderDetail"       //获取订单物品列表
#define net_notice_list @"system/UserMobileTran.do?queryMessages"       //通知列表
#define net_order_confirm @"shop/OrderMobileTran.do?sureOrder"       //确认订单
#define net_order_cancel @"shop/OrderMobileTran.do?cancelOrder"       //取消订单
#define net_order_sign @"shop/OrderMobileTran.do?signOrder"       //签收订单
#define net_cart_num @"system/UserMobileTran.do?queryMyCarNum"       //购物车数量
#define net_save_order @"shop/OrderMobileTran.do?saveOrder"       //下单
#define net_order_detail @"shop/OrderMobileTran.do?queryOrderInfo"       //定单信息
#define net_order_customer_bill_org @"shop/CustomerInfoMobileTran.do?getCustomerBillOrg"       //开票单位
#define net_order_send_info @"shop/OrderMobileTran.do?queryOrderSendInfo"       //发货单
#define net_order_check_data @"shop/CustomerInfoMobileTran.do?getCustomerBalanceDataByCusId"       //订单对帐
#define net_order_query_num @"shop/OrderMobileTran.do?queryMyOrderNum"       //订单数量
#define net_goods_new_list @"shop/GoodsMobileTran.do?getNewGoodsList"       //推荐新品
#define net_invoice_detail_list @"shop/OrderMobileTran.do?queryOrderSendDetail"       //发货单
#define net_account_list @"shop/OrderMobileTran.do?queryCaBill"       //对帐单列表
#define net_account_list_detail @"shop/OrderMobileTran.do?queryCaBillOrderDetail"       //对帐单详情
#define net_account_list_pay_detail @"shop/OrderMobileTran.do?queryCaBillPayDetail"       //付款明细
#define net_account_confirm_bill @"shop/OrderMobileTran.do?setCaBillStatus"       //确认对帐单
#define net_queryCustomerCredit @"shop/OrderMobileTran.do?queryCustomerCredit"       //获取客户信用额度
#define net_queryCreditPayOrder @"shop/OrderMobileTran.do?queryCreditPayOrder"       //欠款订单
#define net_orderCreditPay @"shop/OrderMobileTran.do?orderCreditPay"       //信用额度支付
#define net_app_version @"system/UserMobileTran.do?getAppVersion"       //版本
#define net_updateUserInfo @"system/UserMobileTran.do?updateUserInfo"       //修改用户信息
#define net_userPhotoUpload @"system/UserMobileTran.do?userPhotoUpload"       //上传头像
#define net_getUserInfo @"system/UserMobileTran.do?getUserInfoByUserId"       //获取用户信息

#define OPEN_ORDER_LIST @"OPEN_ORDER_LIST"       //打开订单通知





#endif /* NetUrl_h */
