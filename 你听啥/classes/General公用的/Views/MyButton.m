//
//  MyButton.m
//  ooihoi
//
//  Created by anyurchao on 15/9/4.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import "MyButton.h"
@interface MyButton()
{
    id _target;
    SEL _action;
    UIControlEvents _controlEvents;
}
@end

@implementation MyButton

-(void)addtarget:(id)targate
          action:(SEL)action
forControlEvents:(UIControlEvents )controlEvents{
    _target = targate;
    _action = action;
    _controlEvents = controlEvents;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_controlEvents == UIControlEventTouchUpInside) {
        [_target performSelector:_action withObject:self];
    }
}











@end
