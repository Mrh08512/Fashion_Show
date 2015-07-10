//
//  FunctionManageObject.m
//  BangBang
//
//  Created by Joe Chen on 13-9-12.
//  Copyright (c) 2013年 卡莱博尔. All rights reserved.
//

#import "FunctionManageObject.h"
#import "MBProgressHUD+Add.h"

/*
 "Asia/Aden"
 "Asia/Almaty"
 "Asia/Amman"
 "Asia/Anadyr"
 "Asia/Aqtau"
 "Asia/Aqtobe"
 "Asia/Ashgabat"
 "Asia/Ashkhabad"
 "Asia/Baghdad"
 "Asia/Bahrain"
 "Asia/Baku"
 "Asia/Bangkok"
 "Asia/Beirut"
 "Asia/Bishkek"
 ... etc.
 "US/Alaska"
 "US/Aleutian"
 "US/Arizona"
 "US/Central"
 "US/Eastern"
 "US/East-Indiana"
 "US/Hawaii"
 "US/Indiana-Starke"
 "US/Michigan"
 "US/Mountain"
 "US/Pacific"
 "US/Pacific-New"
 "US/Samoa"
 */

#pragma mark - 网络相关
BOOL isInternetAvailable(void)
{
    BOOL isUsable = NO;
    //    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable)
    //    {
    //        isUsable = NO;
    //    }else
    //    {
    //        isUsable = YES;
    //    }
    return isUsable;
}


#pragma mark - 日期相关
/*
 * 获取当前时间String
 */
NSString *GetCurrentTime(void)
{
    NSDate *nowUTC = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *dateString = [dateFormatter stringFromDate:nowUTC];
    
    return dateString;
}



#pragma mark 数据操作相关
/*
 获取应用程序版本信息
 */
NSString *GetAppVersionCodeInfo(void)
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];  //版本号
    //    NSString*appName =[infoDict objectForKey:@"CFBundleDisplayName"];  //应用名字
    return versionNum;
}

/*
 获取设备信息，拼接成一个字符串 eg: iPhone_iOS_4.0
 */
NSString *GetCurrentDeviceBaseInfo(void)
{
    /*
     @"iPhone", @"iPod touch"
     @"iOS"
     @"4.0"
     */
    UIDevice *device = [UIDevice currentDevice];
    return [NSString stringWithFormat:@"%@_%@_%@",[device model],[device systemName],[device systemVersion]];
}


/*
 获取随机数
 */
int getRandomNumber(int from,int to)
{
    return (int)(from + (arc4random() % (to - from + 1)));
}



/*
 * 判断容器是否是空(支持NSArray,NSDictionary,NSString)
 */
BOOL JudgeContainerCountIsNull(id object)
{
    if (object)
    {
        if ([object isKindOfClass:[NSArray class]])
        {
            NSArray *array = (NSArray *)object;
            if ([array count] > 0)
            {
                return NO;
            }else
            {
                return YES;
            }
        }else if ([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dictionary = (NSDictionary *)object;
            if ([[dictionary allKeys] count] > 0)
            {
                return NO;
            }else
            {
                return YES;
            }
        }else if ([object isKindOfClass:[NSString class]])
        {
            NSString *string = (NSString *)object;
            if ([string length] > 0)
            {
                if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"(NULL)"] || [string isEqualToString:@"null"] || [string isEqualToString:@"NULL"])
                {
                    return YES;
                }else
                {
                    return NO;
                }
            }
        }else if ([object isKindOfClass:[NSNumber class]])
        {
            NSNumber *number = (NSNumber *)object;
            if ([number isEqualToNumber:[NSNumber numberWithInt:0]])
            {
                return YES;
            }else
            {
                return NO;
            }
        }
    }
    return YES;
}

NSString *GetDocumentPath(NSString *name)
{
    NSArray *homePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [homePath objectAtIndex:0];
    NSString *paths = [docDir stringByAppendingPathComponent:name];
    return paths;
}

CGRect getStringContentSize(UIFont *font , CGSize size , NSString *string)
{
    CGRect rect;
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    rect  =  [string boundingRectWithSize:size options:options attributes:attributes context:nil];
    return rect;
}

