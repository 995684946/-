//
//  PopOperaFirstViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/24.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopOperaFirstViewController.h"
#import "YCDelegate.h"
@interface PopOperaFirstViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic,strong)PopOperaCollectionViewController *popOperaVC;
@property (nonatomic,strong)PopOperaTableTableViewController *popOperaTabVC;

@property (weak, nonatomic) IBOutlet UIView *onView;
@property (weak, nonatomic) IBOutlet UIView *underView;
@property (nonatomic,assign)BOOL isclockButton;
@property (nonatomic,assign)BOOL isReLoad;
@property (nonatomic,strong)NSMutableArray *ImagArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,assign)BOOL flag;
//@property (nonatomic,strong)BOOL

@end

@implementation PopOperaFirstViewController


+ (instancetype)sharePopOperaVC{
    
    static PopOperaFirstViewController *OperaFirest = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        OperaFirest = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopOperaFirst"];
        
    });
    return OperaFirest;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isclockButton = NO;
    _isReLoad = NO;
    
    
    [self performSelector:@selector(addWindow) withObject:nil afterDelay:1];

    self.popOperaVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PopOperaCollection"];
    self.popOperaTabVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PopOperaTable"];
    
    
    [self addChildViewController:_popOperaVC];
    [self addChildViewController:_popOperaTabVC];
  
    [self.view addSubview:self.underView];
    [self.view addSubview:self.onView];
    
   
    [self.underView addSubview:_popOperaVC.view];

    
    self.popOperaVC.view.frame = CGRectMake(0, 0, self.underView.frame.size.width, self.underView.frame.size.height);

    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
          self.popOperaTabVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.underView.frame.size.height - 60);
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
          self.popOperaTabVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.underView.frame.size.height + 30);
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
         self.popOperaTabVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.underView.frame.size.height +130);
    }
    else
    {
        NSLog(@"6plus 5.5");
         self.popOperaTabVC.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.underView.frame.size.height + 200);
    }
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.flag = YES;
    
}




- (IBAction)tagChange:(UIBarButtonItem *)sender {
    
    _isclockButton = !_isclockButton;
    
    if (_isclockButton) {
        
        
        for (PopMusic *popMusic in _popOperaVC.allArray) {
            _popOperaTabVC.popMusic = popMusic;
            
        }
        
        _popOperaTabVC.allArray = _popOperaVC.allArray;
        
        sender.image = [UIImage imageNamed:@"movieList"];
        
        [UIView transitionFromView:_popOperaVC.view toView:_popOperaTabVC.view duration:.5 options:UIViewAnimationOptionAllowAnimatedContent completion:nil];
        
    }
    else
    {
        sender.image = [UIImage imageNamed:@"movieBlock"];
        [_popOperaVC.collectionView reloadData];
        [UIView transitionFromView:_popOperaTabVC.view toView:_popOperaVC.view duration:.5 options:UIViewAnimationOptionAllowAnimatedContent completion:nil];
        
    }

    
}

-(void)tapBack:(UITapGestureRecognizer *)tap{
    

    
    
}


- (void)loadDataImage
{
    for (PopMusic *pop in self.popOperaTabVC.allArray) {
        
        [self.ImagArray addObject:pop.cover_path];
        [self.titleArray addObject:pop.tname];
    }
    
    NSLog(@"%@",self.popOperaTabVC.allArray);
    
    NSLog(@"%@",self.ImagArray);
    NSLog(@"%@",self.titleArray);
    
    //网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.underView.frame.size.width, 120) imageURLStringsGroup:nil]; // 模拟网络延时情景
    
    
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    //    cycleScrollView2.titlesGroup = titles;
    
    cycleScrollView2.dotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.onView addSubview:cycleScrollView2];

    if (self.popOperaVC.allArray.count == 0 || self.ImagArray.count == 0 || self.titleArray.count == 0) {
        
        //    // 情景二：采用网络图片实现
        NSArray *imagesURLStrings = @[
                                      @"http://fdfs.xmcdn.com/group3/M02/74/17/wKgDsVKJsOnRFR3wAAAga0F3MAc097.jpg",
                                      @"http://fdfs.xmcdn.com/group3/M00/73/C4/wKgDslKJsQnzGfNvAAAlVMpxGNU146.jpg",
                                      @"http://fdfs.xmcdn.com/group3/M02/74/17/wKgDsVKJsRzSUuF3AAATEEvzBXM839.jpg"
                                      ];
        //
        
        
        
        //    // 情景三：图片配文字
        NSArray *titles = @[@"京剧",
                            @"黄梅戏",
                            @"越剧"
                            ];

            cycleScrollView2.titlesGroup = titles;

            cycleScrollView2.imageURLStringsGroup = imagesURLStrings;

        
    }else
    {
        cycleScrollView2.titlesGroup = self.titleArray;

        cycleScrollView2.imageURLStringsGroup = self.ImagArray;


        
    }
   

}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.popOperaTabVC.allArray.count == 0 || index > 3) {
        
        
        
    }else if (self.flag == YES)
    {
        PopOperaSecondTableViewController *popOperaVC = [PopOperaSecondTableViewController sharePopOperaVC];
        
        PopMusic *pop = self.popOperaVC.allArray[index];
        
    
        popOperaVC.popMusic = pop;
        
        [self showViewController:popOperaVC sender:nil];
        
        self.flag = NO;
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 大按钮

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadDataImage];
    
    if ([UIScreen mainScreen].bounds.size.height <= 500)
    {
        
    }else
    {
        self.window.transform = CGAffineTransformRotate(self.window.transform,  M_1_PI / 15);
        //    self.imgView.transform = CGAffineTransformMakeRotation(0);
        self.window.transform = CGAffineTransformMakeRotation(0);
        
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
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        
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
         
         view.frame = CGRectMake(0, 0, 40, 40);
         
         view.layer.cornerRadius = 20;
         view.layer.masksToBounds = YES;
         
         [btn addSubview:view];
         
         [self.window addSubview:btn];
         
         [self.window makeKeyAndVisible];
         self.window.backgroundColor = [UIColor blackColor];

         
         
     }
    
    
    
}

- (void)btnAction:(UIButton *)sender
{
    PopMusicPlayViewController *popMusicVC = [PopMusicPlayViewController sharePopMusicPlayVC];
    popMusicVC.index = -1;
    
    [self showViewController:popMusicVC sender:nil];
    
    [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:2 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.window.alpha = 0;
        self.window1.alpha = 0;
        self.window.hidden = YES;
        self.window1.hidden = YES;
        
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
}





@end
