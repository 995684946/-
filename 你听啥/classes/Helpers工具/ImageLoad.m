//
//  ImageLoad.m
//  你听啥
//
//  Created by anyurchao on 15/10/24.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "ImageLoad.h"
@interface ImageLoad ()
@property (nonatomic,strong)NSMutableArray *array;
@end

@implementation ImageLoad

+ (instancetype) shareImageLoad
{
    static ImageLoad *image = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        image = [ImageLoad new];
    });
    return image;
}

//- (instancetype) init
//{
//    if (self = [super init]) {
//        
//        [self addAllViews];
//        
//    }
//    return self;
//}
//
//- (void)addAllViews
//{
//    
//    
//    
//    
//}

- (void) loadDataPopMusicblock:(Block)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:MusciUrlFirst]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!data) {
                return ;
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            _array = [[NSMutableArray alloc] initWithCapacity:10];
            
            for (NSDictionary *dic in [dict objectForKey:@"list"]) {
                
                PopMusic *popMusic = [PopMusic new];
                [popMusic setValuesForKeysWithDictionary:dic];
                [_array addObject:popMusic];
                
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block(self.array);
                
            });
            
        }];
        
        [task resume];
        
    });
}

- (NSMutableArray *)array
{
    if (!_array) {
        
        self.array = [NSMutableArray array];
        
    }
    return _array;
    
}

- (NSMutableArray *)allarray
{
    return [self.array copy];
    
}



@end
