//
//  ImageLoad.h
//  你听啥
//
//  Created by anyurchao on 15/10/24.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SendArray) (NSMutableArray *array);
@interface ImageLoad : NSObject

+ (instancetype) shareImageLoad;

- (void) loadDataPopMusicblock:(Block)block;
@property(nonatomic,strong)NSMutableArray *allarray;

@end
