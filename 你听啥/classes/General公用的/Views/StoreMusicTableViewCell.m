//
//  StoreMusicTableViewCell.m
//  你听啥
//
//  Created by anyurchao on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "StoreMusicTableViewCell.h"

@implementation StoreMusicTableViewCell

- (void)setThere:(PopThered *)there
{
    
    self.labelTitle.text = there.title;
    
    NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
        path1 = [path1 stringByAppendingFormat:@"/%@%@",there.title,@".jpg"];
    
        NSData *resultData = [NSData dataWithContentsOfFile:path1];
    
        UIImage *resultimage = [UIImage imageWithData:resultData];
    
    
        if (resultimage == nil) {
    
            self.imgView.image = [UIImage imageNamed:@"17153115_1363673599.jpg"];

        }
        else
        {
    
            self.imgView.image = resultimage;
        
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
