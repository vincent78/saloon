//
//  SNUIViewAnimationViewController.m
//  saloon
//
//  Created by vincent on 16/1/19.
//  Copyright © 2016年 fruit. All rights reserved.
//

#import "SNUIViewAnimationViewController.h"

@interface SNUIViewAnimationViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *moveImg;

@end

@implementation SNUIViewAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)moveAction:(id)sender {
    
    [UIView animateWithDuration:1.0f
                     animations:^{
                        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                        if (self.moveImg.ftLeft == 20)
                        {
                            self.moveImg.ftRight = [FTSystemHelper screenWidth] - 20;
                        }
                        else
                        {
                            self.moveImg.ftLeft = 20;
                        }
                        [self.view layoutIfNeeded];
    }
                     completion:^(BOOL finished) {
                        if (finished)
                        {
                            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                        }
    }];
}


@end
