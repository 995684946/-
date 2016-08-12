//
//  PopSoundsTableViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopSoundsTableViewController.h"

@interface PopSoundsTableViewController ()

//@property (nonatomic,strong)NSMutableArray *allArray;
@property (nonatomic,strong)UIActivityIndicatorView *activity;
@property (nonatomic,assign)BOOL flag;
@end

@implementation PopSoundsTableViewController


static NSString *cellID = @"PopSoundsFirst";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PopSoundsFirstTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    
//    self.view.frame = CGRectMake(SUBVIEW_WIDTH_RATIO*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
//    __weak UITableView *tableView = self.tableView;
    // 下拉刷新
//    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 结束刷新
//            [tableView.header endRefreshing];
//        });
//    }];
  
    
    
}

- (void)headerRereshing
{
    [self.tableView reloadData];
//    [self.tableView headerBeginRefreshing];
    [self.tableView headerEndRefreshing];
    
}

- (void)footerRereshing
{
    [self.tableView reloadData];
    
//    [self.tableView footerBeginRefreshing];
    [self.tableView footerEndRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.flag = YES;
     [self.tableView reloadData];
  [self loadData];
    if (_allArray.count != 0) {
        return;
    }
    else
    {
          [GMDCircleLoader setOnView:self.tableView withTitle:@"正在加载……" animated:YES];
    }  
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_allArray.count != 0 ) {
        return;
    }else
    {
         [GMDCircleLoader hideFromView:self.tableView animated:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    
   
}


- (void)loadData
{

    [[DataHelper shareDataHelper]loadDataPopSoundsblock:^{
        
        [self.tableView reloadData];
        
    }];
  
}

- (NSMutableArray *)allArray
{
    if (!_allArray) {
        self.allArray = [NSMutableArray array];
    }
    return _allArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *array = [[DataHelper shareDataHelper] getPopMusicWithKey:@"PopSoundsFirst"];

    self.allArray = [NSMutableArray arrayWithArray:array];
    
    return self.allArray.count;
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopSoundsFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    
    
    PopMusic *music = self.allArray[indexPath.row];
    
    cell.popMusic = music;

    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    if (self.flag == YES) {
        
        PopSoundsTableSecondTableViewController *popSoundVC = [PopSoundsTableSecondTableViewController sharePopSoundsSecondVC];
        
        PopMusic *pop = self.allArray[indexPath.row];
        
        popSoundVC.popMusic = pop;
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:popSoundVC animated:YES];
        
        self.flag = NO;
    }
    

    
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)loadDrawer
//{
//    
//    _MainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    _MainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*(1 + SUBVIEW_WIDTH_RATIO), 0);
//    _MainScrollView.pagingEnabled = YES;
//    _MainScrollView.backgroundColor = [UIColor whiteColor];
//    [_MainScrollView setContentOffset:CGPointMake(SUBVIEW_WIDTH_RATIO*SCREEN_WIDTH, 0)];
//    _MainScrollView.bounces = NO;
//    _MainScrollView.delegate = self;
//    
//    
//    self.drawerVC = [DrawerViewController shareDrawerViewVC];
//    
//    self.drawerVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//
//    [_MainScrollView addSubview:self.drawerVC.view];
//    
////    self.subView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
////    [_MainScrollView addSubview:self.subView];
//    
//    UIImageView *subBackImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kenan.jpg"]];
//    [self.drawerVC.view addSubview:subBackImage];
//    subBackImage.frame = CGRectMake(0, 0, SUBVIEW_WIDTH_RATIO*SCREEN_WIDTH, SCREEN_HEIGHT);
//    subBackImage.contentMode = UIViewContentModeScaleAspectFill;
//    subBackImage.layer.masksToBounds = YES;
//    subBackImage.alpha = .3;
//    
////    self.sideTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SUBVIEW_WIDTH_RATIO*SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
////    self.sideTableView.backgroundColor = [UIColor clearColor];
////    self.sideTableView.dataSource = self;
////    self.sideTableView.delegate = self;
////    [self.subView addSubview:self.sideTableView];
//    
//    UITapGestureRecognizer *tapBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBack:)];
//    [self.MainScrollView.subviews[0] addGestureRecognizer:tapBack];
//}
//







@end
