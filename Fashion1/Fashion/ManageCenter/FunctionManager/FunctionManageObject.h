//
//  FunctionManageObject.h
//  BangBang
//
//  Created by Joe Chen on 13-9-12.
//  Copyright (c) 2013年 卡莱博尔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark - 网络相关
/*
 * 判断网络是否可用
 */
BOOL isInternetAvailable(void);



#pragma mark - 日期相关

/*
 * 获取当前时间String
 */
NSString *GetCurrentTime(void);



#pragma mark - 数据操作相关
/*
 获取应用程序版本信息
 */
NSString *GetAppVersionCodeInfo(void);

/*
 获取设备信息，拼接成一个字符串 eg: iPhone_iOS_4.0
 */
NSString *GetCurrentDeviceBaseInfo(void);


/*
 获取随机数
 */
int getRandomNumber(int from,int to);


/*
 * 判断容器是否是空,是否是零(支持NSArray,NSDictionary,NSString,NSNumber)
 */
BOOL JudgeContainerCountIsNull(id object);

/*获取文件路径*/
NSString *GetDocumentPath(NSString *name);

/*获取文字大小长度*/
CGRect getStringContentSize(UIFont *font , CGSize size , NSString *string);




/**********************************程序是否有新版本*********************************/
BOOL IsTheApplicationNewVersion(void);
void SaveCurrentApplicationVersion(void);
/**********************************程序是否有新版本*********************************/


#pragma mark - 提示信息相关
//系统提示框
void ShowAlertView(NSString *title,NSString *contents,NSString *cancel,NSString *ok);
void ShowAlertViewWhetherDelegate(NSString *title,NSString *contents,NSString *cancel,NSString *ok,id delegate);
void ShowProgressHUD(BOOL toShow,id toView);  //默认是[UIApplication sharedApplication].keyWindow
void ShowProgressHUDWithText(BOOL toShow,id toView,NSString *text);
/*!
 *  @brief  显示操作成功的提示
 *
 *  @param message 提示信息
 *  @param toView  应用到的地方
 */
void ShowSucceedAlertHUD(NSString *message,id toView);
/*!
 *  @brief  显示
 *
 *  @param message 提示信息
 *  @param toView  应用到的地方
 */
void ShowFailedAlertHUD(NSString *message, id toView);


/*网络不可用的提示*/
void ShowAlertViewOfInternetCanntUse(void);




#pragma mark - 视图相关




#pragma mark - 系统功能调用
/*
 * 判断设备是否支持打电话
 */
BOOL JudgeDeviceIsUseTelephoneFunction(void);

/*
 * 打电话功能
 */
void MakeTelephoneToPersonWithPhonenumber(NSString *phonenumber);



#pragma mark - 程序快捷方法
NSString *GetHomePageDataPath(void);


// 获取当前用户本地商店
NSString *GetShopLocalPath(void);


// 当前类别
NSString *GetShopCategoryPath(void);


// 当前商品缓存路劲
NSString *GetShopProductPath(void);
@interface FunctionManageObject : NSObject

@end
