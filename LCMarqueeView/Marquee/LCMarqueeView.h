//
//  LCMarqueeView.h
//  LCLottery
//
//  Created by Lockeme on 2018/1/2.
//  Copyright © 2018年 Lockeme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCMarqueeView : UIView<CAAnimationDelegate>

//修改属性后需要调用 -(void)startMarqueeAnimate 才能生效
/** 跑马灯内容 */
@property (nonatomic, strong) NSString *contentString;
/** 跑马灯字体大小, default is 12 */
@property (nonatomic, assign) int marqueeFont;
/** 动画时长,默认根据内容长度计算 */
@property (nonatomic, assign) int duration;
/** 字体颜色, default is black */
@property (nonatomic, strong) UIColor *marqueeColor;
/** 占位宽度, default is 20 */
@property (nonatomic, assign) float placeholderWidth;
/** 循环一次后的停止间隔，default is 2 */
@property (nonatomic, assign) float pauseInterval;


/** 初始化方法, content跑马灯内容 */
- (instancetype)initWithFrame:(CGRect)frame andContent:(NSString *)content;
/** 开始/结束 动画 */
- (void)startMarqueeAnimate;
- (void)stopMarqueeAnimate;
@end
