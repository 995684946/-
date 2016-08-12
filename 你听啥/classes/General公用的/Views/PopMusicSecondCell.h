//
//  PopMusicSecondCell.h
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopMusicSecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewMain;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelTapsName;
@property (weak, nonatomic) IBOutlet UILabel *labelTracks;
@property (weak, nonatomic) IBOutlet UILabel *labelPlay;
@property (weak, nonatomic) IBOutlet UILabel *labelRefesh;


@property(nonatomic,strong)PopMusic *popMusic;




@end
