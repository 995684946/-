//
//  PopMusic.h
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopMusic : NSObject

//第一页面
@property(nonatomic,strong)NSString *tname,*cover_path;
@property(nonatomic,assign)NSInteger category_id;

//第二页面
@property(nonatomic,strong)NSString *albumCoverUrl290,*lastUptrackTitle,*nickname,*tags,*title;
@property(nonatomic,assign)NSInteger albumId,ID,lastUptrackAt,lastUptrackId,playsCounts,tracks,uid;




@end
