//
//  PopMusicPlayViewController.m
//  你听啥
//
//  Created by anyurchao on 15/10/23.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "PopMusicPlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UMSocial.h"
#define FILEPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
@interface PopMusicPlayViewController ()<playerHelperDelegate,NSURLSessionDownloadDelegate,UMSocialUIDelegate>
{
    
    NSInteger _currentIndex;
    PopThered *_currentMusic;
    NSMutableArray *_currentArray;
}
@property (weak, nonatomic) IBOutlet UIButton *playAction;
@property (weak, nonatomic) IBOutlet UIButton *nextAction;
@property (weak, nonatomic) IBOutlet UIButton *lastAction;
@property (weak, nonatomic) IBOutlet UIView *OnView;
@property (nonatomic,assign)double progress;
@property (weak, nonatomic) IBOutlet UILabel *labelProgress;
@property (weak, nonatomic) IBOutlet UILabel *labelProgressFinal;
@property (weak, nonatomic) IBOutlet UILabel *LabelSound;

//时间LabelSound
@property (nonatomic,assign)int SondChange;
//时间Label闪动的判断
@property (nonatomic,assign)int timeFinal;

//下载任务
@property (nonatomic,strong)NSURLSessionDownloadTask *downLoadTask;
//网络
@property (nonatomic,strong)NSURLSession *session;
//下载的数据
@property (nonatomic,strong)NSData *downLoadData;
//
@property (nonatomic,strong)AVAudioPlayer *player;

@property (weak, nonatomic) IBOutlet UIButton *btnDownLoad;
@property (nonatomic,assign)BOOL isDownLoad;
@property (nonatomic,strong)UIProgressView *progressView;
//取消下载
@property (nonatomic,strong)UIButton *btnCancel;
@property (nonatomic,strong)UIImage *imgShare;

@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;


@property (nonatomic,strong)UIActivityIndicatorView *activity;

@end

@implementation PopMusicPlayViewController

+ (instancetype) sharePopMusicPlayVC{
    
    
    static PopMusicPlayViewController *playerVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        playerVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PopMusicPlay"];
        
    });
    
    return playerVC;
}

- (IBAction)btnShare:(UIButton *)sender {
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5633176067e58e3e8c002cd3"
                                      shareText:@"你要分享的文字"
                                     shareImage:self.imgShare
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil]
                                       delegate:self];
    
//    [UMSocialSnsService presentSnsController:self appKey:@"5633176067e58e3e8c002cd3" shareText:@"来自你听啥的分享" shareImage:self.imgShare shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil] delegate:self];
    
    
}

