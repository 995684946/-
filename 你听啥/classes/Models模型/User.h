//
//  User.h
//  豆瓣2
//
//  Created by anyurchao on 15/10/3.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;



- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
