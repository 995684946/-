//
//  introduceViewController.m
//  你听啥
//
//  Created by anyurchao on 15/11/1.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "introduceViewController.h"
#import "introduce.h"
@interface introduceViewController ()
@property (nonatomic,strong)introduce *introduceView;
@end

@implementation introduceViewController

- (void)loadView
{
    self.introduceView = [[introduce alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.introduceView;

    self.introduceView.backgroundColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