- (UIImage *)imgShare
{
    if (!_imgShare) {
        
        self.imgShare = [UIImage new];
        
    }
    return _imgShare;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isDownLoad = NO;
    
    _currentIndex = -2;
    
    self.sliderVolum.value = [playerHelper shareHelper].sound;
    
    NSLog(@"%f",self.sliderVolum.value);
    
    //判断显示声音百分比
    self.SondChange = (int)self.sliderVolum.value;
    NSString *soundADD = @"%";
    NSString *sound = [NSString stringWithFormat:@"%d",self.SondChange*100];
    
    
    
    
    self.LabelSound.text = [soundADD stringByAppendingString:sound];
    
    if (self.SondChange == 0) {
        
        self.sliderVolum.maximumValueImage = [UIImage imageNamed:@"sound_mute_32px_1093206_easyicon.net"];
        
    }else if (self.SondChange <= 25)
    {
        self.sliderVolum.maximumValueImage = [UIImage imageNamed:@"sound_32px_1093202_easyicon.net"];
    }else{
        
        if (self.SondChange <=50 && self.SondChange >= 25) {
            
            self.sliderVolum.maximumValueImage = [UIImage imageNamed:@"sound_32px_1093203_easyicon.net"];
            
        }else
        {
            
            self.sliderVolum.maximumValueImage = [UIImage imageNamed:@"sound_32px_1093204_easyicon.net"];
            
        }
        
        
    }
   
    
    NSLog(@"%ld",self.array.count);
    [self.playAction setTitle:@"Pause" forState:UIControlStateNormal];
    
    [self.sliderVolum addTarget:self action:@selector(sliderVolumeAction:) forControlEvents:UIControlEventValueChanged];
    
    [playerHelper shareHelper].delegate =self;
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    
    self.progressView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 110, 80, 100, 5);
    self.progressView.hidden = YES;
    [self.OnView addSubview:self.progressView];
    
    
    //显示按钮取消下载
    self.btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnCancel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 110, 85, 100, 30);
    [self.btnCancel setTitle:@"取消下载" forState:UIControlStateNormal];
    [self.btnCancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.btnCancel addTarget:self action:@selector(btnCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    self.btnCancel.hidden = YES;
    [self.OnView addSubview:self.btnCancel];
    
//    self.imgView.frame.size.width / 2
   
    
    
    
#pragma mark ======================down Load===========================
    //初始化网络
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)sliderVolumeAction:(UISlider *)sender{
    
    [playerHelper shareHelper].sound = sender.value;
    //判断显示声音百分比
    
    float sondY = sender.value * 100;
    self.SondChange = (int)sondY;
    NSLog(@"%d",self.SondChange);
    NSString *soundADD = @"%";
    NSString *sound = [NSString stringWithFormat:@"%d",self.SondChange];
    self.LabelSound.text = [soundADD stringByAppendingString:sound];
    if (self.SondChange == 0) {
        
        self.sliderVolum.maximumValueImage = [UIImage imageNamed:@"sound_mute_32px_1093206_easyicon.net"];
        
    }else if (self.SondChange <= 25)
    {
        self.sliderVolum.maximumValueImage = [UIImage imageNamed:@"sound_32px_1093202_easyicon.net"];
    }else
    {
        
        if (self.SondChange <=50 && self.SondChange >= 25) {
            
            self.sliderVolum.maximumValueImage = [UIImage imageNamed:@"sound_32px_1093203_easyicon.net"];
            
        }else
        {
            
            self.sliderVolum.maximumValueImage = [UIImage imageNamed:@"sound_32px_1093204_easyicon.net"];
            
        }

    }
    
}

- (void)sliderProgressAction:(UISlider *)sender{
    
    [[playerHelper shareHelper] seekToTime:sender.value];
    
}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
 

    
    
    NSLog(@"%f",self.imgView.frame.size.width);
    
    //时间进度条
    [self.sliderProgress addTarget:self action:@selector(sliderProgressAction:) forControlEvents:UIControlEventValueChanged];
    
    
    if (_index == -1) {
        
        self.btnShare.hidden = YES;
        self.btnBack.hidden = YES;
        return;
    }
    
    PopThered *there = self.array[_index];
    
    
    if (_currentIndex == _index && [_currentMusic.title isEqualToString:there.title]) {
        self.btnShare.hidden = NO;
         self.btnBack.hidden = NO;
    [self.playAction setTitle:@"Pause" forState:UIControlStateNormal];
        return;
    }
    self.btnShare.hidden = NO;
    self.btnBack.hidden = NO;
    _currentIndex = _index;
    [self prepareForPlaying];
    
}
- (void)prepareForPlaying{
    
    _currentArray = self.array;
    NSLog(@"%@",self.array);
    _currentMusic = self.array[_currentIndex];
    [self showInfor];
    
    
    self.activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 50, 50)];
    
    self.activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    self.activity.color = [UIColor magentaColor];
    
    [self.view.subviews[0] addSubview:self.activity];
    
    if ([playerHelper shareHelper].isPlaying == NO) {
        
        [self.activity startAnimating];
    }else{
        
        [self.activity stopAnimating];
    }
    
    if (!_currentMusic.playUrl64) {
        
        //获取本地所有文件名称数组
        NSFileManager * fileManager = [NSFileManager defaultManager];
        NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
        
        //获取播放的本地URL
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        path = [path stringByAppendingFormat:@"/%@%@",_currentMusic.title,@".mp3"];
        
//        NSLog(@"%@",tempFileList);
//        NSLog(@"%@",path);
        NSString *LocolMusic = [NSString stringWithFormat:@"%@%@",_currentMusic.title,@".mp3"];
        
        if ([tempFileList containsObject:LocolMusic]) {
        
            NSURL *url = [NSURL fileURLWithPath:path];
            [[playerHelper shareHelper] playerWithUrl:url];
            
        }
        else
        {
        
            TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"本地文件损坏"];
            [timer show];
            self.imgView.transform = CGAffineTransformMakeRotation(0);
            
        }
        
    }
    else
    {
         [[playerHelper shareHelper] playerWithUrlString:_currentMusic.playUrl64];
    }
  
}
- (void)showInfor
{
    if (!_currentMusic.playUrl64) {
        
        NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        path1 = [path1 stringByAppendingFormat:@"/%@%@",_currentMusic.title,@".jpg"];
        
        NSData *resultData = [NSData dataWithContentsOfFile:path1];
        
        UIImage *resultimage = [UIImage imageWithData:resultData];
        
        //获取本地所有文件名称数组
        NSFileManager * fileManager = [NSFileManager defaultManager];
        NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
        
        NSString *LocolImg = [NSString stringWithFormat:@"%@%@",_currentMusic.title,@".jpg"];

        
        if ([tempFileList containsObject:LocolImg]) {
            self.labelName.text = _currentMusic.title;
            
            self.imgView.image = resultimage;
//            self.imgView1.image = resultimage;
            self.imgView2.image = resultimage;
//            self.imgView3.image = resultimage;
            self.imgView1.image = [UIImage imageNamed:@"black.jpg"];
            self.imgView3.image = [UIImage imageNamed:@"black.jpg"];
            self.imgShare = resultimage;


        }
        else
        {
            self.labelName.text = _currentMusic.title;
            
            self.imgView.image = [UIImage imageNamed:@"17153115_1363673599.jpg"];
//            self.imgView1.image = [UIImage imageNamed:@"17153115_1363673599.jpg"];
            self.imgView2.image = [UIImage imageNamed:@"17153115_1363673599.jpg"];
//            self.imgView3.image = [UIImage imageNamed:@"17153115_1363673599.jpg"];
//            self.imgView.image = [UIImage imageNamed:@"black.jpg"];
            self.imgView1.image = [UIImage imageNamed:@"black.jpg"];
//            self.imgView2.image = [UIImage imageNamed:@"black.jpg"];
            self.imgView3.image = [UIImage imageNamed:@"black.jpg"];
            self.imgShare = [UIImage imageNamed:@"17153115_1363673599.jpg"];

        }
        
    }
    else
    {
        self.labelName.text = _currentMusic.title;
//        [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:_currentMusic.coverLarge] placeholderImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];

//        [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:_currentMusic.coverLarge] placeholderImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:_currentMusic.coverLarge] placeholderImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];
        [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:_currentMusic.coverLarge] placeholderImage:[UIImage imageNamed:@"17153115_1363673599.jpg"]];
        self.imgView1.image = [UIImage imageNamed:@"black.jpg"];
        self.imgView3.image = [UIImage imageNamed:@"black.jpg"];
        
        self.imgShare  = self.imgView.image;
        
    }
    
    
    
    
   
    
   
    
      
    
    CGFloat time = _currentMusic.duration;
    //判断终点时间
    NSLog(@"%f",time);
    
    int time1 = (int)time / 60;
    
    int time2 = (int)time % 60;
    NSString *time11 = @"";
    NSString *time22 = @"";
    //判断分钟
    if (time1 <10) {
         time11 = [NSString stringWithFormat:@"0%d",time1];
    }else
    {
         time11 = [NSString stringWithFormat:@"%d",time1];
        
    }
    
    //判断秒
    
    if (time2 < 10) {
        time22 = [NSString stringWithFormat:@"0%d",time2];
    }
    else
    {
        time22 = [NSString stringWithFormat:@"%d",time2];
    }
    
    self.labelProgressFinal.text = [NSString stringWithFormat:@"%@:%@",time11,time22];
    _sliderProgress.maximumValue = time;
    
    
    self.labelProgress.text = [NSString stringWithFormat:@"00:00"];
    self.labelProgress.textColor = [UIColor blackColor];
    //总时间
    self.timeFinal = (int)time;
    
}




