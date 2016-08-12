//
//  changeImageViewController.m
//  你听啥
//
//  Created by anyurchao on 15/11/1.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "changeImageViewController.h"
#import "ImageUtil.h"
#import "ColorMatrix.h"
#import "UMSocial.h"
@interface changeImageViewController ()<UIActionSheetDelegate,UMSocialUIDelegate>

@property (nonatomic, strong) UIImageView *filterView;

@property (nonatomic, strong) UILabel *filterLabel;
@property (nonatomic, strong) UIImage *image;
@end

@implementation changeImageViewController
- (UIImageView *)filterView
{
    if (_filterView == nil) {
        _filterView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 50.0f, self.view.frame.size.width, 200.0f)];
        _filterView.userInteractionEnabled = YES;
        _filterView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _filterView;
}

- (UILabel *)filterLabel
{
    if (_filterLabel == nil) {
        _filterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 300.0f, self.view.frame.size.width, 25.0f)];
        _filterLabel.backgroundColor = [UIColor clearColor];
        _filterLabel.textColor = [UIColor orangeColor];
        _filterLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _filterLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"滤镜";
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
#pragma mark 滤镜
            NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
            //获取图片
            path1 = [path1 stringByAppendingFormat:@"/%@",self.imgStr];
    
            NSData *resultData = [NSData dataWithContentsOfFile:path1];
    
            UIImage *resultimage = [UIImage imageWithData:resultData];

    self.image  =resultimage;
    
    self.filterView.image = resultimage;
    [self.view addSubview:self.filterView];
    
    self.filterLabel.text = @"原图";
    [self.view addSubview:self.filterLabel];
    
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    [sender setTitle:@"滤镜" forState:UIControlStateNormal];
    sender.frame = CGRectMake(self.view.frame.size.width/2.0f - 50.0f, 350.0f, 100.0f, 30.0f);
    sender.backgroundColor = [UIColor redColor];
    sender.layer.cornerRadius = 5.0f;
    [sender addTarget:self action:@selector(senderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];


    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction:)];
    [self.view addGestureRecognizer:tgr];
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lpgrAction:)];
    
    lpgr.minimumPressDuration = 1;
    lpgr.allowableMovement = 1;
    
    [self.view addGestureRecognizer:lpgr];
    
    
    
}

- (void)tgrAction:(UITapGestureRecognizer *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    
}
- (void)lpgrAction:(UILongPressGestureRecognizer *)sender
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5633176067e58e3e8c002cd3"
                                      shareText:@"你要分享的文字"
                                     shareImage:self.filterView.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil]
                                       delegate:self];
    
    
}



- (void)senderAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"滤镜" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"原图",@"LOMO",@"黑白",@"复古",@"哥特",@"锐化",@"淡雅",@"酒红",@"清宁",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色", nil];
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *str = @"";
    switch (buttonIndex) {
        case 0:
            str = @"原图";
            self.filterView.image = _image;
            break;
        case 1:
            str = @"LOMO";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_lomo];
            break;
        case 2:
            str = @"黑白";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_heibai];
            break;
        case 3:
            str = @"复古";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_huajiu];
            break;
        case 4:
            str = @"哥特";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_gete];
            break;
        case 5:
            str = @"锐化";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_ruise];
            break;
        case 6:
            str = @"淡雅";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_danya];
            break;
        case 7:
            str = @"酒红";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_jiuhong];
            break;
        case 8:
            str = @"清宁";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_qingning];
            break;
        case 9:
            str = @"浪漫";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_langman];
            break;
        case 10:
            str = @"光晕";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_guangyun];
            break;
        case 11:
            str = @"蓝调";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_landiao];
            break;
        case 12:
            str = @"梦幻";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_menghuan];
            break;
        case 13:
            str = @"夜色";
            self.filterView.image = [ImageUtil imageWithImage:_image withColorMatrix:colormatrix_yese];
            break;
            
        default:
            break;
    }
    
    self.filterLabel.text = str;
}


- (UIImage *)image
{
    if (!_image) {
        
        self.image = [UIImage new];
    }
    return _image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
