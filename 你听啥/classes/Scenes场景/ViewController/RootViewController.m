//
//  RootViewController.m
//  Photos_Demo
//
//  Created by anyurchao on 15/9/9.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import "RootViewController.h"
#import "RootView.h"
#import "PhotoScrollView.h"
#import "UMSocial.h"

@interface RootViewController ()<UIScrollViewDelegate,UMSocialUIDelegate>
{
    // 记录上一页下标的变量
    NSInteger _previousIndex;
}
@property(nonatomic,strong)RootView *rootView;
@end

@implementation RootViewController

-(void)loadView{
    self.rootView = [[RootView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rootView;
    self.rootView.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.rootView.pageControll addTarget:self action:@selector(pageControllAction:) forControlEvents:UIControlEventValueChanged];
    self.rootView.scrollView.delegate = self;
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction:)];
    
    tgr.numberOfTapsRequired = 2;
    tgr.numberOfTouchesRequired = 1;
    
    [self.rootView addGestureRecognizer:tgr];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lpgrAction:)];

    lpgr.minimumPressDuration = 1;
    lpgr.allowableMovement = 1;
    
    [self.rootView addGestureRecognizer:lpgr];
    
    
    
    UITapGestureRecognizer *tgrImg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrImgAction:)];
    
    tgrImg.numberOfTapsRequired = 1;
    tgrImg.numberOfTouchesRequired = 2;
    
    [self.rootView addGestureRecognizer:tgrImg];

 
}
- (void)tgrImgAction:(UITapGestureRecognizer *)sender
{
    
    NSInteger currentindex= self.rootView.scrollView.contentOffset.x/self.rootView.frame.size.width;
    self.rootView.pageControll.currentPage = currentindex;
     
    changeImageViewController *changeImageVC = [changeImageViewController new];
    
    changeImageVC.imgStr =self.rootView.arrayImg[currentindex];
    
    [self showDetailViewController:changeImageVC sender:nil];
}





- (void)tgrAction:(UITapGestureRecognizer *)sender
{

         [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)lpgrAction:(UILongPressGestureRecognizer *)sender
{
    
    NSInteger currentindex= self.rootView.scrollView.contentOffset.x/self.rootView.frame.size.width;
    self.rootView.pageControll.currentPage = currentindex;
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5633176067e58e3e8c002cd3"
                                      shareText:@"你要分享的文字"
                                     shareImage:self.rootView.arrayImg[currentindex]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil]
                                       delegate:self];
    
    
}



-(void)pageControllAction:(UIPageControl *)sender{

    CGPoint offset = CGPointMake(sender.currentPage * self.rootView.frame.size.width, 0);
    [self.rootView.scrollView setContentOffset:offset animated:YES];
    
}





//实现协议方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //通过偏移量,计算当前页面的下标
    NSInteger currentindex= self.rootView.scrollView.contentOffset.x/self.rootView.frame.size.width;
    self.rootView.pageControll.currentPage = currentindex;
    
    
    //判断
    if (_previousIndex != currentindex) {
        //恢复所有
        for (PhotoScrollView *photo in scrollView.subviews) {
            //判断是否为PhotoScrollView类的对象
            if ([photo isKindOfClass:[PhotoScrollView class]]) {
                //发送消息,恢复正常大小
            [photo normal];
        }
    }
}    //记录值
    _previousIndex = currentindex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] && self.view == nil) {
        self.view = nil;
    }
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
