//
//  LCMarqueeView.m
//  LCLottery
//
//  Created by Lockeme on 2018/1/2.
//  Copyright © 2018年 Lockeme. All rights reserved.
//

#import "LCMarqueeView.h"

#define PLACEHOLDER_WIDTH_DEFAULT 20
#define MARQUEE_ANIMATE @"marquee_animation"
@interface LCMarqueeView()
{
    NSString *_content;
    CGFloat _contentWidth;
}
/** 主View,包含 marqueeLabel-placeholderView-placeholderLabel */
@property (nonatomic, strong) UIView *marqueeView;
@property (nonatomic, strong) UILabel *marqueeLabel;//content label
@property (nonatomic, strong) UIView *placeholderView;//占位View
@property (nonatomic, strong) UILabel *placeholderLabel;//占位label
@property (nonatomic, strong) CAKeyframeAnimation *frameAnimation;
@end

@implementation LCMarqueeView

-(instancetype)initWithFrame:(CGRect)frame andContent:(NSString *)content
{
    self = [super initWithFrame:frame];
    if (self) {
        if (content.length) {
            _content = content;
            _marqueeFont = 12;
            _placeholderWidth = PLACEHOLDER_WIDTH_DEFAULT;
            [self addSubview:self.marqueeView];
            self.clipsToBounds = YES;
        }
    }
    return self;
}

#pragma mark - get & set
-(UIView *)marqueeView
{
    if (!_marqueeView) {
        CGSize contentSize = [_content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_marqueeFont]}];
        _contentWidth = contentSize.width;
        _duration = _contentWidth/CGRectGetWidth(self.frame)*8.f;//初始化动画时间
        _marqueeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentWidth*2+_placeholderWidth, CGRectGetHeight(self.frame))];
        [_marqueeView addSubview:self.marqueeLabel];
        [_marqueeView addSubview:self.placeholderView];
        [_marqueeView addSubview:self.placeholderLabel];
    }
    return _marqueeView;
}

-(UILabel *)marqueeLabel
{
    if (!_marqueeLabel) {
        _marqueeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _contentWidth, CGRectGetHeight(self.frame))];
        _marqueeLabel.font = [UIFont systemFontOfSize:_marqueeFont];
        _marqueeLabel.text = _content;
    }
    return _marqueeLabel;
}

-(UIView *)placeholderView
{
    if (!_placeholderView) {
        _placeholderView = [[UIView alloc] initWithFrame:CGRectMake(_contentWidth, 0, _placeholderWidth, CGRectGetHeight(self.frame))];
    }
    return _placeholderView;
}

-(UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(_contentWidth+_placeholderWidth, 0, _contentWidth, CGRectGetHeight(self.frame))];
        _placeholderLabel.font = [UIFont systemFontOfSize:_marqueeFont];
        _placeholderLabel.text = _content;
        if (_contentWidth <= CGRectGetWidth(self.frame)) {
            _placeholderLabel.hidden = YES;
        }
    }
    return _placeholderLabel;
}

-(CAKeyframeAnimation *)frameAnimation
{
    if (!_frameAnimation) {
        _frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        NSValue *value1 = [NSValue valueWithCGPoint:_marqueeView.center];
        NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(_marqueeView.center.x-_contentWidth-_placeholderWidth, _marqueeView.center.y)];
        _frameAnimation.values = @[value1,value2];
        _frameAnimation.fillMode = kCAFillModeForwards;
        _frameAnimation.removedOnCompletion = NO;
        _frameAnimation.delegate = self;
        /** 重复次数 default 1 */
        _frameAnimation.repeatCount = 1;
        /** 动画节奏控制 - Linear匀速 */
        _frameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        /** 动画时间 */
        _frameAnimation.duration = _duration;
    }
    return _frameAnimation;
}

- (void)propertySettings
{
    //字体颜色
    _marqueeLabel.textColor = _marqueeColor;
    _placeholderLabel.textColor = _marqueeColor;
    //字号
    _marqueeLabel.font = [UIFont systemFontOfSize:_marqueeFont];
    _placeholderLabel.font = [UIFont systemFontOfSize:_marqueeFont];
    //subviews调整
    CGSize contentSize = [_content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_marqueeFont]}];
    _contentWidth = contentSize.width;
    //marquee view
    CGRect subFrame = _marqueeView.frame;
    subFrame.size.width = _contentWidth*2+_placeholderWidth;
    _marqueeView.frame = subFrame;
    //main marquee label
    subFrame = _marqueeLabel.frame;
    subFrame.size.width = _contentWidth;
    _marqueeLabel.frame = subFrame;
    //placeholder width
    subFrame = _placeholderView.frame;
    subFrame.origin.x = _contentWidth;
    subFrame.size.width = _placeholderWidth;
    _placeholderView.frame = subFrame;
    //placeholder label
    subFrame = _placeholderLabel.frame;
    subFrame.origin.x = _contentWidth + _placeholderWidth;
    subFrame.size.width = _contentWidth;
    _placeholderLabel.frame = subFrame;
}

#pragma mark - Animate Control
-(void)startMarqueeAnimate
{
    if (_contentWidth <= CGRectGetWidth(self.frame)) {
        _placeholderLabel.hidden = YES;
        return;
    }
    _placeholderLabel.hidden = NO;
    [self stopMarqueeAnimate];
    [self propertySettings];
    [_marqueeView.layer addAnimation:self.frameAnimation forKey:MARQUEE_ANIMATE];
}

-(void)stopMarqueeAnimate
{
    [_marqueeView.layer removeAnimationForKey:MARQUEE_ANIMATE];
}

#pragma mark - Animate delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self startMarqueeAnimate];
        });
    }
}
@end

