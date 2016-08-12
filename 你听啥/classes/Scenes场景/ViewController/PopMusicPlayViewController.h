//
//  PopMusicPlayViewController.h
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopMusicPlayViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UISlider *sliderProgress;
@property (weak, nonatomic) IBOutlet UISlider *sliderVolum;
@property (weak, nonatomic) IBOutlet UIButton *PlayerActionModel;

@property(nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSString *PopName;















+ (instancetype) sharePopMusicPlayVC;

@property(nonatomic,strong)PopThered *popThere;

@property(nonatomic,assign)NSInteger index;
@end
