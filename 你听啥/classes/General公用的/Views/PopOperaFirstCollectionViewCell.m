//
//  PopOperaFirstCollectionViewCell.m
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopOperaFirstCollectionViewCell.h"

@implementation PopOperaFirstCollectionViewCell

- (void)setPopMusic:(PopMusic *)popMusic
{
    self.LabelName.text = popMusic.tname;
    [self.ImgView sd_setImageWithURL:[NSURL URLWithString:popMusic.cover_path] placeholderImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];
    
}






- (void)awakeFromNib {
    // Initialization code
}

@end
