//
//  DBManager.h
//  你听啥
//
//  Created by anyurchao on 15/10/27.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Block) ();
@interface DBManager : NSObject
+ (instancetype)showDBManager;

-(void)openDBManager;
-(void)closeDBmanager;

//创建表
- (void)createTable;

//增
- (void)insertPopThered:(PopThered *)PopThered;
//删
- (void)deletefromTitle:(NSString *)Title;

//查
- (NSArray *)selectAll;
//
- (NSArray *)selectPopName:(NSString *)PopName;













@end