- (IBAction)btnBack:(UIButton *)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)btnLast:(UIButton *)sender {
    
    
    if (_index == -1) {
        
        if (self.array == nil) {
    
            TimerDisappearAlertView *timer =[[TimerDisappearAlertView alloc] initWithTitle:@"快去选歌曲吧"];
            [timer show];
            
            return;
        }else{
            
            _currentIndex ++;
            if (_currentIndex == self.array.count) {
                
                _currentIndex = 0;
                
            }
            [self prepareForPlaying];
        }
        
    }else
    {
        _currentIndex --;
        
        if (_currentIndex < 0) {
            _currentIndex = self.array.count - 1;
        }
        
        [self prepareForPlaying];
    }
  
    
}
- (IBAction)btnPlay:(UIButton *)sender {
    
    
   
    //大按钮点进来
    if (_index == -1) {
        
        if (self.array == nil) {
            
             [sender setTitle:@"Play" forState:UIControlStateNormal];
            
            TimerDisappearAlertView *timer =[[TimerDisappearAlertView alloc] initWithTitle:@"快去选歌曲吧"];
            [timer show];
            return;
        }
        else
        {
            
            
            if (!_currentMusic.playUrl64) {
                
                //从下载页面传来的
                //获取本地所有文件名称数组
                NSFileManager * fileManager = [NSFileManager defaultManager];
                NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
                
                //获取播放的本地URL
//                NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//                path = [path stringByAppendingFormat:@"/%@%@",_currentMusic.title,@".mp3"];
                
                NSString *LocolMusic = [NSString stringWithFormat:@"%@%@",_currentMusic.title,@".mp3"];
                
                if (![tempFileList containsObject:LocolMusic]) {
                    
                    TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"本地文件损坏"];
                    [timer show];
                     self.imgView.transform = CGAffineTransformMakeRotation(0);
                    
                    [sender setTitle:@"Play" forState:UIControlStateNormal];
                    
                    return;
                }else
                {
                    
                    //当前歌曲为从页面创来得.
                    if ([playerHelper shareHelper].isPlaying == YES) {
                        
                        [[playerHelper shareHelper] stop];
                        self.imgView.transform = CGAffineTransformMakeRotation(0);
                        
                        UIImage *image = [UIImage imageNamed:@"linkedin_128px_1069741_easyicon.net"];
                        
                        sender.imageView.image = image;
                        
                        
                        [sender setTitle:@"Play" forState:UIControlStateNormal];
                        
                        
                    }
                    else
                    {
                        
                        [[playerHelper shareHelper] play];
                        
                        UIImage *image = [UIImage imageNamed:@"music_57.72972972973px_1160820_easyicon.net"];
                        
                        sender.imageView.image = image;
                        
                        [sender setTitle:@"Pause" forState:UIControlStateNormal];
                        
                        return;
                    }

                    
                    
                }
                
        }
        else
        {
//            if (!_currentMusic.playUrl64) {
//                
//                //从下载页面传来的
//                //获取本地所有文件名称数组
//                NSFileManager * fileManager = [NSFileManager defaultManager];
//                NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
//                
//                //获取播放的本地URL
//                NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//                path = [path stringByAppendingFormat:@"/%@%@",_currentMusic.title,@".mp3"];
//                
//                NSString *LocolMusic = [NSString stringWithFormat:@"%@%@",_currentMusic.title,@".mp3"];
//                
//                if (![tempFileList containsObject:LocolMusic]) {
//                    
//                    TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"本地文件损坏"];
//                    [timer show];
//                    
//                    [sender setTitle:@"Play" forState:UIControlStateNormal];
//                    
//                    return;
//                }
//                else
//                {
            
                    //当前歌曲为从页面创来得.
                    if ([playerHelper shareHelper].isPlaying == YES) {
                        
                        [[playerHelper shareHelper] stop];
                        self.imgView.transform = CGAffineTransformMakeRotation(0);
                        
                        UIImage *image = [UIImage imageNamed:@"linkedin_128px_1069741_easyicon.net"];
                        
                        sender.imageView.image = image;
                        
                        
                        [sender setTitle:@"Play" forState:UIControlStateNormal];
                        
                        
                    }
                    else
                    {
                        
                        [[playerHelper shareHelper] play];
                        
                        UIImage *image = [UIImage imageNamed:@"music_57.72972972973px_1160820_easyicon.net"];
                        
                        sender.imageView.image = image;
                        
                        [sender setTitle:@"Pause" forState:UIControlStateNormal];
                        
                        return;
//                    }

//                }
            }

        }

    }
        
        return;
    }else
    {
        
        if (!_currentMusic.playUrl64) {
            
            //从下载页面传来的
            //获取本地所有文件名称数组
            NSFileManager * fileManager = [NSFileManager defaultManager];
            NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
            
            //获取播放的本地URL
//            NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//            path = [path stringByAppendingFormat:@"/%@%@",_currentMusic.title,@".mp3"];
            
            NSString *LocolMusic = [NSString stringWithFormat:@"%@%@",_currentMusic.title,@".mp3"];
            
            if (![tempFileList containsObject:LocolMusic]) {
                
                TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"本地文件损坏"];
                [timer show];
                self.imgView.transform = CGAffineTransformMakeRotation(0);
                [sender setTitle:@"Play" forState:UIControlStateNormal];
                
                return;
            }else
            {
                //普通播放
                if ([playerHelper shareHelper].isPlaying == YES) {
                    [[playerHelper shareHelper] stop];
                    self.imgView.transform = CGAffineTransformMakeRotation(0);
                    
                    UIImage *image = [UIImage imageNamed:@"linkedin_128px_1069741_easyicon.net"];
                    
                    sender.imageView.image = image;
                    
                    [sender setTitle:@"Play" forState:UIControlStateNormal];
                }
                else{
                    
                    
                    
                    [[playerHelper shareHelper] play];
                    
                    UIImage *image = [UIImage imageNamed:@"music_57.72972972973px_1160820_easyicon.net"];
                    
                    sender.imageView.image = image;
                    
                    [sender setTitle:@"Pause" forState:UIControlStateNormal];
                    
                }

                
                
            }
            
            
        }else
        {
            //普通播放
            if ([playerHelper shareHelper].isPlaying == YES) {
                [[playerHelper shareHelper] stop];
                self.imgView.transform = CGAffineTransformMakeRotation(0);
                
                UIImage *image = [UIImage imageNamed:@"linkedin_128px_1069741_easyicon.net"];
                
                sender.imageView.image = image;
                
                [sender setTitle:@"Play" forState:UIControlStateNormal];
            }
            else{
                
                
                
                [[playerHelper shareHelper] play];
                
                UIImage *image = [UIImage imageNamed:@"music_57.72972972973px_1160820_easyicon.net"];
                
                sender.imageView.image = image;
                
                [sender setTitle:@"Pause" forState:UIControlStateNormal];
                
            }

            
        }
       
        
    }

    
}
- (IBAction)btnNext:(UIButton *)sender {
    
    
    if (_index == -1) {
   
        
        NSLog(@"%ld",_currentIndex);
        if (self.array == nil) {
            

            TimerDisappearAlertView *timer =[[TimerDisappearAlertView alloc] initWithTitle:@"快去选歌曲吧"];
            [timer show];
            
            return;
        }else{
            
            _currentIndex ++;
            if (_currentIndex == self.array.count) {
                
                _currentIndex = 0;
                
            }
            [self prepareForPlaying];
            
            
        }


    }else{
        
        _currentIndex ++;
        if (_currentIndex == self.array.count) {
            
            _currentIndex = 0;
            
        }
        [self prepareForPlaying];
        
        
    }
 
}

