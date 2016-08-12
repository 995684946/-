//
//  PopMusicCollectionViewCell.m
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusicCollectionViewCell.h"


@implementation PopMusicCollectionViewCell

- (void)setPopMusic:(PopMusic *)popMusic
{

    self.labelName.text = popMusic.tname;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:popMusic.cover_path] placeholderImage:[UIImage imageNamed:@""]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
