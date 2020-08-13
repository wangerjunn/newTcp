//
//  LoadingAnimationView.m
//  NewTcpApp
//
//  Created by xslp on 2020/7/31.
//  Copyright © 2020 xslpiOS. All rights reserved.
//

#import "LoadingAnimationView.h"

@interface LoadingAnimationView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation LoadingAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)showInView:(UIView *)view
{
    if (view == nil) {
            
        view = [UIApplication sharedApplication].windows[0];
//            if (@available(iOS 13.0, *)) {
//
//            } else {
//
//                view = [UIApplication sharedApplication].keyWindow;
//            }
        
    }
    [view addSubview:self];
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [UIColor whiteColor];
    self.imageView.frame = CGRectMake(0, 0, 80*[UIScreen mainScreen].bounds.size.width/375, 80*[UIScreen mainScreen].bounds.size.width/375);
    self.imageView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-64);
    
    self.textLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+15, self.bounds.size.width, 20);
    
    [self.imageView startAnimating];
}

-(void)dismiss
{
    [self.imageView stopAnimating];
    [self.imageArray removeAllObjects];
    [self.imageView removeFromSuperview];
    [self.textLabel removeFromSuperview];
    [self removeFromSuperview];
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        for (NSInteger i = 1; i <= 14; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%ld.jpg", (long)i]];
            [self.imageArray addObject:image];
        }
        //图片播放一次所需时长
        _imageView.animationDuration = 1.0;
        
        //图片播放次数,0表示无限
        _imageView.animationRepeatCount = 0;

        //设置动画图片数组
        _imageView.animationImages = self.imageArray;
    }
    return _imageView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.text = @"正在努力加载...";
        textLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        textLabel.font = [UIFont systemFontOfSize:14];
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:textLabel];
        _textLabel = textLabel;
    }
    return _textLabel;
}

@end
