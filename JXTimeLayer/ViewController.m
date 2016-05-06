//
//  ViewController.m
//  JXTimeLayer
//
//  Created by yuezuo on 16/5/6.
//  Copyright © 2016年 yuezuo. All rights reserved.
//

#import "ViewController.h"

/** 控件宽度 */
#define width self.imageV.bounds.size.width
/** 控件高度 */
#define height self.imageV.bounds.size.height

/** 秒针旋转的当前角度 */
#define angleSec(a) ((a) / 180.0 * M_PI)
/** 秒针每秒旋转角度 */
#define anglePerSec 6

/** 分针每分旋转角度 */
#define anglePerMin 6

/** 时针每小时旋转角度 */
#define anglePerHou 30
/** 时针每分钟旋转角度 */
#define anglePerMinHour 0.5

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
/** 秒针 */
@property (nonatomic,strong) CALayer * secLayer;
/** 分针 */
@property (nonatomic,strong) CALayer * mintueLayer;
/** 时针 */
@property (nonatomic,strong) CALayer * hourLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHour];
    [self setupMin];
    [self setupSec];
    
    // 添加定时器，每秒循环一次
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChnage) userInfo:nil repeats:YES];
    
    // 主动调用一次作用是初始化位置
    [self timeChnage];
}

// 计算系统时间
- (void)timeChnage {
    // 日期计算
    // 获取当前日历对象
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    // 获取日期的组件：年月日小时分秒
    // components:需要获取的日期组件
    // fromDate：获取哪个日期的组件
    // 经验：以后枚举中有移位运算符，通常一般可以使用并运算（|）
    NSDateComponents * cmp = [calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    // 计算当前秒数
    NSInteger sec = cmp.second;
    // 秒针旋转角度
    CGFloat aSec = sec * anglePerSec;
    // 秒针动画
    self.secLayer.transform = CATransform3DMakeRotation(angleSec(aSec), 0, 0, 1);
    
    NSInteger min = cmp.minute;
    CGFloat aMin = min * anglePerMin;
    self.mintueLayer.transform = CATransform3DMakeRotation(angleSec(aMin), 0, 0, 1);
    
    NSInteger hour = cmp.hour;
    CGFloat aHor = hour * anglePerHou + min * anglePerMinHour;
    self.hourLayer.transform = CATransform3DMakeRotation(angleSec(aHor), 0, 0, 1);
}

// 创建秒针
- (void)setupSec {
    self.secLayer = [CALayer layer];
    self.secLayer.bounds = CGRectMake(0, 0, 2, width * 0.45);
    // 设置秒针相对于控件位置
    self.secLayer.position = CGPointMake(width * 0.5, height * 0.5);
    // 设置秒针锚点
    self.secLayer.anchorPoint = CGPointMake(0.5, 0.9);
    self.secLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.imageV.layer addSublayer:self.secLayer];
}

// 创建分针
- (void)setupMin {
    self.mintueLayer = [CALayer layer];
    // 分针的尺寸
    self.mintueLayer.bounds = CGRectMake(0, 0, 4, height * 0.4);
    // 分针相对于控件的位置
    self.mintueLayer.position = CGPointMake(width * 0.5, height * 0.5);
    // 分针的锚点
    self.mintueLayer.anchorPoint = CGPointMake(0.5, 0.9);
    self.mintueLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.imageV.layer addSublayer:self.mintueLayer];
}

// 创建时针
- (void)setupHour {
    self.hourLayer = [CALayer layer];
    // 尺寸
    self.hourLayer.bounds = CGRectMake(0, 0, 6, height * 0.3);
    // 位置
    self.hourLayer.position = CGPointMake(width * 0.5, height * 0.5);
    // 锚点
    self.hourLayer.anchorPoint = CGPointMake(0.5, 0.9);
    // 设置圆角
    self.hourLayer.cornerRadius = 3;
    // 背景色
    self.hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.imageV.layer addSublayer:self.hourLayer];
}
@end
