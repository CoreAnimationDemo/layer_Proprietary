//
//  ViewController.m
//  Layer_Proprietary
//
//  Created by 汤清欢 on 2017/5/18.
//  Copyright © 2017年 Hanlan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self shapeLayer];
    [self grandientLayer];
    [self emitterLayer];
    [self replicatorLayer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)shapeLayer{
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    path.lineWidth = 3;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    CGPoint center = self.view.center;
    CGPoint pointA = CGPointMake(center.x - 60, center.y - 15);
    CGPoint arcPointA = CGPointMake(pointA.x - 30, pointA.y);
    [path moveToPoint:pointA];
    [path addArcWithCenter:arcPointA radius:30 startAngle:0 endAngle:M_PI * 2 clockwise:YES];

    CGPoint linePointA = CGPointMake(center.x + 60, arcPointA.y);
    [path addLineToPoint:linePointA];
    CGPoint pointB = CGPointMake(linePointA.x + 60, linePointA.y);
    [path moveToPoint:pointB];
    
    CGPoint arcPointB = CGPointMake(linePointA.x + 30, linePointA.y);
    [path addArcWithCenter:arcPointB radius:30 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
}
- (void)grandientLayer{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = @[(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
    layer.locations = @[@0.0,@0.25,@0.5];
//    layer.startPoint = CGPointMake(0, 0);
//    layer.endPoint = CGPointMake(1, 1);
    layer.startPoint = CGPointMake(1, 0);
    layer.endPoint = CGPointMake(0, 1);
    layer.frame = CGRectMake(0, 0, 150, 150);
    [self.view.layer addSublayer:layer];
}

- (void)emitterLayer{
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    layer.frame = CGRectMake(250, 64, 20, 20);
    [self.view.layer addSublayer:layer];
    layer.scale = [UIScreen mainScreen].scale;
    layer.renderMode = kCAEmitterLayerAdditive;
    layer.emitterPosition = CGPointMake(layer.frame.size.width / 2, layer.frame.size.height / 2);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc]init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"green_icon"].CGImage;
    cell.color = [UIColor greenColor].CGColor;
    cell.birthRate = 100;
    cell.lifetime = 5;
    cell.alphaSpeed = -0.4;
    cell.velocity = 30;
    cell.velocityRange = 30;
    cell.emissionRange = M_PI * 2;
    
    layer.emitterCells = @[cell];
}

- (void)replicatorLayer{
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.frame = CGRectMake(10, 360, 355, 150);
    [self.view.layer addSublayer:layer];
    layer.instanceCount = 2;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fengjing" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    CALayer *imageLayer = [CALayer layer];
    imageLayer.contents = (__bridge id)image.CGImage;
    imageLayer.contentsScale = [UIScreen mainScreen].scale;
    imageLayer.frame = CGRectMake(0, 0, 355, 150);
    [layer addSublayer:imageLayer];
    
    CATransform3D transform = CATransform3DTranslate(CATransform3DIdentity, 0, 152, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform = transform;
    layer.instanceAlphaOffset = -0.6;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
