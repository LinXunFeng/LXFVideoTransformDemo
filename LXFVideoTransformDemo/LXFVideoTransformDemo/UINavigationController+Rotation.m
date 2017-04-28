//
//  UINavigationController+Rotation.m
//  LXFVideoTransformDemo
//
//  Created by 林洵锋 on 2017/4/6.
//  Copyright © 2017年 林洵锋. All rights reserved.
//

#import "UINavigationController+Rotation.h"

@implementation UINavigationController (Rotation)

// setStatusBarOrientation 未生效的解决办法
//由于UIViewController放置在Navigation中，而由于Navigation不人性化的设计，navigation的- (BOOL)shouldAutorotate是不会根据显示ViewController的- (BOOL)shouldAutorotate设置的值来改变的。

// 引入该头文件，这个时候Navigation就会根据你显示的ViewController改变返回值了,然后你再去ViewController中覆写方法,返回NO,这时候,方法生效了!bingo!

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}


- (NSUInteger)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}


- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
