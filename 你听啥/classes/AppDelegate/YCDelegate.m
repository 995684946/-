//
//  YCDelegate.m
//  你听啥
//
//  Created by anyurchao on 15/10/21.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "YCDelegate.h"
#import "sideHeadCell.h"
#import "UMSocialData.h"
@implementation YCDelegate 


- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
//        
//        UIViewController *infoVC = [[UIViewController alloc] init];
//        
//        self.window.rootViewController = infoVC;
//        
//        NSLog(@"第一次启动");
//    }else{
//        NSLog(@"已经不是第一次启动了");
//    }

    

    
    //  TabBarController
    
//    5633176067e58e3e8c002cd3
    
    [UMSocialData setAppKey:@"5633176067e58e3e8c002cd3"];

    
    
    self.LeftSlideVC =  [LeftSlideViewController new];
   
    self.mainNavigationController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopMusicNavagation"];
    
      LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
    
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    
  
    
    self.tabBarContraller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabBarController"];
    
 
    
    self.popSoundNavigationController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopSoundNavagation"];
    self.popOperaNavigationController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopOperaNavagation"];
    
    
    
    NSArray *Array = @[self.LeftSlideVC,self.popSoundNavigationController,self.popOperaNavigationController];
    
    
    
    self.tabBarContraller.viewControllers = Array;
    
    self.window.rootViewController = self.tabBarContraller;

    
    self.tabBarContraller.tabBar.tintColor = [UIColor whiteColor];
    
    self.tabBarContraller.tabBar.items[0].image = [UIImage imageNamed:@"grey_music_32px_580017_easyicon.net.png"];
    self.tabBarContraller.tabBar.items[0].title = @"PopMusic";
    return YES;
}



- (void) applicationWillResignActive:(UIApplication *)application
{
    
}

- (void) applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void) applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void) applicationWillTerminate:(UIApplication *)application
{
    
}



@end
