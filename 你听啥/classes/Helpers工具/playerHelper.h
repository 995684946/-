//
//  playerHelper.h
//  MusicssssssssssssPlayer
//
//  Created by anyurchao on 15/10/12.
//  Copyright © 2015年 anyurchao. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol playerHelperDelegate <NSObject>

- (void)playerWithTime:(NSTimeInterval)time;
- (void)didStop;


@end
@interface playerHelper : NSObject

@property (nonatomic,strong)id <playerHelperDelegate> delegate;
@property(nonatomic,assign)CGFloat sound;
@property(nonatomic,assign)BOOL isPlaying;

+(instancetype)shareHelper;

- (void)playerWithUrlString:(NSString *)Urlstring;

- (void)playerWithUrl:(NSURL *)Url;

- (void)play;
- (void)stop;
- (void)seekToTime:(NSTimeInterval)time;

@end