- (void)playerWithTime:(NSTimeInterval)time{
    
//    if (_index == -1) {
//        
//        if (self.array == nil) {
//            
//            TimerDisappearAlertView *timer =[[TimerDisappearAlertView alloc] initWithTitle:@"快去选歌曲吧"];
//            [timer show];
//            
//            return;
//        }
//        
//    }
    self.sliderProgress.value = time;
    
    
    self.imgView.transform = CGAffineTransformRotate(self.imgView.transform,  M_1_PI / 15);
    
    //判断时间label
    int time1 = (int)time / 60;
    
    int time2 = (int)time % 60;
    NSString *time11 = @"";
    NSString *time22 = @"";
    //判断分种
    if (time1 <10) {
        time11 = [NSString stringWithFormat:@"0%d",time1];
    }else
    {
        time11 = [NSString stringWithFormat:@"%d",time1];
    }
    //判断秒
    
    if (time2 < 10)
    {
        time22 = [NSString stringWithFormat:@"0%d",time2];
    }
    else
    {
        time22 = [NSString stringWithFormat:@"%d",time2];
    }
    
    self.labelProgress.text = [NSString stringWithFormat:@"%@:%@",time11,time22];
    
   //判断时间闪动效果
    
    if (self.timeFinal - (int)time <= 10) {

        CGFloat random = arc4random()% 256 / 255.0;
         self.labelProgress.textColor = [UIColor colorWithRed:random  green:0  blue:0 alpha:1.0];
    }
}

