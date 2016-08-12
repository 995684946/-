//
//  PopSoundsViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopSoundsViewController.h"
#import "YCDelegate.h"
@interface PopSoundsViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)PopSoundsCollectionViewController *PopSoundsCollectVC;
@property (nonatomic,strong)PopSoundsTableViewController *PopSoundsTableVC;
@property (nonatomic,assign)BOOL isclockButton;
@property (nonatomic,assign)BOOL isReLoad;
@property (nonatomic,strong)UIView *MainView;



@end

@implementation PopSoundsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _isclockButton = NO;
    _isReLoad = NO;
  
    
   [self performSelector:@selector(addWindow) withObject:nil afterDelay:1];
    
    self.PopSoundsCollectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PopSoundsCollection"];
    self.PopSoundsTableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PopSoundsTable"];
    
    [self addChildViewController:_PopSoundsCollectVC];
    [self addChildViewController:_PopSoundsTableVC];
    
    [self.view addSubview:_PopSoundsTableVC.view];
    
 
    
}



- (IBAction)tgrChange:(UIBarButtonItem *)sender {
    _isclockButton = !_isclockButton;
    
    if (_isclockButton) {
        
        
        for (PopMusic *popMusic in _PopSoundsTableVC.allArray) {
            _PopSoundsCollectVC.popMusic = popMusic;
            
        }
        
        _PopSoundsCollectVC.allArray = _PopSoundsTableVC.allArray;
        
        sender.image = [UIImage imageNamed:@"movieList"];
        
        [UIView transitionFromView:_PopSoundsTableVC.view toView:_PopSoundsCollectVC.view duration:.5 options:UIViewAnimationOptionAllowAnimatedContent completion:nil];
        
    }
    else
    {
        sender.image = [UIImage imageNamed:@"movieBlock"];
        [_PopSoundsTableVC.tableView reloadData];
        [UIView transitionFromView:_PopSoundsCollectVC.view toView:_PopSoundsTableVC.view duration:.5 options:UIViewAnimationOptionAllowAnimatedContent completion:nil];
    }
 
}




#pragma mark ==============================大按钮=====================================

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        
        
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
