//
//  PopSoundsTherdTableViewCell.h
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopSoundsTherdTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet UILabel *LabelPlayCounts;
@property (weak, nonatomic) IBOutlet UILabel *labelShares;
@property (weak, nonatomic) IBOutlet UILabel *labelUpdate;

@property (nonatomic,strong) PopThered *popThered;
@end
