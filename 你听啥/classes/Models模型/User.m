//
//  User.m
//  豆瓣2
//
//  Created by anyurchao on 15/10/3.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@" %@  %@  %@  %@", _name,_password,_email,_phone];
}
@end
