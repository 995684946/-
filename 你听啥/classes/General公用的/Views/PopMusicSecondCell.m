//
//  PopMusicSecondCell.m
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusicSecondCell.h"

@implementation PopMusicSecondCell


- (void)setPopMusic:(PopMusic *)popMusic
{
    [self.imgViewMain sd_setImageWithURL:[NSURL URLWithString:popMusic.albumCoverUrl290] placeholderImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];
    
    self.labelName.text = popMusic.title;
    self.labelTapsName.text = popMusic.tags;
    self.labelPlay.text = [NSString stringWithFormat:@"%ld",(long)popMusic.playsCounts];
    self.labelTracks.text = [NSString stringWithFormat:@"%ld",popMusic.tracks];
    

    NSInteger durTime = popMusic.lastUptrackId / 3600;
    
    if ( 0 < durTime && durTime <= 1) {
        self.labelRefesh.text = @"刚刚";
    }
    if ( 1< durTime && durTime <= 3 ) {
        self.labelRefesh.text = @"1小时前";
    }
    if (  3< durTime && durTime <= 24 ) {
        self.labelRefesh.text = @"3小时前";
    }
    if ( 24 < durTime && durTime <= 48){
        self.labelRefesh.text = @"1天前";
    }else {
        self.labelRefesh.text = @"超过2天未更新";
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
