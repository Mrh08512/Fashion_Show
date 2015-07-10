//
//  NSString+StringManage.h
//  BangBang
//
//  Created by Joe Chen on 13-10-6.
//  Copyright (c) 2013年 卡莱博尔. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 宏管理 -
#ifndef __has_feature
#define __has_feature(x) 0
#endif
#ifndef __has_extension
#define __has_extension __has_feature // Compatibility with pre-3.0 compilers.
#endif

#if __has_feature(objc_arc) && __clang_major__ >= 3
#define TT_ARC_ENABLED 1
#endif // __has_feature(objc_arc)

#if TT_ARC_ENABLED
#define TT_RETAIN(xx) (xx)
#define TT_RELEASE(xx)  xx = nil
#define TT_AUTORELEASE(xx)  (xx)
#else
#define TT_RETAIN(xx)           [xx retain]
#define TT_RELEASE(xx)          [xx release], xx = nil
#define TT_AUTORELEASE(xx)      [xx autorelease]
#endif

#ifndef TTRSLog
#if DEBUG
# define TTRSLog(fmt, ...) //NSLog((@"%s [Line %d] " fmt),__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define TTRSLog(fmt, ...)
#endif
#endif

/*
 * 判断当前系统是否大于自定的version
 */
#define SYSTEM_VERSION_MORETHAN(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedDescending)
/*
 * 判断当前系统是否小于自定的version
 */
#define SYSTEM_VERSION_LESS_THAN(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending)


/*
 * 判断当前系统是否是IOS7
 */
#define isIOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)?YES:NO)
/*
 * 获取Document的路径
 */
#define DocumentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

// 获取图片比例大小
#define ImageMultiplier(height,width) (CGFloat)height/width
#define IMAGE_WITH_NAME(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:name]]

#define COLOR_CUSTOM(redColor,greenColor,blueColor,alphaColor) [UIColor colorWithRed:redColor/255.0 green:greenColor/255.0 blue:blueColor/255.0 alpha:alphaColor]

#define SCREEN_HIGHT     [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width

/*
 *  导航栏 自定义高度
 */
#define kDockHeight 50.0

#pragma mark - 静态文字信息管理 -



#pragma mark - 正则表达式 -



#pragma mark - 通知名管理 -



#pragma mark - SQLite数据存储table名 -



#pragma mark - 数据库的DBName -



#pragma mark - 数据存储－文件名管理 -


#pragma mark - 数据请求超时时间限定 -
#define NET_REQUEST_OUTTIMELIMIT 30


#pragma mark - App数据同步管理机制 -



#pragma mark - App全局数据设置 -

//应用是否第一次启动使用的标识
#define APP_FIRST_OPEN_MARK @"bsjWBNappFirstOpenMark"


@interface NSString (StringManage)

- (BOOL)containsString:(NSString *)aString;
- (NSString*)telephoneWithReformat;
+(BOOL)isNullString:(id)vaule;


/**************************字符加密相关******************************/
//16位MD5加密方式
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString;
//32位MD5加密方式
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString;
//sha1加密方式
+ (NSString *)getSha1String:(NSString *)srcString;
//sha256加密方式
+ (NSString *)getSha256String:(NSString *)srcString;
//sha384加密方式
+ (NSString *)getSha384String:(NSString *)srcString;
//sha512加密方式
+ (NSString*) getSha512String:(NSString*)srcString;
/**************************字符加密相关******************************/

@end
