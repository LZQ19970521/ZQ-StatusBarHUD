//
//  ZQStatusBarHUD.h
//  ZQ-StatusBarHUD
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQStatusBarHUD : NSObject
/**外界自定义图片*/
+(void)showMessage:(NSString *)msg image:(UIImage *)image;

/**显示普通信息*/
+(void)showMessage:(NSString *)msg;

/**加载成功*/
+(void)showSuccess:(NSString *)msg;

/**加载成功*/
+(void)showError:(NSString *)msg;

/**显示正在处理的信息*/
+(void)showLoding:(NSString *)msg;

/**隐藏*/
+(void)hide;

@end
