//
//  RootView.m
//  Photos_Demo
//
//  Created by anyurchao on 15/9/9.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import "RootView.h"
#import "PhotoScrollView.h"

@interface RootView ()
@property (nonatomic,strong)NSMutableArray *ImageArray;
@end

@implementation RootView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addAllViews];
    }return self;
}

-(void)addAllViews{
    
    
    //本地的虽有文件名路径
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
    
    for (NSString *Imgstr in tempFileList) {
    
        NSString *string2 = @".jpg";
        NSString *string3 = @".png";
        NSRange range1 = [Imgstr rangeOfString:string2];
        NSRange range2 = [Imgstr rangeOfString:string3];
        
        if (range1.length != 0 || range2.length != 0) {
            
            [self.ImageArray addObject:Imgstr];
           
        
        }

    }
    
    //1.添加大滚动视图
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    
    [self addSubview:self.scrollView];
    
    // 2.添加内容
    NSInteger count = self.ImageArray.count;
    
    if (count == 0) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x - 100, self.center.y, 200, 30)];
        label.text = @"亲,你还没有图片哎!";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor redColor];
        [self addSubview:label];
        
    }
    
    for (int i = 0; i < count; i++) {
        //便利图片名称
        NSString *imageName = self.ImageArray[i];
        
        
        //遍历frame
        CGRect frame =CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x - 200, 40, 400, 30)];
        
     
        [self.arrayImg addObject:imageName];
        
        
        // 创建photoScrollView对象,并添加
        PhotoScrollView *scrollView = [[PhotoScrollView alloc]initWithFrame:frame imageName:imageName];
        
        [self.scrollView addSubview:scrollView];
        NSString *strUrl = [imageName stringByReplacingOccurrencesOfString:@".jpg" withString:@""];
        NSString *strIMG = [strUrl stringByReplacingOccurrencesOfString:@".png" withString:@""];
        
        label.text = strIMG;
        label.font = [UIFont fontWithName:@"Helvetica" size:20];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        [scrollView addSubview:label];
        
        

        
        
    }
    //3.设置相关属性
    _scrollView.contentSize = CGSizeMake(self.frame.size.width *count, self.frame.size.height);
    _scrollView.pagingEnabled = YES;
    
    
    UIPageControl *pageControll = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 40)];
    pageControll.numberOfPages = count;
    pageControll.currentPageIndicatorTintColor = [UIColor greenColor];
    pageControll.pageIndicatorTintColor = [UIColor redColor];
    
    [self addSubview:pageControll];
    self.pageControll = pageControll;
    
}


- (NSMutableArray *)ImageArray
{
    if (!_ImageArray) {
        self.ImageArray = [NSMutableArray array];
    }
    return _ImageArray;
}








- (NSMutableArray *)arrayImg
{
    if (!_arrayImg) {
        self.arrayImg = [NSMutableArray array];
    }
    return _arrayImg;
}




@end