- (void)didStop{
    
    
    if ([self.PlayerActionModel.currentTitle isEqualToString:@"单曲循环"])
    {
        [self btnSinglePlay];
        [self btnPlay:nil];
        [self btnPlay:nil];
        
    }
    else if ([self.PlayerActionModel.currentTitle isEqualToString:@"顺序播放"]){
        
        [self btnOrderPlay];
        [self btnPlay:nil];
        [self btnPlay:nil];
        
    }
    else if ([self.PlayerActionModel.currentTitle isEqualToString:@"循环播放"])
    {
        [self btnNext:nil];
        [self btnPlay:nil];
        [self btnPlay:nil];
        
    }
    else
    {
        //随机播放
        [self btnRandomPlay];
        [self btnPlay:nil];
        [self btnPlay:nil];

    }

}


//单曲循环
- (void)btnSinglePlay
{
    
    if (_index == -1) {
        
        NSLog(@"%ld",_currentIndex);
        if (self.array == nil) {
            
            TimerDisappearAlertView *timer =[[TimerDisappearAlertView alloc] initWithTitle:@"快去选歌曲吧"];
            [timer show];
            
            return;
        }else{
            
            [self prepareForPlaying];
        }
        
    }else{
        
        [self prepareForPlaying];
        
        
    }
 
}

