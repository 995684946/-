//
//  PopMusicTherdTableViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/22.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusicTherdTableViewController.h"

@interface PopMusicTherdTableViewController ()
@property (nonatomic,strong)NSMutableArray *allArray;
@property (nonatomic,strong)NSMutableArray *allDArray;
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSMutableArray *Aarray;
@property (nonatomic,assign)BOOL flag;


@end

@implementation PopMusicTherdTableViewController

static NSString *CellID = @"PopMusicTherdCell";
static NSString *cellID2 = @"PopMusicTherd2";
+(instancetype)sharePopMusicTherd
{
    static PopMusicTherdTableViewController *MusicTherdVC = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        MusicTherdVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopMusicTherdTable"];
        
    });
    return MusicTherdVC;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PopMusicTherdCell" bundle:nil] forCellReuseIdentifier:CellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PopMusicTherd2" bundle:nil] forCellReuseIdentifier:cellID2];
    
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
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

      self.title = self.popMusic.title;
    
    self.flag = YES;
    
    [self loadData];
    
    [self.tableView reloadData];
//    [GMDCircleLoader setOnView:self.tableView withTitle:@"正在加载……" animated:YES];
    if (self.allArray.count != 0 && self.allDArray.count != 0) {
        return;
    }else
    {
        [GMDCircleLoader setOnView:self.tableView withTitle:@"正在加载……" animated:YES];
    }
    
   
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
    [[DataHelper shareDataHelper]loadDataMusicTheredWithAlbumId:self.popMusic.albumId block:^{
        
        [self.tableView reloadData];
        
    }];

   }

- (NSMutableArray *)allDArray{
    if (!_allDArray) {
        self.allDArray = [NSMutableArray array];
        
    }
    return _allDArray;
}

- (NSMutableArray *)allArray{
    if (!_allArray) {
        self.allArray = [NSMutableArray array];
    }
    return _allArray;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   NSArray *array1 = [[DataHelper shareDataHelper] getPopMusicWithKey:@"PopMusicThered"];
    self.allArray = [NSMutableArray arrayWithArray:array1];
    
   NSArray *array2 = [[DataHelper shareDataHelper] getPopMusicWithKey:@"PopMusicThered2"];
    self.allDArray = [NSMutableArray arrayWithArray:array2];

    if (section == 0) {
        
        return self.allArray.count;
    }else
    {
        return self.allDArray.count;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    

    if (indexPath.section == 0) {
        PopMusicTherdCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
         tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        PopThered *there = self.allArray[indexPath.row];
        cell.selectionStyle = (const int)UITableViewSelectionDidChangeNotification;
        
        cell.popThered = there;
        
        
        
        return cell;
        
            }else
            {
                PopMusicTherd2 *cell = [tableView dequeueReusableCellWithIdentifier:cellID2 forIndexPath:indexPath];
                
                PopThered *there = self.allDArray[indexPath.row];
               
                cell.there = there;
                
                return cell;
            }
    

}



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}







- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 200;
    }
    else{
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
    if (indexPath.section != 0 && self.flag == YES) {
        
        PopMusicPlayViewController *playerVC = [PopMusicPlayViewController sharePopMusicPlayVC];
        
        playerVC.index = indexPath.row;
        
        
        playerVC.array = self.allDArray;
        playerVC.PopName = @"PopMusic";
        
        [self showDetailViewController:playerVC sender:nil];
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
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
