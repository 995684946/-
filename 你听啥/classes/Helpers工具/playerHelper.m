//
//  playerHelper.m
//  MusicssssssssssssPlayer
//
//  Created by anyurchao on 15/10/12.
//  Copyright © 2015年 anyurchao. All rights reserved.
//

#import "playerHelper.h"

@import AVFoundation;
@interface playerHelper()
@property (nonatomic,strong)AVPlayer *player;
@property (nonatomic,strong)NSTimer *time;

@end

@implementation playerHelper

+(instancetype)shareHelper{
    
    static playerHelper *player = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        player = [playerHelper new];
        
    });
    return player;
    
}

- (instancetype)init{
    
    if (self =[ super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didToStop) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

        
        [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        
    }
    return self;
    
}
- (void)didToStop{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didStop)]) {
        
        [self.delegate didStop];
        
    }
    
}


//Lazy
- (AVPlayer *)player{
    
    if (!_player) {
        
        self.player = [AVPlayer new];
    }
    return _player;
    
}


- (void)playerWithUrlString:(NSString *)Urlstring{
    
    NSURL *url = [NSURL URLWithString:Urlstring];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    [self.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)playerWithUrl:(NSURL *)Url
{

//    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//     NSURL * url=[NSURL fileURLWithPath:@"/Users/anyurchao/Desktop/music.mp3"];
    
//    NSString *path = NSHomeDirectory();
//    
//    path = [path stringByAppendingString:@".mp3"];
//    NSURL *url = [NSURL fileURLWithPath:path];

    AVPlayerItem  *item = [[AVPlayerItem alloc] initWithURL:Url];

    [self.player replaceCurrentItemWithPlayerItem:item];
    
    [self.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"status"]) {
        
        if (self.player.status == AVPlayerStatusReadyToPlay) {
            
            [self play];
            
        }
        
    }

}


- (void)play{
    if (_isPlaying == YES) {
        return;
    }
    
    [self.player play];
    self.isPlaying = YES;
    
    if (self.time != nil) {
    
        return;
    }
    
    self.time = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
}

- (void)timeAction{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerWithTime:)]) {
        
        
        NSTimeInterval time = self.player.currentTime.value / self.player.currentTime.timescale;
        
        [self.delegate playerWithTime:time];
    }
    
}

- (void)stop{
    
    if (_isPlaying == NO) {
        return;
    }
    [self.player pause];
    self.isPlaying = NO;
    [self.time invalidate];
    
    self.time = nil;
    
    
    
}
- (void)seekToTime:(NSTimeInterval)time{
    
   
    [self stop];
    [self.player seekToTime:CMTimeMakeWithSeconds(time, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {
        [self play];
        
    }];
    
    
    
}

- (void)setSound:(CGFloat)sound{
    
    self.player.volume = sound;
    
}

- (CGFloat)sound{
    
    return self.player.volume;
}



@end
