//
//  LTView.m
//  dsafas
//
//  Created by anyurchao on 15/9/4.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import "LTView.h"
@interface LTView ()



@end
@implementation LTView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.3, self.frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        
        [self addSubview:label];
        self.label = label;
        
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(_label.frame.size.width, 0, self.frame.size.width*0.7, self.frame.size.height)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
//        textField.userInteractionEnabled = NO;
        [self addSubview:textField];
        self.textField = textField;
    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textFieldText:(NSString *)textFieldText placeHoder:(NSString *)placeHoder{
    if (self = [self initWithFrame:frame]) {
        self.label.text = text;
        self.textField.text = textFieldText;
        self.textField.placeholder = placeHoder;
    }return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame
                        text:(NSString *)text
                  placeHoder:(NSString *)placeHoder{
    
    if (self = [self initWithFrame:frame]) {
        self.label.text = text;
        self.textField.placeholder = placeHoder;
    }return self;

}


-(void)setKeyboardAppearance:(UIKeyboardAppearance)keyboardAppearance{
    self.textField.keyboardAppearance = keyboardAppearance;
}
-(void)setSecureTextEntry:(BOOL)secureTextEntry{
    self.textField.secureTextEntry = secureTextEntry;
}
-(void)setDelegate:(id<UITextFieldDelegate>)delegate{
    self.textField.delegate = delegate;
}
-(void)setText:(NSString *)text{
    self.textField.text = text;
}
-(NSString *)text{
    return _textField.text;
}

-(void)shake{
    
    [self shakeTextField:self];
}

-(void)shakeTextField:(UIView *)view{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x + 10, position.y);
    CGPoint right = CGPointMake(position.x - 10, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.06];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

@end
