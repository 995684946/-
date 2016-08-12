//
//  PhotoScrollView.h
//  Photos_Demo
//
//  Created by anyurchao on 15/9/9.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoScrollView : UIScrollView

#pragma mark -声明自定义初始化方法
-(instancetype)initWithFrame:(CGRect)frame
                   imageName:(NSString *)imageName;

#pragma mark -恢复正常状态

- (void) normal;








@end
