//
//  PhotoScrollView.m
//  Photos_Demo
//
//  Created by anyurchao on 15/9/9.
//  Copyright (c) 2015年 anyurchao. All rights reserved.
//

#import "PhotoScrollView.h"

@interface PhotoScrollView ()<UIScrollViewDelegate>
#pragma mark -声明私有属性
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation PhotoScrollView


- (instancetype) initWithFrame:(CGRect)frame
                   imageName:(NSString *)imageName{
    if (self = [super initWithFrame:frame]) {
        
        
        NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        //获取图片
        path1 = [path1 stringByAppendingFormat:@"/%@",imageName];
        
        NSData *resultData = [NSData dataWithContentsOfFile:path1];
        
        UIImage *resultimage = [UIImage imageWithData:resultData];
        
        
           // 添加图片视图
        self.imageView = [[UIImageView alloc] initWithImage:resultimage];

        _imageView.frame = self.bounds;
        
        [self addSubview:_imageView];
        //设置缩放相关属性
        self.delegate = self;
        self.minimumZoomScale = .2;
        self.maximumZoomScale = 2.;
        
    }return self;
}

#pragma mark - 实现协议方法
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
    CGRect viewFram = view.frame;
    CGSize scrollViewSize = scrollView.frame.size;
    if (viewFram.size.width <scrollViewSize.width) {
        viewFram.origin.x = (scrollViewSize.width - viewFram.size.width)/2;
    }else{
        viewFram.origin.x = 0;

    }
    
    if (viewFram.size.height < scrollViewSize.height) {
        viewFram.origin.y = (scrollViewSize.height - viewFram.size.height)/2;
    }else{
        viewFram.origin.y = 0;
    }
    view.frame = viewFram;
}


- (void) normal{
    //将photoScrollView缩放比例设置为不缩放
    self.zoomScale = 1;
    
    //将图片的位置调整能为原点对齐
    _imageView.frame = CGRectMake(0, 0, _imageView.frame.size.width, _imageView.frame.size.height);
}






@end