//顺序播放
- (void)btnOrderPlay
{
    
    
    if (_index == -1) {
        
        NSLog(@"%ld",_currentIndex);
        if (self.array == nil) {
            
            
            TimerDisappearAlertView *timer =[[TimerDisappearAlertView alloc] initWithTitle:@"快去选歌曲吧"];
            [timer show];
            
            return;
        }else{
            
            _currentIndex ++;
            if (_currentIndex == self.array.count) {

                _currentIndex = 0;
                [self prepareForPlaying];
                [self btnPlay:nil];
                self.sliderProgress.value = 0;
                return;
            }
            [self prepareForPlaying];

            
        }
        
        
    }else{
        
        _currentIndex ++;
        if (_currentIndex == self.array.count) {
            
            //暂停
            _currentIndex = 0;
             [self prepareForPlaying];
            [self btnPlay:nil];
            self.sliderProgress.value = 0;
            
            return;
        }
        [self prepareForPlaying];

        
        
    }
}

//随机播放
- (void)btnRandomPlay
{
    if (_index == -1) {
        
        
        NSLog(@"%ld",_currentIndex);
        if (self.array == nil) {
            
            
            TimerDisappearAlertView *timer =[[TimerDisappearAlertView alloc] initWithTitle:@"快去选歌曲吧"];
            [timer show];
            
            return;
        }else{
            
            //(b - a + 0) + a
            
            
            
            _currentIndex  = arc4random()%(self.array.count - 0 + 0) + 0;
            NSLog(@"%ld",_currentIndex);

            [self prepareForPlaying];
            
            
        }
        
        
    }else{
        
        
        
         _currentIndex  = arc4random()%(self.array.count - 0 + 0) + 0;
        
        [self prepareForPlaying];
        
        
    }

}















