//
//  PopSoundThirdTableViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopSoundThirdTableViewController.h"

@interface PopSoundThirdTableViewController ()
@property (nonatomic,strong)NSMutableArray *allArray;
@property (nonatomic,strong)NSMutableArray *allArray2;
@property (nonatomic,assign)BOOL flag;
@end

@implementation PopSoundThirdTableViewController


+ (instancetype)sharePopSoundsVC
{
    static  PopSoundThirdTableViewController *popSoundThereVC = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popSoundThereVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopSoundThirdTable"];
    });
    return popSoundThereVC;
}
static NSString *CellID = @"PopSoundsTherd";
static NSString *CellID2 = @"PopMusicTherd2";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PopSoundsTherdTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PopMusicTherd2" bundle:nil] forCellReuseIdentifier:CellID2];
    
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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.flag = YES;
      self.title = self.popMusic.title;
    [self loadData];
    [self.tableView reloadData];
    if (self.allArray.count != 0 && self.allArray2.count != 0) {
        return;
    }
    else
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
    
    [[DataHelper shareDataHelper]loadDataSoundsTheredWithAlbumId:self.popMusic.albumId block:^{
        
        [self.tableView reloadData];
        
    }];
    

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [[DataHelper shareDataHelper] getPopMusicWithKey:@"PopSoundThered"];
    
    NSArray *Araay = [[DataHelper shareDataHelper] getPopMusicWithKey:@"PopSoundThered2"];
    
    self.allArray = [NSMutableArray arrayWithArray:array];
    self.allArray2 = [NSMutableArray arrayWithArray:Araay];
    
    if (section == 0) {
        
        return self.allArray.count;
    }
    else
    {
        return self.allArray2.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        
        PopSoundsTherdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        
        PopThered *there = self.allArray[indexPath.row];
        cell.selectionStyle = (const int)UITableViewSelectionDidChangeNotification;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.popThered = there;
        
        return cell;
    }
    else
    {
        PopMusicTherd2 *cell = [tableView dequeueReusableCellWithIdentifier:CellID2 forIndexPath:indexPath];
        
        PopThered *there = self.allArray2[indexPath.row];
        
        cell.there = there;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }
    else
    {
        return 100;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0 && self.flag == YES) {
        
        PopMusicPlayViewController *playerVC = [PopMusicPlayViewController sharePopMusicPlayVC];
        
        playerVC.index = indexPath.row;
        
        playerVC.array = self.allArray2;
        playerVC.PopName = @"PopSounds";
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
