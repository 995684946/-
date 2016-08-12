//
//  RootView.h
//  Photos_Demo
//
//  Created by anyurchao on 15/9/9.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootView : UIView



//最下层的大滚动视图,里面装着PhotoScrollview
@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIPageControl *pageControll;
@property(nonatomic,strong)NSMutableArray *arrayImg;





@end