#pragma mark downLoadAction
- (IBAction)downLoadAction:(UIButton *)sender {
     _isDownLoad = !_isDownLoad;
    
    if (_index == -1) {
    
        NSLog(@"%ld",_currentIndex);
        if (self.array == nil) {
            
            TimerDisappearAlertView *timer =[[TimerDisappearAlertView alloc] initWithTitle:@"快去选歌曲吧"];
            [timer show];
            
            return;
        }
        else
        {
            
            //获取本地文件名
            NSFileManager * fileManager = [NSFileManager defaultManager];
            NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
            
            NSLog(@"%@",tempFileList);
            
            
            NSString *str = [_currentMusic.title stringByAppendingString:@".mp3"];
            
            //判断本地文件中是否有当前歌曲文件
            if ([tempFileList containsObject:str]) {
                
                TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"你已经下载了"];
                [timer show];
                //        [sender setImage:[UIImage imageNamed:@"DownLoad"] forState:UIControlStateNormal];
                
                
            }
            else
            {        
//                _isDownLoad = !_isDownLoad;
                
                if (_isDownLoad) {
                    
                    
                    //&&&&&&&&&&&&&开始&&&&&&&&&&&&&&&
                    if (self.downLoadTask) {
                        
                        
                        TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"继续下载"];
                        [timer show];
                        [sender setImage:[UIImage imageNamed:@"PauseDownLoad"] forState:UIControlStateNormal];
                        
                        NSLog(@"%lu",self.downLoadData.length);
                        //把存储的下载数据给通过网络传递给服务器继续下载
                        self.downLoadTask = [self.session downloadTaskWithResumeData:self.downLoadData];
                        //        [self.btnDownLoad.imageView setImage:[UIImage imageNamed:@"PauseDownLoad"]];
                    }
                    else
                    {
                        
                        [sender setImage:[UIImage imageNamed:@"PauseDownLoad"] forState:UIControlStateNormal];
                        
                        TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"开始下载"];
                        [timer show];
                        
                           self.btnCancel.hidden = NO;
                         self.progressView.hidden = NO;
                        
                        self.downLoadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:_currentMusic.playUrl64]];
                        
                    }
                    //开始任务
                    [self.downLoadTask resume];
                    //*************************
                    
                }
                else
                {
                    
                    //&&&&&&&&&&&&&&&&&暂停&&&&&&&&&&&&&&
                    [self.downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                        
                        NSLog(@"%lu",resumeData.length);
                        self.downLoadData = resumeData;
                        [sender setImage:[UIImage imageNamed:@"DownLoad"] forState:UIControlStateNormal];
                        
                    }];
                    
                    //********************************
                    
                }
                
            }

        }
       
    }else{
    
    
    
    
    
    
    //获取本地文件名
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
    NSLog(@"%@",tempFileList);
        
        
    
    
    NSString *str = [_currentMusic.title stringByAppendingString:@".mp3"];
    
    //判断本地文件中是否有当前歌曲文件
    if ([tempFileList containsObject:str]) {

        TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"你已经下载了"];
        [timer show];
//        [sender setImage:[UIImage imageNamed:@"DownLoad"] forState:UIControlStateNormal];
        
        
    }
    else
    {
//    _isDownLoad = !_isDownLoad;
    
    if (_isDownLoad) {
        
        
//&&&&&&&&&&&&&开始&&&&&&&&&&&&&&&
        if (self.downLoadTask) {
            
            
            TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"继续下载"];
            [timer show];
            [sender setImage:[UIImage imageNamed:@"PauseDownLoad"] forState:UIControlStateNormal];
            
            NSLog(@"%lu",self.downLoadData.length);
            //把存储的下载数据给通过网络传递给服务器继续下载
            self.downLoadTask = [self.session downloadTaskWithResumeData:self.downLoadData];
            //        [self.btnDownLoad.imageView setImage:[UIImage imageNamed:@"PauseDownLoad"]];
        }
        else
        {

             [sender setImage:[UIImage imageNamed:@"PauseDownLoad"] forState:UIControlStateNormal];
                self.btnCancel.hidden = NO;
                self.progressView.hidden = NO;
            TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"开始下载"];
            [timer show];

            
            self.downLoadTask = [self.session downloadTaskWithURL:[NSURL URLWithString:_currentMusic.playUrl64]];
            
        }
        //开始任务
        

        [self.downLoadTask resume];
