//
//  FMUtility.m
//  Sample
//
//  Created by wjy on 2018/3/21.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "FMUtility.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import <AdSupport/ASIdentifierManager.h>

@implementation FMUtility

+ (BOOL)isIPhoneXSeries
{
    BOOL iPhoneXSeries = NO;
    if ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        // 非iPhone设备
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        /**
         鉴于iPhone X/XS/XR/XS Max底部都会有安全距离，
         所以可以利用 safeAreaInsets.bottom > 0.0 (iOS11 及以后)
         来判断是否是iPhone X/XS/XR/XS Max。
         */
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}

@end
