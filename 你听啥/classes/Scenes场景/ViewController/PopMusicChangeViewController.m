//
//  PopMusicChangeViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/21.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusicChangeViewController.h"
#import "YCDelegate.h"
@interface PopMusicChangeViewController ()<SDCycleScrollViewDelegate>


@property (nonatomic,strong)PopMusicCollectionViewController *CollectVC;
@property (nonatomic,strong)PopMusicTableViewController *tableVC;
@property (nonatomic,assign)BOOL isclockButton;
@property (nonatomic,assign)BOOL isReLoad;
@property (nonatomic,strong)UIView *MainView;
@property (weak, nonatomic) IBOutlet UIView *onView;
@property (weak, nonatomic) IBOutlet UIView *underView;
@property (nonatomic,strong)NSMutableArray *DataArray;
@property (nonatomic,strong)NSMutableArray *ImagArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *Array;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,assign)BOOL flag;
//手势
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation PopMusicChangeViewController

+(instancetype)sharePopMusicVC
{
    static PopMusicChangeViewController *popMusicVC = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        popMusicVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopMusicChange"];
        
    });
    return popMusicVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    _isclockButton = NO;
    _isReLoad = NO;

    
    
#pragma mark ============== 侧滑 ===================
    
      self.tabBarController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"PopMusic" image:[UIImage imageNamed:@"grey_music_32px_580017_easyicon.net.png"] tag:100];
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];

#pragma mark ****************************
    

    
    self.CollectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PopMusicCollection"];
    self.tableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PopMusicTable"];
    [self addChildViewController:_CollectVC];
    [self addChildViewController:_tableVC];
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.width);
    
    [self.view addSubview:self.onView];
    [self.view addSubview:self.underView];
    
    [self.underView addSubview:_tableVC.view];
    self.tableVC.view.frame = CGRectMake(0, 0, self.underView.frame.size.width, self.underView.frame.size.height);
   
    
    
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
         self.CollectVC.view.frame = CGRectMake(0, 0, self.underView.frame.size.width, self.underView.frame.size.height + 140);
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        self.CollectVC.view.frame = CGRectMake(0, 0, self.underView.frame.size.width, self.underView.frame.size.height + 180);
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
        self.CollectVC.view.frame = CGRectMake(0, 0, self.underView.frame.size.width, self.underView.frame.size.height + 140);
        
    }
    else
    {
        NSLog(@"6plus 5.5");
        self.CollectVC.view.frame = CGRectMake(0, 0, self.underView.frame.size.width, self.underView.frame.size.height +200);
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    
//    
//    if ([UIScreen mainScreen].bounds.size.height <= 500) {
//        
//        //4s 3.7
//         self.CollectVC.view.frame = CGRectMake(0, 0, self.underView.frame.size.width, self.underView.frame.size.height + 140);
//        
//        NSLog(@"4s 3.7");
//        
//    }else if ([UIScreen mainScreen].bounds.size.height >= 900) {
//        
//        //6p 5/5
//        self.CollectVC.view.frame = CGRectMake(0, 0, self.underView.frame.size.width, self.underView.frame.size.height +200);
//        NSLog(@"6p 5/5");
//        
//    }else
//    {
//         self.CollectVC.view.frame = CGRectMake(0, 0, self.underView.frame.size.width, self.underView.frame.size.height + 140);
//        
//    }
    
    
    
    
    
    
    
    
    
    
    
   
    
    [self performSelector:@selector(addWindow) withObject:nil afterDelay:1];



    
}
- (void)RightSwiftGestAction:(UISwipeGestureRecognizer *)sender
{
 
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
     
        [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            
            self.window.hidden = NO;
            self.window1.hidden = NO;
            
            self.window.alpha = 1;
            self.window1.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];

       
        
    }
    else
    {
        [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            
            self.window.hidden = YES;
            self.window1.hidden = YES;
            
            self.window.alpha = 0;
            self.window1.alpha = 0;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
 
}




- (void) openOrCloseLeftList
{
    YCDelegate *tempAppDelegate = (YCDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
       
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.flag = YES;
    
    YCDelegate *tempAppDelegate = (YCDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];

    
    
    
    
    
}
#pragma mark ==============================大按钮=====================================


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadDataImage];

    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
    }else
    {
        self.window.transform = CGAffineTransformRotate(self.window.transform,  M_1_PI / 15);
        //      self.imgView.transform = CGAffineTransformMakeRotation(0);
        //      self.window.transform = CGAffineTransformMakeRotation(0);
        
        [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            
            self.window.hidden = NO;
            self.window1.hidden = NO;
            
            self.window.alpha = 1;
            self.window1.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}




- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
#pragma mark ==================侧滑 ==================
    YCDelegate *tempAppDelegate = (YCDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
    
       if ([UIScreen mainScreen].bounds.size.height <= 500) {
           
       }
    else
    {
        
        [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.window.hidden = YES;
            self.window1.hidden = YES;
            self.window.alpha = 0;
            self.window1.alpha = 0;
            
            
            
        } completion:^(BOOL finished) {
            
            
        }];
        
        
        
        if (self.tabBarController.hidesBottomBarWhenPushed) {
            
            
        }else
        {
            
            [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.window.hidden = YES;
                self.window1.hidden = YES;
                self.window.alpha = 0;
                self.window1.alpha = 0;
                
                
                
            } completion:^(BOOL finished) {
                
                
            }];
        }
        
        if (self.tabBarController.editing) {
            
            
        }else
        {
            [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.window.hidden = YES;
                self.window1.hidden = YES;
                self.window.alpha = 0;
                self.window1.alpha = 0;
                
                
                
            } completion:^(BOOL finished) {
                
                
            }];
        }

    }
    
    

}

