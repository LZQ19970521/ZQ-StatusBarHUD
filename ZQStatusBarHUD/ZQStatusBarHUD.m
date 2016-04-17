//
//  ZQStatusBarHUD.m
//  ZQ-StatusBarHUD
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ZQStatusBarHUD.h"

#define ktextFont [UIFont systemFontOfSize:12]
/**消息停留的时间*/
static CGFloat const ZQDuration = 2.0;
/**消息显示/隐藏动画的时间*/
static CGFloat const ZQAnimationDuration = 0.25;
@implementation ZQStatusBarHUD

static UIWindow *window_;
static NSTimer * timer_;

/**创建窗口*/
+(void)creatWindow{
    
    //添加动画
    CGFloat windowH = 20;
    CGRect frame = CGRectMake(0, -windowH, [UIScreen mainScreen].bounds.size.width, windowH);
    //显示窗口
    window_.hidden = YES;
    window_ = [[UIWindow alloc]init];
    window_.frame = frame;
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor blackColor];
    window_.hidden = NO;
    //执行动画
    frame.origin.y = 0;
    [UIView animateWithDuration:ZQAnimationDuration animations:^{
        window_.frame = frame;
        
    }];
}


+(void)showMessage:(NSString *)msg image:(UIImage *)image{
    
    //停止定时器
    [timer_ invalidate];
    /**创建窗口*/
    [self creatWindow];
    //添加按钮:
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:msg forState:UIControlStateNormal];
    button.titleLabel.font = ktextFont;
    if (image) {//如果传过来的图片有值,就设置图片的间距
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    button.frame = window_.bounds;
    [window_ addSubview:button];
    //定时让控件消失:
    timer_ = [NSTimer scheduledTimerWithTimeInterval:ZQDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
    
    
}
/**加载成功*/
+(void)showSuccess:(NSString *)msg{
    
    [self showMessage:msg image:[UIImage imageNamed:@"ZQStatusBarHUD.bundle/Success"]];
    
}
/**加载失败*/
+(void)showError:(NSString *)msg{
    
    [self showMessage:msg image:[UIImage imageNamed:@"ZQStatusBarHUD.bundle/error1"]];
}
/**显示正在处理的信息*/
+(void)showLoding:(NSString *)msg{
    //停止定时器
    [timer_ invalidate];
    timer_ = nil;
    /**创建窗口*/
    [self creatWindow];
    //添加文字:
    UILabel *label = [[UILabel alloc]init];
    label.font = ktextFont;
    label.textColor = [UIColor whiteColor];
    label.text = msg;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = window_.bounds;
    [window_ addSubview:label];
    //添加圈圈:
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //文字的宽度
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName : ktextFont}].width;
    CGFloat centerX = (window_.frame.size.width - msgW) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    loadingView.center = CGPointMake(centerX, centerY);
    [loadingView startAnimating];
    [window_ addSubview:loadingView];
    
}
/**显示普通信息*/
+(void)showMessage:(NSString *)msg{
    
    [self showMessage:msg image:nil];
}
/**隐藏*/
+(void)hide{
    
    [UIView animateWithDuration:ZQAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = - frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
     }];
}
@end
