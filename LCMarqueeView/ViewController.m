//
//  ViewController.m
//  LCMarqueeView
//
//  Created by Lockeme on 2018/1/7.
//  Copyright © 2018年 Lockeme. All rights reserved.
//

#import "ViewController.h"
#import "LCMarqueeView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createMarquee];
}

- (void)createMarquee
{
    LCMarqueeView *marquee = [[LCMarqueeView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 60, 60) andContent:@"自制基础跑马灯跑马灯跑马灯跑马灯跑马灯，自制基础跑马灯跑马灯跑马灯跑马灯跑马灯"];
    marquee.center = self.view.center;
    /** 属性设置
    marquee.marqueeFont = 18;
    marquee.duration = 12.f;
    marquee.marqueeColor = [UIColor redColor];
    marquee.placeholderWidth = 60.f;
    marquee.pauseInterval = 0;
    */
    [self.view addSubview:marquee];
    [marquee startMarqueeAnimate];
}


@end
