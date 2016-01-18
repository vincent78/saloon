//
//  SNCycleAnimationViewController.m
//  saloon
//
//  Created by vincent on 16/1/14.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNCycleAnimationViewController.h"

@interface SNCycleAnimationViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *circleImg;

@end

@implementation SNCycleAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)circleAction:(id)sender {
    CABasicAnimation * swapAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    swapAnimation.duration = 0.5;
    swapAnimation.removedOnCompletion = YES;
    swapAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    swapAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    [self.circleImg.layer addAnimation:swapAnimation forKey:@"transform.rotation"];
}

@end
