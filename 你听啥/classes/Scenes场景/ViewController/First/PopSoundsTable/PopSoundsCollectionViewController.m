//
//  PopSoundsCollectionViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopSoundsCollectionViewController.h"

@interface PopSoundsCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,assign)BOOL flag;
@end

@implementation PopSoundsCollectionViewController

static NSString * const reuseIdentifier = @"PopSoundsCollection";

- (void)loadView
{
    self.automaticallyAdjustsScrollViewInsets = YES;
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.minimumInteritemSpacing = 5;
    flowlayout.minimumLineSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 15, 120, 25);
//    flowlayout.sectionInset = UIEdgeInsetsMake(10, 0, self.view.frame.size.height / 3, self.view.frame.size.width / 5);
    
    self.collectionView  = [[UICollectionView alloc]initWithFrame:kScreenBounds collectionViewLayout:flowlayout];

//    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowlayout];
    
    self.view = self.collectionView;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.frame = kScreenBounds;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PopSoundsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.alwaysBounceVertical = YES;
    
    self.view = self.collectionView;
// self.view.frame = CGRectMake(SUBVIEW_WIDTH_RATIO*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.flag = YES;
    
    if (self.allArray.count != 0) {
        
        return;
        
    }else
    {
        [GMDCircleLoader setOnView:self.collectionView withTitle:@"正在加载……" animated:YES];

        
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [GMDCircleLoader hideFromView:self.collectionView animated:YES];
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake(100, 180);
    return CGSizeMake(self.view.frame.size.width / 4, self.view.frame.size.height / 3);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
//    return 5;
    return 0;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.allArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PopSoundsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    PopMusic *popMusic = self.allArray[indexPath.row];
    
    cell.popMusic = popMusic;
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.flag == YES) {
        
        PopSoundsTableSecondTableViewController *popSoundVC = [PopSoundsTableSecondTableViewController sharePopSoundsSecondVC];
        
        PopMusic *pop = self.allArray[indexPath.row];
        
        popSoundVC.popMusic = pop;
        
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:popSoundVC animated:YES];
        
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
