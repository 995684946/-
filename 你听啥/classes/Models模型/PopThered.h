//
//  PopThered.h
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopThered : NSObject
//第三页面

@property(nonatomic,strong)NSString *categoryName,*coverOrigin,*nickname,*intro,*playUrl64,*title,*coverSmall,*smallLogo,*albumTitle,*albumImage,*avatarPath,*tags,*coverLarge;

@property(nonatomic,assign)NSInteger trackId,shares,tracks,updatedAt,createdAt,albumId,duration,*playtimes;
@end
