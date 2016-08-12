//
//  PopMusicTherdCell.m
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusicTherdCell.h"

@implementation PopMusicTherdCell




- (void)setPopThered:(PopThered *)popThered
{
    [self.imgMain sd_setImageWithURL:[NSURL URLWithString:popThered.coverLarge] placeholderImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];
    self.labelName.text = popThered.title;
    self.LabelPlayCounts.text = [NSString stringWithFormat:@"%ld",(long)popThered.playtimes];
    self.labelShares.text = [NSString stringWithFormat:@"%ld",popThered.shares];
    NSInteger time = popThered.updatedAt - popThered.createdAt;
    time = time/3600000;
    
    if (time < 24) {
        self.labelUpdate.text = @"1天前";
    }
    if (time>=24 && time < 168 ) {
        self.labelUpdate.text = @"1星期前";
    }
    if (time <= 168 &&time <720) {
        self.labelUpdate.text = @"1月前";
        
    }else{
        self.labelUpdate.text = @"1年前";
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