//*************************
 
    }
    else
    {

//&&&&&&&&&&&&&&&&&暂停&&&&&&&&&&&&&&
[self.downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
    
    NSLog(@"%lu",resumeData.length);
    self.downLoadData = resumeData;
            [sender setImage:[UIImage imageNamed:@"DownLoad"] forState:UIControlStateNormal];
    
}];
       
//********************************
        
    }

  }
    

 }
    
}


- (void)btnCancelAction:(UIButton *)sender
{
    
    [self.downLoadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        
        NSLog(@"%lu",resumeData.length);
        self.downLoadData = resumeData;
        [self.btnDownLoad setImage:[UIImage imageNamed:@"DownLoad"] forState:UIControlStateNormal];
        
    }];
    
    self.progressView.hidden = YES;
    self.downLoadTask = 0;
    self.progressView.progress = 0;
    sender.hidden = YES;

}

- (IBAction)PlayerActionModel:(UIButton *)sender {
    
    if ([sender.currentTitle isEqualToString:@"单曲循环"]) {
        
          [sender setTitle:@"顺序播放" forState:UIControlStateNormal];
        
    }else if ([sender.currentTitle isEqualToString:@"顺序播放"]){
        
        [sender setTitle:@"循环播放" forState:UIControlStateNormal];
        
    }else if ([sender.currentTitle isEqualToString:@"循环播放"])
    {
        
        [sender setTitle:@"随机播放" forState:UIControlStateNormal];
        
    }else
    {
        [sender setTitle:@"单曲循环" forState:UIControlStateNormal];
    }

}






#pragma mark ==================完成下载实现音乐播放==================================

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    //存储到本地
    
     NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        path = [path stringByAppendingFormat:@"/%@%@",_currentMusic.title,@".mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager moveItemAtURL:location toURL:url error:nil];
    
//存储图片
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_currentMusic.coverLarge]];
    
    NSURLSession *Session1 = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [Session1 dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data == nil) {
            NSLog(@"逗你玩");
        }
         NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        path1 = [path1 stringByAppendingFormat:@"/%@%@",_currentMusic.title,@".jpg"];
        [data writeToFile:path1 atomically:YES];
    }];
       
       [task resume];
    //结束

    PopThered *there = [PopThered new];
    there.title = _currentMusic.title;
    there.tags = _currentMusic.tags;
    there.duration = _currentMusic.duration;
    there.nickname = self.PopName;
//    NSLog(@"%@",location);
//    NSLog(@"%@",url);
    
    [[DBManager showDBManager] openDBManager];
    [[DBManager showDBManager] createTable];
    [[DBManager showDBManager] insertPopThered:there];
//    NSArray *Array = [[DBManager showDBManager] selectPopName:self.PopName];
//    
//    NSLog(@"%@",Array);
    [[DBManager showDBManager] closeDBmanager];
    
  
    
    //获取本地文件名
//    NSFileManager * fileManager = [NSFileManager defaultManager];
//    NSArray * tempFileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:FILEPATH error:nil]];
//
//    NSLog(@"%@",tempFileList);
    

    //删除本地文件
//    NSFileManager *defaultManager;
//    defaultManager = [NSFileManager defaultManager];
//    
//    [defaultManager removeItemAtPath:@"" error:nil];

    
    
    
//    [[playerHelper shareHelper]playerWithUrl:url];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        NSData *data = [manager contentsAtPath:url];
//        
//        self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
//        [self.player play];
//    });

    
}




#pragma mark ==================坚挺监听下载的进度======================

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float downLoadProgress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"%f", downLoadProgress);
    
    self.progressView.progress = downLoadProgress;

    if (downLoadProgress == 1) {
        
        
        TimerDisappearAlertView *timer = [[TimerDisappearAlertView alloc] initWithTitle:@"下载完成"];
        [timer show];
        
        [self.btnDownLoad setImage:[UIImage imageNamed:@"DownLoad"] forState:UIControlStateNormal];
        self.progressView.hidden = YES;
        self.btnCancel.hidden = YES;
        self.progressView.progress = 0;
        self.downLoadTask = 0;

    }
}

@end








