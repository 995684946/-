//
//  PopMusicTableViewCell.m
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusicTableViewCell.h"

@implementation PopMusicTableViewCell


- (void)setPopMusic:(PopMusic *)popMusic
{
    
    self.labelName.text = popMusic.tname;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:popMusic.cover_path] placeholderImage:[UIImage imageNamed:@""]];
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
