//
//  PopMusicTherd2.m
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusicTherd2.h"

@implementation PopMusicTherd2

- (void)setThere:(PopThered *)there
{
    [self.imagView sd_setImageWithURL:[NSURL URLWithString:there.coverLarge] placeholderImage:[UIImage imageNamed:@"17153115_1363673599"]];
    
    
    self.labelText.text = there.title;
    self.labelTaps.text = there.tags;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
