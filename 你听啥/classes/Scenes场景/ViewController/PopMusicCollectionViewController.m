//
//  PopMusicCollectionViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/21.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusicCollectionViewController.h"

@interface PopMusicCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,assign)BOOL flag;
@end

@implementation PopMusicCollectionViewController

static NSString * const reuseIdentifier = @"PopMusicCollection";

- (void)loadView
{
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.minimumInteritemSpacing = 5;
    flowlayout.minimumLineSpacing = 0;
//    flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 192);

    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        
        flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, [UIScreen mainScreen].bounds.size.height / 3 + 40, [UIScreen mainScreen].bounds.size.width /2 );
        
        NSLog(@"4s 3.7");
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
        flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, [UIScreen mainScreen].bounds.size.height / 3 , [UIScreen mainScreen].bounds.size.width /2  );
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
//        flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, [UIScreen mainScreen].bounds.size.height / 2 , [UIScreen mainScreen].bounds.size.width /3 );
        flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, 10, 225);
        
    }
    else
    {
        NSLog(@"6plus 5.5");
        flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 192);
    }

    
    
    
    
//    
//    if ([UIScreen mainScreen].bounds.size.height <= 500) {
//        
//        //4s/3.7
//        flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, [UIScreen mainScreen].bounds.size.height / 3 + 40, [UIScreen mainScreen].bounds.size.width /2 );
//        NSLog(@"4s/3.7");
//
//    }else if([UIScreen mainScreen].bounds.size.height >= 900)
//    {
//        //6 5.5
////        flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, [UIScreen mainScreen].bounds.size.height / 2 + 100 , [UIScreen mainScreen].bounds.size.width /2 );
//            flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 192);
//        NSLog(@"6s 5.5");
//    }else
//    {
//        flowlayout.sectionInset = UIEdgeInsetsMake(5, 5, [UIScreen mainScreen].bounds.size.height / 3 , [UIScreen mainScreen].bounds.size.width /2 );
//    }
//    
    
    self.collectionView  = [[UICollectionView alloc]initWithFrame:kScreenBounds collectionViewLayout:flowlayout];
    
//    self.collectionView = [UICollectionView allo
    self.view = self.collectionView;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//     self.view.frame = CGRectMake(SUBVIEW_WIDTH_RATIO*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PopMusicCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
 
//    self.view = self.collectionView;
    
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
    [super viewWillAppear:animated];
    
    
    self.flag = YES;
    
    if (self.allArray.count != 0 ) {
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


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake(100, 180);
    
    
    
    
    
    
    
        return CGSizeMake(self.view.frame.size.width / 6, self.view.frame.size.height / 3);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
//    return 3;
    return 3;
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.allArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PopMusicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    PopMusic *popMusic = self.allArray[indexPath.row];
    
    cell.popMusic = popMusic;
  
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.flag == YES) {
        
        PopMusicSecondTableViewController *secondVC = [PopMusicSecondTableViewController sharePopMusicSecond];
        
        PopMusic *pop = self.allArray[indexPath.row];
        
        secondVC.popMusic = pop;
        
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
        [self.navigationController pushViewController:secondVC animated:YES];
     
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
