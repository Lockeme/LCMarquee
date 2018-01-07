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
    LCMarqueeView *marquee = [[LCMarqueeView alloc] initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width - 20, 60) andContent:@"LC自制基础跑马灯，功能还有待完善，需要加功能或改bug请加我qq:443924584告诉我，感谢支持！！"];
    /** 属性设置
    marquee.marqueeFont = 18;
    marquee.duration = 12.f;
    marquee.marqueeColor = [UIColor redColor];
    marquee.placeholderWidth = 60.f;
    */
    [marquee startMarqueeAnimate];
    [self.view addSubview:marquee];
}


@end
