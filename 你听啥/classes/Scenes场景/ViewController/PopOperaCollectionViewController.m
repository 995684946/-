//
//  PopOperaCollectionViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopOperaCollectionViewController.h"
//#import "YCDelegate.h"
@interface PopOperaCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView1;
@property (nonatomic,assign)BOOL flag;
@end

@implementation PopOperaCollectionViewController

static NSString * const reuseIdentifier = @"PopOperaFirst";

- (void)loadView
{
   
    
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.minimumInteritemSpacing = 5;
    flowlayout.minimumLineSpacing = 5;
    
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
          flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 30, 10);
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
         flowlayout.sectionInset = UIEdgeInsetsMake(50, 10, 30, 10);
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
           flowlayout.sectionInset = UIEdgeInsetsMake(50, 10, 30, 10);
    }
    else
    {
        NSLog(@"6plus 5.5");
         flowlayout.sectionInset = UIEdgeInsetsMake(50, 10, 30, 10);
    }

    
    self.collectionView  = [[UICollectionView alloc]initWithFrame:kScreenBounds collectionViewLayout:flowlayout];
    
    
    self.view = self.collectionView;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.view.frame = CGRectMake(SUBVIEW_WIDTH_RATIO*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.collectionView registerNib:[UINib nibWithNibName:@"PopOperaFirstCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.alwaysBounceVertical = YES;
    
    self.view = self.collectionView;
    
    self.collectionView1 = self.collectionView;
    
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

- (void)headerRereshing
{
    [self.collectionView reloadData];
    [self.collectionView headerEndRefreshing];
}

- (void)footerRereshing
{
    [self.collectionView reloadData];
    [self.collectionView footerEndRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.flag = YES;
    [self loadData];
    if (! self.allArray.count) {
        return;
    }
    else
    {
         [GMDCircleLoader setOnView:self.collectionView withTitle:@"正在加载……" animated:YES];
    }
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
   
    [GMDCircleLoader hideFromView:self.collectionView animated:YES];
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    
}



- (void)loadData
{
    [[DataHelper shareDataHelper]loadDataPopOperablock:^{
        
        [self.collectionView reloadData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(self.collectionView.frame.size.width / 4, 200);
    return size;
}


#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

   NSArray *array = [[DataHelper shareDataHelper]getPopMusicWithKey:@"PopOperaFirst"];
    
    self.allArray = [NSMutableArray arrayWithArray:array];
    return self.allArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PopOperaFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    PopMusic *popMusic = self.allArray[indexPath.row];
   
    cell.popMusic = popMusic;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flag == YES) {
        PopOperaSecondTableViewController *popOperaSecondVC = [PopOperaSecondTableViewController sharePopOperaVC];
        PopMusic *popMusic = self.allArray[indexPath.row];
        
        popOperaSecondVC.popMusic = popMusic;
        
        [self.navigationController pushViewController:popOperaSecondVC animated:YES];
        
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        

        self.flag = NO;
    }
    

    
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
