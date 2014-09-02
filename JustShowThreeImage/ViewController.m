//
//  ViewController.m
//  JustShowThreeImage
//
//  Created by fei on 14-8-11.
//  Copyright (c) 2014年 self. All rights reserved.
//

#import "ViewController.h"
#import "CycleScrollView_Zooming.h"
@interface ViewController ()<CycleScrollView_ZoomingDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 8; i ++) {
        NSString *str = [NSString stringWithFormat:@"%d.png",i +1];
        [imageArray addObject:str];
    }
    CycleScrollView_Zooming *view = [[CycleScrollView_Zooming alloc] initWithFrame:CGRectMake(10, 60, 300, 400) imageArray:imageArray];
    view.delegate = self;
    view.zooming = YES;
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
}

-(void)cycleScrollView:(CycleScrollView_Zooming *)scrollView didSelectAtIndex:(NSInteger)index {
    NSLog(@"delegate  :%d",index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
