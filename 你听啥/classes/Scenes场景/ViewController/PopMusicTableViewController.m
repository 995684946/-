//
//  PopMusicTableViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/21.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusicTableViewController.h"

@interface PopMusicTableViewController ()
@property (nonatomic,strong)UIActivityIndicatorView *activity;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,assign)BOOL flag;

@end

@implementation PopMusicTableViewController

static NSString *cellID = @"PopMusicTableView";
- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self.tableView registerNib:[UINib nibWithNibName:@"PopMusicTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];


    
//       self.view.frame = CGRectMake(SUBVIEW_WIDTH_RATIO*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    

    
    
//    MJ友情提示：
//    1. 添加头部控件的方法
//    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    或者
//    [self.tableView addHeaderWithCallback:^{ }];
//    
//    2. 添加尾部控件的方法
//    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
//    或者
//    [self.tableView addFooterWithCallback:^{ }];
//    
//    3. 可以在MJRefreshConst.h和MJRefreshConst.m文件中自定义显示的文字内容和文字颜色
//    
//    4. 本框架兼容iOS6\iOS7，iPhone\iPad横竖屏
//    
//    5.自动进入刷新状态
//    1> [self.tableView headerBeginRefreshing];
//    2> [self.tableView footerBeginRefreshing];
//    
//    6.结束刷新
//    1> [self.tableView headerEndRefreshing];
//    2> [self.tableView footerEndRefreshing];
    
    
//     [self.tableView addHeaderWithCallback:^{
//      
//     }];
    
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
//    [self.tableView addHeaderWithCallback:^{
//        [[DataHelper shareDataHelper]loadDataPopMusicblock:^{
//            
//            
//            
//        }];
//       
//    }];
    
    
   
    
}

- (void)headerRereshing
{
//    [self.tableView reloadData];
//    [self.tableView headerBeginRefreshing];
    
    
    
    
        
           
    
    [self.tableView headerEndRefreshing];
    
}

- (void)footerRereshing
{
//    [self.tableView reloadData];
    
//    [self.tableView footerBeginRefreshing];
    [self.tableView footerEndRefreshing];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.flag = YES;
    
    [self loadData];
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"skin" object:nil userInfo:@{@"array":self.allArray}];
    
    if (self.allArray.count != 0) {
        return;
    }
    else
    {
        [GMDCircleLoader setOnView:self.tableView withTitle:@"正在加载……" animated:YES];
    }
    
//    [[MJRefreshFooterView footer];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
   [GMDCircleLoader hideFromView:self.tableView animated:YES];
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    
   
}


- (void)loadData
{
[[DataHelper shareDataHelper]loadDataPopMusicblock:^{
    
   
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     NSArray *array = [[DataHelper shareDataHelper] getPopMusicWithKey:@"PopMusicFirst"];
    self.allArray = [NSMutableArray arrayWithArray:array];
    
    return self.allArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    PopMusic *popMusic = self.allArray[indexPath.row];
    
  
    
    cell.popMusic = popMusic;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 300;

    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        return [UIScreen mainScreen].bounds.size.height / 3;
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
         return [UIScreen mainScreen].bounds.size.height / 3;
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
         return [UIScreen mainScreen].bounds.size.height / 3;
        
    }
    else
    {
        NSLog(@"6plus 5.5");
        return [UIScreen mainScreen].bounds.size.height / 3;
    }

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       
    
    if (self.flag == YES) {
        
        PopMusicSecondTableViewController *secondVC = [PopMusicSecondTableViewController sharePopMusicSecond];
        
        PopMusic *pop = self.allArray[indexPath.row];
        
        secondVC.popMusic = pop;
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController pushViewController:secondVC animated:YES];
        
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

@end
