//
//  IntroduceScrollView.m
//  豆瓣
//
//  Created by anyurchao on 15/9/26.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import "IntroduceScrollView.h"

@interface IntroduceScrollView ()



@end

@implementation IntroduceScrollView



-(instancetype) initWithFrame:(CGRect)frame
                        String:(NSString *)string;{
    
    if (self = [super initWithFrame:frame]) {
        
        
       
        
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.text = string;
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.numberOfLines = 0;
        [self addSubview:_label];

        //2
//        self.height = [self caleHeightForCellWithLabel:self.label];
//        
//        CGRect frame = self.label.frame;
//        
//        frame.size.height = _height;
//        
//        self.label.frame = frame;
        
    }
    return self;
}



//1
- (CGFloat)caleHeightForCellWithLabel:(UILabel*)label{
    
    CGSize maxSize = CGSizeMake(self.label.frame.size.width, 10000);
    NSDictionary *dictionary = @{
                                 
                                 NSFontAttributeName:self.label.font
                                 
                                 };
    
    
    CGRect frame = [label.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:dictionary context:nil];
    
    return frame.size.height;
    
}

+(CGFloat)caleHeightForCellWithLabel:(UILabel*)label{
    
    CGFloat height = [[[IntroduceScrollView alloc] init] caleHeightForCellWithLabel:label];
    return height;
    
}



-(void)setText:(NSString *)text{
    
    self.label.text = text;
}

-(NSString *)text{
    
    return self.label.text;
}
-(void)setFont:(UIFont *)font{
    
    self.label.font = font;
    
}
-(void)setTextColor:(UIColor *)textColor{
    
    self.label.textColor = textColor;
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    
    self.label.backgroundColor = backgroundColor;
}



















@end
