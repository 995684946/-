//
//  IntroduceScrollView.h
//  豆瓣
//
//  Created by anyurchao on 15/9/26.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import <UIKit/UIKit.h>
//2
@interface IntroduceScrollView : UIScrollView

@property (nonatomic ,strong) UILabel *label;
@property(nonatomic,assign)CGFloat height;


-(instancetype) initWithFrame:(CGRect)frame
                        String:(NSString *)string;

@property(nonatomic,copy)  NSString  *text;
@property(nonatomic,retain)UIFont  *font;
@property(nonatomic,retain)UIColor *textColor;
@property(nonatomic,copy)  UIColor   *backgroundColor;


-(void)setText:(NSString *)text;
-(void)setFont:(UIFont *)font;
-(void)setTextColor:(UIColor *)textColor;
-(void)setBackgroundColor:(UIColor *)backgroundColor;





- (CGFloat)caleHeightForCellWithLabel:(UILabel*)label;
+(CGFloat)caleHeightForCellWithLabel:(UILabel*)label;



@end
