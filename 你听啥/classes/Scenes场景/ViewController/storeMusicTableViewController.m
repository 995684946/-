//
//  storeMusicTableViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/27.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "storeMusicTableViewController.h"

@interface storeMusicTableViewController ()

@property (nonatomic,strong)NSMutableArray *allArray;
@property (nonatomic,strong)NSMutableDictionary *allDic;
@property (nonatomic,strong)NSIndexPath *currentPath;
@property (nonatomic,strong)UIBarButtonItem *rightBarButtonItem;
@property (nonatomic,strong)NSMutableArray *ArrayHead;
@property (nonatomic,strong)NSMutableArray *ArrayRows;

@end

@implementation storeMusicTableViewController

+(instancetype)shareStoreMuscic
{
    static storeMusicTableViewController *storeVC = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        storeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"storeMusicTable"];
        
    });
    return storeVC;
    
}


static NSString * const CellID = @"StoreMusic";
- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction:)];
    
    self.navigationItem.rightBarButtonItem.title = @"编辑";
    
    self.title = @"我的下载";
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreMusicTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    
    [self loadData];
}

- (void)loadData
{
    [[DBManager showDBManager] openDBManager];
    NSArray *array = [[DBManager showDBManager] selectAll];
    self.allArray = [NSMutableArray arrayWithArray:array];
    NSArray *arrayPopMusic = [[DBManager showDBManager] selectPopName:@"PopMusic"];
    NSArray *arrayPopSounds = [[DBManager showDBManager] selectPopName:@"PopSounds"];
    NSArray *arrayPopOpera = [[DBManager showDBManager] selectPopName:@"PopOpera"];
    NSArray *array00 = [[DBManager showDBManager] selectPopName:@"0"];
    [[DBManager showDBManager] closeDBmanager];
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:arrayPopMusic];
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:arrayPopSounds];
    NSMutableArray *array3 = [NSMutableArray arrayWithArray:arrayPopOpera];
    NSMutableArray *array0 = [NSMutableArray arrayWithArray:array00];
    
    
    [self.allDic setObject:array1 forKey:@"PopMusic"];
    [self.allDic setObject:array2 forKey:@"PopSounds"];
    [self.allDic setObject:array3 forKey:@"PopOpera"];
    [self.allDic setObject:array0 forKey:@"0"];
    
    
    self.ArrayHead = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];

    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
        return self.allDic.allKeys.count -1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [self.allDic[self.allDic.allKeys[section]]count];
    if ([[self.ArrayHead objectAtIndex:section] intValue]== 0) {
        
        NSString *key = self.allDic.allKeys[section];
        NSArray *Array = self.allDic[key];
        return  Array.count;
        
    }else
    {
        
        return 0;
       
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    StoreMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    

    cell.selectionStyle = (const int)UITableViewSelectionDidChangeNotification;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        NSString *key = self.allDic.allKeys[indexPath.section];
    
        PopThered *there = [self.allDic objectForKey:key][indexPath.row];


    cell.there = there;
    
    
//    static NSString *cellID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.selectionStyle = (const int)UITableViewSelectionDidChangeNotification;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
//        cell.backgroundColor = [UIColor clearColor];
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        
//        //去掉分割线
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        
//        
//    }
//    
//    NSString *key = self.allDic.allKeys[indexPath.section];
//    
//    PopThered *there = [self.allDic objectForKey:key][indexPath.row];
//    cell.textLabel.text = there.title;
//    cell.detailTextLabel.text = there.tags;
//    
//    NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    
//    path1 = [path1 stringByAppendingFormat:@"/%@%@",there.title,@".jpg"];
//    
//    NSData *resultData = [NSData dataWithContentsOfFile:path1];
//    
//    UIImage *resultimage = [UIImage imageWithData:resultData];
//    
//    
//    if (resultimage == nil) {
//        
//        UIImage *image = [UIImage imageNamed:@"17153115_1363673599.jpg"];
//        cell.imageView.image = image;
//    }
//    else
//    {
//        
//        cell.imageView.image = resultimage;
//    
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if ([UIScreen mainScreen].bounds.size.height <= 500) {
        
        NSLog(@"4s 3.7");
        return 300;
        
    }else if ([UIScreen mainScreen].bounds.size.height >=500 && [UIScreen mainScreen].bounds.size.height <=600)
    {
        NSLog(@"5s 4");
      return 350;
        
    }else if ([UIScreen mainScreen].bounds.size.height >= 600 && [UIScreen mainScreen].bounds.size.height <= 700)
    {
        NSLog(@"6 4.7");
    
        return 400;
    }
    else
    {
        NSLog(@"6plus 5.5");
        return 430;
        
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




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//设置tableView的头标题以及点击事件
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewMain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
    viewMain.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(5, 5,self.tableView.frame.size.width - 10, 30)];
    
//     UIImage *img = [UIImage imageNamed:@"17153115_1363673599.jpg"];
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
//    
//    imgView.frame = CGRectMake(5, 5, view.frame.size.width, view.frame.size.height);
//    
//    
//    [self.view addSubview:imgView];
    
    
    
    
    UIButton *btnTgr = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnTgr.size = CGSizeMake(view.frame.size.width, view.frame.size.height);
    [btnTgr setTitle:self.allDic.allKeys[section] forState:UIControlStateNormal];
    [btnTgr setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnTgr.tag = 100 + section;
    [btnTgr addTarget:self action:@selector(btnTgrAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnTgr];
    view.backgroundColor = [UIColor blackColor];
    
    [viewMain addSubview:view];
    return viewMain;
}
//以及点击事件
- (void)btnTgrAction:(UIButton *)btnTgr
{
 
    if ([[self.ArrayHead objectAtIndex:btnTgr.tag - 100] intValue]== 0 ) {
        
        [self.ArrayHead replaceObjectAtIndex:btnTgr.tag - 100 withObject:@"1"];
        [self.tableView reloadData];
    }else
    {
        [self.ArrayHead replaceObjectAtIndex:btnTgr.tag - 100 withObject:@"0"];
        [self.tableView reloadData];
    }
 
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    
//    [self performSegueWithIdentifier:@"show" sender:nil];
    
    
    //改
    PopMusicPlayViewController *player = [PopMusicPlayViewController sharePopMusicPlayVC];
    player.index = self.currentPath.row;
    NSString *key = self.allDic.allKeys[self.currentPath.section];
    NSArray *array = self.allDic[key];
    
    NSMutableArray *Array222  = [NSMutableArray arrayWithArray:array];
    player.array = Array222;
    player.PopName = @"0";
    
    [self showDetailViewController:player sender:nil];
    
    
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"show"]) {
//        
//        PopMusicPlayViewController *playVC = (PopMusicPlayViewController *)segue.destinationViewController;
//        
//        playVC.index = self.currentPath.row;
//       NSString *key = self.allDic.allKeys[self.currentPath.section];
//        NSArray *array = self.allDic[key];
//        
//        NSMutableArray *Array222  = [NSMutableArray arrayWithArray:array];
//        
//        NSLog(@"%@",Array222);
//        
//        playVC.array = Array222;
//        playVC.PopName = @"0";
//        
//    }
//    
//}


#pragma mark 删除音乐
//设置是否编辑

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//设置编辑按钮
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
    if (!self.tableView.editing) {
        
         sender.title = @"完成";
    }
    else
    {
         sender.title = @"编辑";
     
    }
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[DBManager showDBManager] openDBManager];
        //获取本地文件名
//        NSFileManager * fileManager = [NSFileManager defaultManager];
//        NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
//        
//        NSLog(@"%@",tempFileList);
      
 //=========删除数据库里的数据================================
        
        //之前的数组
//        PopThered *there = self.allArray[indexPath.row];
//        
//        NSString *Str = there.title;
//
//        [[DBManager showDBManager] deletefromTitle:Str];
//
//        [[DBManager showDBManager]closeDBmanager];
        
        //后加的字典
        NSString *key = self.allDic.allKeys[indexPath.section];
        NSMutableArray *array = self.allDic[key];
        PopThered *there = array[indexPath.row];
        
        NSString *Str = there.title;
        [[DBManager showDBManager] deletefromTitle:Str];
        [[DBManager showDBManager] closeDBmanager];
        
 //==========删除本地文件=====================================
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            path = [path stringByAppendingFormat:@"/%@%@",Str,@".mp3"];
             //删除本地文件
            NSFileManager *defaultManager;
        
            defaultManager = [NSFileManager defaultManager];
        
            [defaultManager removeItemAtPath:path error:nil];
        
//===============删除本地图片========================================
        
        NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        path1 = [path1 stringByAppendingFormat:@"/%@%@",Str,@".jpg"];
        
        NSFileManager *defaultManager1;
        
        defaultManager1 = [NSFileManager defaultManager];
        
        [defaultManager1 removeItemAtPath:path1 error:nil];
        
        

 //============删除数组里的内容==============================
        //之前的数组
//        [self.allArray removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //后来的字典
        [array removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {

        
    }   
}

- (NSMutableDictionary *)allDic
{
    if (!_allDic) {
        self.allDic = [NSMutableDictionary dictionary];
    }
    return _allDic;
}

- (NSMutableArray *)ArrayRows
{
    
    if (!_ArrayRows) {
        
        
        self.ArrayRows = [NSMutableArray array];
        
    }
    return _ArrayRows;
}



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
