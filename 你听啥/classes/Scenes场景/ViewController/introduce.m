//
//  introduce.m
//  你听啥
//
//  Created by anyurchao on 15/11/1.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "introduce.h"
#import "IntroduceScrollView.h"

@interface introduce()

@property (nonatomic,assign)CGFloat height;

@end

@implementation introduce

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addAllViews];
        
    }
    return self;
}

- (void)addAllViews
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 20)];
    
    [self addSubview:view];
    
    
    self.introduceLabel = [[IntroduceScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 20, self.frame.size.height - 40) String:@""];
    
    self.introduceLabel.label.backgroundColor = [UIColor whiteColor];
    self.introduceLabel.label.font = [UIFont systemFontOfSize:20];
    self.introduceLabel.label.textColor = [UIColor blackColor];
    
    //1.为introduceScrollView.label.text赋值
    self.introduceLabel.label.text = @"1.这款音乐播放器具有播放音乐的基础功能,并且可以实现上一曲,播放/暂停,下一曲,歌曲的顺序播放,循环播放,单曲循环播放,随机播放的功能;并且可以实现音乐的下载功能,妈祖用户体验随身听,随便听的需求;\n2.播放的音乐界面PopMusic里面不仅仅仅有当今流行歌曲,更有古典的老歌,经典的情歌,高雅的名歌;\n3.在PopSoundes界面里有经典相声,百家讲坛,当今趣闻等你听;\n4.一些戏曲迷们最困惑的是现在的手机播放器里面已经快找不到戏曲的影子了,不过这一点不用担心,在PopOpera里面收录了,京剧名段,黄梅戏,越剧等你来品味;\n5.在主界面菜单里的文本框里你可以写下你的心情,在我的下载里面搜寻你已经下载的歌曲,在我的相册里面你还可以更改当前的头像,这款播放器还可以实现音乐图片的查阅功能,在图片收藏界面里搜索你喜欢的音乐封面图片,单指双击退出,单指长按图片还有可以分享到各个平台,双指单机一下还可以对当前图片进行美化,单指单机击退出美图界面返回收藏界面;\n6.还在担心系统垃圾过多吗?这也不叫事,清除缓存让你的手机清除过多的系统缓存文件,让可用空间变多;";
    
    self.introduceLabel.label.textAlignment = NSTextAlignmentLeft;
    self.introduceLabel.label.lineBreakMode = NSLineBreakByClipping;
    
    //2计算赋值后introduceScrollView.label的高度
    self.height = [self.introduceLabel caleHeightForCellWithLabel:self.introduceLabel.label];
    //3将高度赋给label
    CGRect frame = self.introduceLabel.label.frame;
    frame.size.height = self.height;
    self.introduceLabel.label.frame = frame;
    
     //4不要要忘了introduceScrollView.contentSize
    self.introduceLabel.contentSize = CGSizeMake(self.frame.size.width -40, self.height + 100);
    [view addSubview:self.introduceLabel];
    
    

}



@end
