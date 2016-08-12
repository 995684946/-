//
//  PopMusic.m
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusic.h"

@implementation PopMusic

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"id"]) {
        
        self.ID = [value integerValue];
        
    }
    
//    NSLog(@"%@",key);
}




















@end
