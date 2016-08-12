//
//  LeftSortsViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "LeftSortsViewController.h"
#import "YCDelegate.h"

@interface LeftSortsViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UIImageView *imgView;
@property (nonatomic,strong)UIView *viewRash;


@end

@implementation LeftSortsViewController

- (void) tgrAction:(id)sender
{
    [self.textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [self.textField resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"17153115_1363673599.jpg"];
    [self.view addSubview:imageview];

    UITableView *tableview = [[UITableView alloc] init];
    self.tableview = tableview;
    tableview.frame = self.view.bounds;
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
     cell.textLabel.highlighted = YES;
    cell.textLabel.textColor = [UIColor blackColor];
     cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
  
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"我的下载";
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    } else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"我的相册";
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    } else
        if (indexPath.row == 2)
    {
        cell.textLabel.text = @"图片收藏";
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20];
    }
    else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"产品介绍";
    }
    else
    {
        
        cell.textLabel.text = @"清除缓存";
        
    }
//    else if (indexPath.row == 2) {
//        cell.textLabel.text = @"注册账号";
//    } else if (indexPath.row == 3) {
//        cell.textLabel.text = @"更换头像";
//    } else if (indexPath.row == 4) {
//        cell.textLabel.text = @"我的收藏";
//    } else if (indexPath.row == 5) {
//        cell.textLabel.text = @"个性装扮";
//    } else if (indexPath.row == 6) {
//        cell.textLabel.text = @"我的文件";
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YCDelegate *tempAppDelegate = (YCDelegate *)[[UIApplication sharedApplication] delegate];
    
    switch (indexPath.row) {
        case 0:
        {
            
            
            storeMusicTableViewController *StoreMusic = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"storeMusicTable"];
            
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            
            [tempAppDelegate.mainNavigationController pushViewController:StoreMusic animated:NO];

            
            
            
//            LoginViewController *loginVC = [LoginViewController new];
//            
//            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
//            
//            [tempAppDelegate.mainNavigationController pushViewController:loginVC animated:NO];
            
            //            @IBAction func selectHeaderPictureAction(sender: AnyObject) {
            //                let pickerController = UIImagePickerController()
            //                pickerController.delegate = self    // 设置代理
            //                pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary    // 设置数据源为从相册选择
            //                self.presentViewController(pickerController, animated: true, completion: nil)   // 模态出来
            //            }

            
            //            // 回调方法中给照片赋值
            //            func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            //
            //                userHeaderPictureImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            //                self.dismissViewControllerAnimated(true, completion: nil)
            //            }

            
        }break;
        case 1:
        {
            UIImagePickerController *pic = [[UIImagePickerController alloc] init];
            pic.delegate = self;
            pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self presentViewController:pic animated:YES completion:^{
            //
            //            }];
            
            [self showDetailViewController:pic sender:nil];
            

            
            
        }break;
        case 2:
        {
            RootViewController *root = [RootViewController new];
            
            
//            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
//            
//            [tempAppDelegate.mainNavigationController pushViewController:root animated:NO];
            [self showDetailViewController:root sender:nil];
            
            
            
            
        }break;
            case 3:
        {
            introduceViewController *introduceVC = [introduceViewController new];
            
            
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            
            [tempAppDelegate.mainNavigationController pushViewController:introduceVC animated:NO];
            
        }break;
        case 4:
        {
            
            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            
            //            CGFloat rash = [FileService fileSizeAtPath:cachPath];
            CGFloat rash2 =[FileService folderSizeAtPath:cachPath];
            
            [self.view addSubview:self.viewRash];
            
            NSString *Str = [NSString stringWithFormat:@"%f",rash2];
            
            
            
            NSString *str1 = [Str substringToIndex:3];
            
            NSString *str2 = [str1 stringByAppendingString:@"M"];
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:str2 preferredStyle:UIAlertControllerStyleAlert];
            
            // Create the actions.
            UIAlertAction *certAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                
                [FileService clearCache:cachPath];
                
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:certAction];
            
            [self showViewController:alertController sender:nil];

            
            
        }break;
        default:
            break;
            
            
            
            
            
    }
    
}

#pragma mark 回调给图片赋值
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    self.imgView.image =  info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableview.bounds.size.width, 0)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];
    
    
    CGFloat y = 50;
    
    imgview.frame = CGRectMake(self.view.frame.size.width / 3, y , 50, 50);
    imgview.layer.cornerRadius = 25;
    imgview.layer.masksToBounds = YES;
    [view addSubview:imgview];
    self.imgView = imgview;
    
    
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, y + 10, self.view.frame.size.width / 3, 30)];
    
    labelName.text = @"青梅煮酒";
    
    labelName.textColor = [UIColor whiteColor];
    [view addSubview:labelName];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 3, y + 80, self.view.frame.size.width / 3, 30)];
    field.textAlignment = NSTextAlignmentCenter;
    field.placeholder = @"编辑你的个性签名^@^";
    field.tintColor = [UIColor blackColor];
    field.textColor = [UIColor whiteColor];
    field.backgroundColor = [UIColor clearColor];
    field.borderStyle = UITextBorderStyleLine;
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tgrAction:)];
    
    field.delegate = self;
    
    [view addGestureRecognizer:tgr];
    [view addSubview:field];
    
    self.textField = field;
    return view;
}


@end