- (void)btnAction:(UIButton *)sender
{
    PopMusicPlayViewController *popMusicVC = [PopMusicPlayViewController sharePopMusicPlayVC];
    popMusicVC.index = -1;
//    popMusicVC.array = nil;
    
    [self showViewController:popMusicVC sender:nil];
    
    [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
       
        self.window.alpha = 0;
        self.window1.alpha = 0;
        self.window.hidden = YES;
        self.window1.hidden = YES;
        
        
    } completion:^(BOOL finished) {
        
        
        
    }];
}


- (void) addWindow {
//    1334×750
    //667 375
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        
        
    }else
    {
        self.window1 = [[UIWindow alloc] initWithFrame:CGRectMake(self.view.center.x - 25, [UIScreen mainScreen].bounds.size.height - 74, 50, 25)];
        [self.window1 makeKeyAndVisible];
        self.window1.backgroundColor = [UIColor grayColor];
        
        
        self.window = [[UIWindow alloc] initWithFrame:CGRectMake(self.view.center.x - 25, [UIScreen mainScreen].bounds.size.height - 99 , 50, 50)];
        self.window.layer.cornerRadius = 25;
        self.window.layer.masksToBounds = YES;
        self.window.windowLevel = UIWindowLevelAlert;
        
        MyButton *btn = [[MyButton alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = 20;
        btn.layer.masksToBounds = YES;
        [btn addtarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]highlightedImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];
        self.imgView = view;
        
        view.frame = CGRectMake(0, 0, 40, 40);
        
        view.layer.cornerRadius = 20;
        view.layer.masksToBounds = YES;
        
        [btn addSubview:self.imgView];
        
        [self.window addSubview:btn];
        
        [self.window makeKeyAndVisible];
        self.window.backgroundColor = [UIColor blackColor];

    }
    
    
    
}

#pragma mark ==============================加载图片=====================================

