//
//  YCDelegate.h
//  你听啥
//
//  Created by anyurchao on 15/10/21.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YCDelegate : NSObject <UIApplicationDelegate>


@property(nonatomic,strong)UIWindow *window;

@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property(nonatomic,strong)UITabBarController *tabBarContraller;

@property(nonatomic,strong)UINavigationController *mainNavigationController;
@property(nonatomic,strong)UINavigationController *popSoundNavigationController;
@property(nonatomic,strong)UINavigationController *popOperaNavigationController;

//@property(nonatomic,strong)UITabBarController *mainNavigationController;
//
//@property(nonatomic,strong)UINavigationController *tabBarContraller;


@property (nonatomic, assign) BOOL successed;
@property(nonatomic,strong)NSString *Namestr;

@end
