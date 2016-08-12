//
//  PopsoundsColloectionSecondsCell.m
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopsoundsColloectionSecondsCell.h"

@implementation PopsoundsColloectionSecondsCell

- (void)setPopMusic:(PopMusic *)popMusic
{
    [self.ImgView sd_setImageWithURL:[NSURL URLWithString:popMusic.albumCoverUrl290] placeholderImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];
    
    self.LabelName.text = popMusic.title;
    self.LabelCount.text = [NSString stringWithFormat:@"%ld",(long)popMusic.playsCounts];
    self.LabelVolumCount.text = [NSString stringWithFormat:@"%ld",popMusic.tracks];
    
    
    NSInteger durTime = popMusic.lastUptrackId / 3600;
    
    if ( 0 < durTime && durTime <= 1) {
        self.labelLast.text = @"刚刚";
    }
    if ( 1< durTime && durTime <= 3 ) {
        self.labelLast.text = @"1小时前";
    }
    if (  3< durTime && durTime <= 24 ) {
        self.labelLast.text = @"3小时前";
    }
    if ( 24 < durTime && durTime <= 48){
        self.labelLast.text = @"1天前";
    }else {
        self.labelLast.text = @"超过2天未更新";
    }
}



- (void)awakeFromNib {
    // Initialization code
}

@end
