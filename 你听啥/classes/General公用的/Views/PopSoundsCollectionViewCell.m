//
//  PopSoundsCollectionViewCell.m
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopSoundsCollectionViewCell.h"

@implementation PopSoundsCollectionViewCell

- (void)setPopMusic:(PopMusic *)popMusic
{
    self.labelName.text = popMusic.tname;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:popMusic.cover_path] placeholderImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
