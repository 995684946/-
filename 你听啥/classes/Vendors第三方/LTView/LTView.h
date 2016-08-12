//
//  LTView.h
//  dsafas
//
//  Created by anyurchao on 15/9/4.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LTView : UIView
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *label;


-(instancetype)initWithFrame:(CGRect)frame
                        text:(NSString *)text
               textFieldText:(NSString *)textFieldText
                  placeHoder:(NSString *)placeHoder;


-(instancetype)initWithFrame:(CGRect)frame
                        text:(NSString *)text
                  placeHoder:(NSString *)placeHoder;






@property(nonatomic) UIKeyboardAppearance keyboardAppearance; 
@property(nonatomic) BOOL secureTextEntry; 
@property(nonatomic,strong)id <UITextFieldDelegate> delegate;
@property(nonatomic,strong)NSString *text;

-(void)setKeyboardAppearance:(UIKeyboardAppearance)keyboardAppearance;
-(void)setSecureTextEntry:(BOOL)secureTextEntry;
-(void)setDelegate:(id<UITextFieldDelegate>)delegate;
-(void)setText:(NSString *)text;
-(NSString *)text;

- (void)shake;



@end