- (void)loadDataImage
{
    
    for (PopMusic *pop in self.tableVC.allArray) {
        
        [self.ImagArray addObject:pop.cover_path];
        [self.titleArray addObject:pop.tname];
//        NSLog(@"%@",pop.cover_path);
    }

//    NSLog(@"%@",self.tableVC.allArray);
//    
//    NSLog(@"%@",self.ImagArray);
//    NSLog(@"%@",self.titleArray);
    
    
    //网络加载 --- 创建带标题的图片轮播器
//    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.underView.frame.size.width, 180) imageURLStringsGroup:nil]; // 模拟网络延时情景
    
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.underView.frame.size.width, 120)  imageURLStringsGroup:nil]; // 模拟网络延时情景
//    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height / 4);
    
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    //    cycleScrollView2.titlesGroup = titles;
    
    cycleScrollView2.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.onView addSubview:cycleScrollView2];
    
    if (self.tableVC.allArray.count == 0) {
            // 情景二：采用网络图片实现
            NSArray *imagesURLStrings = @[
                                          @"http://fdfs.xmcdn.com/group11/M05/99/69/wKgDbVYt8ami8Rw5AACz01ruR6M963.jpg",
                                          @"http://fdfs.xmcdn.com/group11/M00/8C/F1/wKgDbVYXN17zAKE8AASVih4-WRw748.jpg",
                                          @"http://fdfs.xmcdn.com/group3/M03/6C/BA/wKgDslKB5GKQvcEZAAAzU6ynDEE911.jpg",
                                          @"http://fdfs.xmcdn.com/group3/M01/6C/B9/wKgDslKB48_ghTERAAAr_lh72sQ881.jpg",
                                          @"http://fdfs.xmcdn.com/group6/M02/C9/02/wKgDhFUVH1-QBPcKAAB3N3zfaqQ730.jpg"                          ,
                                          @"http://fdfs.xmcdn.com/group6/M07/74/A0/wKgDg1U_Az3AzXlpAABbQ8NENKA760.jpg",
                                          @"http://fdfs.xmcdn.com/group3/M01/73/B7/wKgDslKJqbjC5WTXAAAbaGFbLHg412.jpg",
                                          @"http://fdfs.xmcdn.com/group14/M01/81/19/wKgDY1YXjkmSxtg9AAWVcRDHYD4899.jpg",
                                          @"http://fdfs.xmcdn.com/group13/M04/81/69/wKgDXVYXj6fxx1HlAAgohFd1Irg159.jpg",
                                          @"http://fdfs.xmcdn.com/group3/M01/73/B9/wKgDslKJqsSzNc3BAAAmLZISD8s669.jpg",
                                          @"http://fdfs.xmcdn.com/group3/M00/6D/24/wKgDsVKB7_3wKfRnAAAb3wwALgg549.jpg",
                                          @"http://fdfs.xmcdn.com/group10/M02/80/F1/wKgDaVYYbS6BhIeCAAWm0fowLg0844.jpg",
                                          @"http://fdfs.xmcdn.com/group3/M03/6D/0F/wKgDsVKB5H2xaL1JAAA2tk1SBwU258.jpg",
                                          @"http://fdfs.xmcdn.com/group8/M0B/81/60/wKgDYFYYbIXyrnDCAASsbMBV-pQ872.jpg",
                                          @"http://fdfs.xmcdn.com/group3/M04/6C/BA/wKgDslKB5JrwneaFAAApGtNa7TA867.jpg",
                                          @"http://fdfs.xmcdn.com/group3/M01/6C/B9/wKgDslKB4_-zaJPgAAAs_xOKAgw856.jpg",
                                          @"http://fdfs.xmcdn.com/group10/M07/88/B5/wKgDZ1YnAvux9jF6AAPzKmJBu1w900.jpg",
                                          @"http://fdfs.xmcdn.com/group7/M03/89/66/wKgDWlYnA7LBGzrZAABTqt2akT0123.jpg",
                                          @"http://fdfs.xmcdn.com/group8/M02/89/1E/wKgDYFYnBDbxofOcAAD_MhEI-vY710.jpg",
                                          @"http://fdfs.xmcdn.com/group12/M0A/80/61/wKgDXFYXlZvCVE9PAAZ2G4no8ZQ971.jpg",
                                          @"http://fdfs.xmcdn.com/group10/M04/80/90/wKgDZ1YXlkbB_AfFAAZL-KBPoN0303.jpg",
                                          @"http://fdfs.xmcdn.com/group10/M01/88/C6/wKgDaVYnBGvRukgPAAfHRjntkdw735.jpg",
                                          @"http://fdfs.xmcdn.com/group16/M08/89/1D/wKgDbFYnAK7jT6GHAABfmADlsIU895.jpg",
                                          @"http://fdfs.xmcdn.com/group3/M01/6C/B9/wKgDslKB4-iilRLUAAAxANL5eec971.jpg",
                                          @"http://fdfs.xmcdn.com/group3/M04/74/0B/wKgDsVKJqmfiL_YnAAAiqZ1DXTI450.jpg",
                                          @"http://fdfs.xmcdn.com/group8/M0B/83/CF/wKgDYFYc4laCGuZTAAH3JDa72uM685.jpg"
                                          ];
        //
        //    // 情景三：图片配文字
            NSArray *titles = @[@"精选|歌单",
                                @"原创|独立",
                                @"翻唱|弹奏",
                                @"主播|节目",
                                @"榜单|排行",
                                @"艺人|明星",
                                @"怀旧|经典",
                                @"电影|原声",
                                @"动漫|游戏",
                                @"佛教|禅音",
                                @"催眠|解压",
                                @"儿童|胎教",
                                @"华语|粤语",
                                @"日语|韩语",
                                @"欧美|其他",
                                @"器乐|古典",
                                @"睡前.安静",
                                @"孤单.伤感",
                                @"午后.咖啡",
                                @"|小清新|",
                                @"|纯音乐|",
                                @"|二次元|",
                                @"流行",
                                @"古风",
                                @"民谣",
                                @"3D奇妙体验馆",
                                ];
        
         cycleScrollView2.titlesGroup = titles;
            cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
        
    }else
    {
        
        cycleScrollView2.titlesGroup = self.titleArray;
            cycleScrollView2.imageURLStringsGroup = self.ImagArray;

        
    }
  
    
}

