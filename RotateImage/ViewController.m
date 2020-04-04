//
//  ViewController.m
//  RotateImage
//
//  Created by fish on 2019/1/14.
//  Copyright © 2019年 cloud. All rights reserved.
//

#import "ViewController.h"
#import "CGUtilities.h"
/*
 *  以iPhone6宽、高为标准的元单位
 */
#define kUnitWidth(width) (width*kScreenWidth/375)

#define kUnitHeight(height) (height*kScreenHeight/667)
@interface ViewController ()
@property(nonatomic,strong)UIImageView *backgroundImageView;
@property(nonatomic,strong)UIImageView *innercircleImageView;
@property(nonatomic,strong)UIImageView *circleImageView;
@property(nonatomic,strong)UIButton *stopButton;
@property(assign,nonatomic)double angle;
@property(nonatomic,assign)BOOL isStart;
@property(nonatomic,strong)CABasicAnimation*rotationAnimation;
@property(nonatomic,strong)CABasicAnimation*rotationAnimation0;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kUnitWidth(375), kUnitHeight(375))];
    self.backgroundImageView.image = [UIImage imageNamed:@"limit_face_background"];
    [self.view addSubview:self.backgroundImageView];
    
    self.innercircleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,64, kUnitWidth(375), kUnitHeight(375))];
    self.innercircleImageView.image = [UIImage imageNamed:@"limit_face_innercircle"];
    [self.view addSubview:self.innercircleImageView];
    
    self.circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kUnitWidth(375), kUnitHeight(375))];
    self.circleImageView.image = [UIImage imageNamed:@"limit_face_circle"];
    [self.view addSubview:self.circleImageView];
    
    self.stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.stopButton.frame = CGRectMake(20, CGRectGetMaxY(self.circleImageView.frame) + 20, self.view.bounds.size.width - 40, 30);
    [self.stopButton setTitle:@"停" forState:UIControlStateNormal];
    self.stopButton.backgroundColor = [UIColor greenColor];
    [self.stopButton addTarget:self action:@selector(stopAnimationClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.stopButton];
//    [self startAnimation];
//    [self startAnimation0];
//    [self startAnimation1];
    [self startAnimation2];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void) startAnimation{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.innercircleImageView.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
    self.circleImageView.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / -180.0f));
    [UIView commitAnimations];
}
-(void)startAnimation0
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.angle * (M_PI / -180.0f));
     CGAffineTransform endAngle0 = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.circleImageView.transform = endAngle;
        self.innercircleImageView.transform = endAngle0;
    } completion:^(BOOL finished) {
        self.angle += 10;
        [self startAnimation0];
    }];
}
-(void)startAnimation1{
    self.rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    self.rotationAnimation.duration = 1.5;
    self.rotationAnimation.cumulative = YES;
    self.rotationAnimation.repeatCount = MAXFLOAT;
    [self.innercircleImageView.layer addAnimation:self.rotationAnimation forKey:@"rotationAnimation"];
    
    self.rotationAnimation0 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.rotationAnimation0.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 ];
    self.rotationAnimation0.duration = 3;
    self.rotationAnimation0.cumulative = YES;
    self.rotationAnimation0.repeatCount = MAXFLOAT;
    [self.circleImageView.layer addAnimation:self.rotationAnimation0 forKey:@"rotationAnimation0"];
}
-(void)endAnimation
{
    self.angle += 10;
    [self startAnimation];
}
-(void)stopAnimationClick:(UIButton *)sender
{
    self.isStart = !self.isStart;
    if (!self.isStart) {
        [self.stopButton setTitle:@"停" forState:UIControlStateNormal];
        [self startAnimation1];
    }
    else
    {
        [self.stopButton setTitle:@"播放" forState:UIControlStateNormal];
        [self.innercircleImageView.layer removeAnimationForKey:@"rotationAnimation"];
        [self.circleImageView.layer removeAnimationForKey:@"rotationAnimation0"];
        // 动画移除后 保持在当前位置
        self.innercircleImageView.layer.transform = self.innercircleImageView.layer.presentationLayer.transform;
        self.circleImageView.layer.transform = self.circleImageView.layer.presentationLayer.transform;
    }
}
-(void)startAnimation2
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path, NULL, self.innercircleImageView.center.x, self.innercircleImageView.center.y, 1, 0,M_PI * 2, 0);
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path = path;
    
    CGPathRelease(path);
    
    animation.duration = 3;
    
    animation.repeatCount = 500;
    
    animation.autoreverses = NO;
    
    animation.rotationMode =kCAAnimationRotateAuto;
    
    animation.fillMode =kCAFillModeForwards;
    
    [self.innercircleImageView.layer addAnimation:animation forKey:@"animation"];
    
    CGMutablePathRef path0 = CGPathCreateMutable();
    
    CGPathAddArc(path0, NULL, self.circleImageView.center.x, self.circleImageView.center.y, 1, 0,M_PI * 2, 1);
    
    CAKeyframeAnimation * animation0 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation0.path = path0;
    
    CGPathRelease(path0);
    
    animation0.duration = 3;
    
    animation0.repeatCount = 500;
    
    animation0.autoreverses = NO;
    
    animation0.rotationMode =kCAAnimationRotateAuto;
    
    animation0.fillMode =kCAFillModeForwards;
    
    [self.circleImageView.layer addAnimation:animation0 forKey:@"animation0"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
