//
//  ViewController.m
//  LXFVideoTransformDemo
//
//  Created by 林洵锋 on 2017/4/5.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

#import "ViewController.h"

#define AnimatationDuration 0.25

@interface ViewController ()

/** redView */
@property(nonatomic, strong) UIView *redView;
/** isFullscreen */
@property(nonatomic, assign) BOOL isFullscreen;
/** redViewFrame */
@property(nonatomic, assign) CGRect redViewFrame;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认值
    _isFullscreen = NO;
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 150, 100)];
    self.redViewFrame = redView.frame;
    _redView = redView;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeFrame)];
    [redView addGestureRecognizer:tapGesture];
}

- (void)changeFrame {
    self.isFullscreen = !self.isFullscreen;
    
    NSLog(@"%d", _isFullscreen);
    
    if (self.isFullscreen) {    // 进入全屏
        CGRect rectInWindow = [self.redView convertRect:self.redView.bounds toView:[UIApplication sharedApplication].keyWindow];
        [self.redView removeFromSuperview];
        self.redView.frame = rectInWindow;
        [[UIApplication sharedApplication].keyWindow addSubview:self.redView];
        // 执行动画
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];;
        [UIView animateWithDuration:AnimatationDuration animations:^{
            self.redView.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.redView.bounds = CGRectMake(0, 0, CGRectGetHeight(self.redView.superview.bounds), CGRectGetWidth(self.redView.superview.bounds));
            self.redView.center = CGPointMake(CGRectGetMidX(self.redView.superview.bounds), CGRectGetMidY(self.redView.superview.bounds));
        } completion:^(BOOL finished) {
            
        }];
    } else {    // 退出全屏
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];;
        CGRect frame = [self.view convertRect:self.redViewFrame toView:[UIApplication sharedApplication].keyWindow];
        [UIView animateWithDuration:AnimatationDuration animations:^{
            self.redView.transform = CGAffineTransformIdentity;
            self.redView.frame = frame;
        } completion:^(BOOL finished) {
            [self.redView removeFromSuperview];
            self.redView.frame = self.redViewFrame;
            [self.view addSubview:self.redView];
        }];
        
    }
    
    NSLog(@"%@", NSStringFromCGAffineTransform(CGAffineTransformIdentity));
    
}

- (BOOL)shouldAutorotate {
    return NO;
}

/*
 setStatusBarOrientation 未生效的解决办法
 并且在当前ViewController处于NavigationController下，那么全屏引入 #import "UINavigationController+Rotation.h" 即可。
 具体原因看 UINavigationController+Rotation.m
 */


@end