- (NSMutableArray *)ImagArray
{
    if (!_ImagArray) {
        
        self.ImagArray = [NSMutableArray array];
    }
    return _ImagArray;
}

- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        
        
        self.titleArray = [NSMutableArray array];
    }
    return _titleArray;
}



- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    
//    NSLog(@"%ld",index);
    
    if (self.tableVC.allArray == nil ||self.tableVC.allArray.count == 0 || index >= 26) {
        
        NSLog(@"1%ld",index);
        
    }else if(self.flag == YES)
    {
        PopMusicSecondTableViewController *popMusicVC = [PopMusicSecondTableViewController sharePopMusicSecond];

        PopMusic *pop = self.tableVC.allArray[index];
        
        popMusicVC.popMusic = pop;
        
        //    [self showDetailViewController:popMusicVC sender:nil];
        [self showViewController:popMusicVC sender:nil];
        
        self.flag = NO;
        
    }
    
    
    
}

//-(void)tapBack:(UITapGestureRecognizer *)tap{
//    
//    YCDelegate *YC = (YCDelegate *)[UIApplication sharedApplication].delegate;
//    
//    [YC.MainScrollView setContentOffset:CGPointMake(SUBVIEW_WIDTH_RATIO*SCREEN_WIDTH , 0) animated:YES];
//}

- (IBAction)rightBarBUttonAction:(UIBarButtonItem *)sender {
    
    _isclockButton = !_isclockButton;
    
    if (_isclockButton) {
        
        
        for (PopMusic *popMusic in _tableVC.allArray) {
            _CollectVC.popMusic = popMusic;
            
        }
        
        _CollectVC.allArray = _tableVC.allArray;
 ;

        sender.image = [UIImage imageNamed:@"movieList"];
        
        [UIView transitionFromView:_tableVC.view toView:_CollectVC.view duration:.5 options:UIViewAnimationOptionAllowAnimatedContent completion:nil];

    }
    else
    {
        sender.image = [UIImage imageNamed:@"movieBlock"];
        [_tableVC.tableView reloadData];
        [UIView transitionFromView:_CollectVC.view toView:_tableVC.view duration:.5 options:UIViewAnimationOptionAllowAnimatedContent completion:nil];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