/**********************************程序是否有新版本*********************************/
BOOL IsTheApplicationNewVersion(void)
{
    BOOL isNewVersion = NO;
    
    NSString *key            = (NSString *)kCFBundleVersionKey;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *oldVersion     = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (oldVersion && [oldVersion length] > 0)
    {
        if (![oldVersion isEqualToString:currentVersion])
        {
            isNewVersion = YES;
        }
    }else
    {
        isNewVersion = YES;
    }
    
    SaveCurrentApplicationVersion();
    
    return isNewVersion;
}


void SaveCurrentApplicationVersion(void)
{
    NSString *key            = (NSString *)kCFBundleVersionKey;
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if (currentVersion && [currentVersion length] > 0)
    {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
/**********************************程序是否有新版本*********************************/


#pragma mark - 提示信息相关
/*******************************提示信息*****************************/
void ShowAlertView(NSString *title,NSString *contents,NSString *cancel,NSString *ok)
{
    //#warning 发布之前移除掉return
    
    //    return;
    
    ShowAlertViewWhetherDelegate(title, contents, cancel, ok, nil);
}

void ShowAlertViewWhetherDelegate(NSString *title,NSString *contents,NSString *cancel,NSString *ok,id delegate)
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:title message:contents delegate:delegate cancelButtonTitle:cancel otherButtonTitles:ok,nil];
    [alertview show];
}

/*网络不可用的提示*/
void ShowAlertViewOfInternetCanntUse(void)
{
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲，您的网络貌似不可用哦" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertview show];
}

void ShowProgressHUD(BOOL toShow,id toView)
{
    if (toView)
    {
        if (toShow) {
            [MBProgressHUD showHUDAddedTo:toView animated:YES];
        } else {
            [MBProgressHUD hideHUDForView:toView animated:NO];
        }
    }else
    {
        if (toShow) {
            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        } else {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
        }
    }
}

void ShowProgressHUDWithText(BOOL toShow,id toView,NSString *text)
{
    if (toView)
    {
        if (toShow) {
            [MBProgressHUD showHUDAddedTo:toView animated:YES withText:text];
        } else {
            [MBProgressHUD hideHUDForView:toView animated:NO];
        }
    }else
    {
        if (toShow) {
            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES withText:text];
        } else {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
        }
    }
}


/*!
 *  @brief  显示操作成功的提示
 *
 *  @param message 提示信息
 *  @param toView  应用到的地方
 */
void ShowSucceedAlertHUD(NSString *message,id toView)
{
    if (message && [message length] > 0)
    {
        if (toView)
        {
            [MBProgressHUD showSuccess:message toView:toView];
        }else
        {
            [MBProgressHUD showSuccess:message toView:[UIApplication sharedApplication].keyWindow];
        }
    }
}


/*!
 *  @brief  显示
 *
 *  @param message 提示信息
 *  @param toView  应用到的地方
 */
void ShowFailedAlertHUD(NSString *message, id toView)
{
    if (message && [message length] > 0)
    {
        if (toView)
        {
            [MBProgressHUD showError:message toView:toView];
        }else
        {
            [MBProgressHUD showError:message toView:[UIApplication sharedApplication].keyWindow];
        }
    }
}


#pragma mark - 视图相关




#pragma mark - 系统功能调用
BOOL JudgeDeviceIsUseTelephoneFunction(void)
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"])
    {
        return NO;
    }
    
    return YES;
}

void MakeTelephoneToPersonWithPhonenumber(NSString *phonenumber)
{
    /*
     方法一：
     NSString *number = @"";// 此处读入电话号码
     NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
     
     方法二：
     NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
     
     
     方法三：
     NSString *phoneNum = @"";// 电话号码
     NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
     if ( !phoneCallWebView ) {
     phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的View 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
     }
     [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
     
     
     */
    
    if (phonenumber && [phonenumber length] > 0)
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phonenumber]];
        
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}


#pragma mark - 程序快捷方法


@implementation FunctionManageObject

@end
