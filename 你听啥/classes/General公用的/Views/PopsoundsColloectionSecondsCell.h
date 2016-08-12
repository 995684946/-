//
//  PopsoundsColloectionSecondsCell.h
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopsoundsColloectionSecondsCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *LabelName;
@property (weak, nonatomic) IBOutlet UIImageView *ImgView;
@property (weak, nonatomic) IBOutlet UILabel *LabelVolumCount;
@property (weak, nonatomic) IBOutlet UILabel *LabelCount;
@property (weak, nonatomic) IBOutlet UILabel *labelLast;


@property(nonatomic,strong)PopMusic *popMusic;





@end
