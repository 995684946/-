//
//  PopOperaFirstCollectionViewCell.h
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopOperaFirstCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ImgView;


@property (weak, nonatomic) IBOutlet UILabel *LabelName;


@property(nonatomic,strong)PopMusic *popMusic;



@end
