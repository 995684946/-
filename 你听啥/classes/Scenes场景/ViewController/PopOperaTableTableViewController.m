//
//  PopOperaTableTableViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/26.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopOperaTableTableViewController.h"

@interface PopOperaTableTableViewController ()
@property (nonatomic,assign)BOOL flag;
@end

@implementation PopOperaTableTableViewController

static NSString *cellID = @"PopSoundsFirst";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PopSoundsFirstTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];

    
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

- (void)headerRereshing
{
    [self.tableView reloadData];

    
    [self.tableView headerEndRefreshing];
  
}

- (void)footerRereshing
{
    [self.tableView reloadData];
    

    [self.tableView footerEndRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.flag = YES;
    if (_allArray.count != 0 ) {
        return;
    }
    else
    {
         [GMDCircleLoader setOnView:self.tableView withTitle:@"正在加载……" animated:NO];
    }
   
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_allArray.count != 0 ) {
       [GMDCircleLoader hideFromView:self.tableView animated:YES];
    }else
    {
        return;
    }
    
    
   
 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopSoundsFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
  PopMusic *pop =  self.allArray[indexPath.row];
    
    cell.popMusic = pop;

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        
        PopOperaSecondTableViewController *popOperaSecondVC = [PopOperaSecondTableViewController sharePopOperaVC];
        PopMusic *popMusic = self.allArray[indexPath.row];
        
        popOperaSecondVC.popMusic = popMusic;
        
        [self.navigationController pushViewController:popOperaSecondVC animated:YES];
        
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
