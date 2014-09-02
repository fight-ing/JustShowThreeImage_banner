//
//  CycleScrollView_Zooming.h
//  JustShowThreeImage
//
//  Created by fei on 14-8-11.
//  Copyright (c) 2014年 self. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CycleScrollView_ZoomingDelegate;
@interface CycleScrollView_Zooming : UIView <UIScrollViewDelegate>
{
    UIScrollView *t_imageScrollView;
    NSMutableArray *totalImageArray;
    NSMutableArray *currentImageArray;
    int currentImageIndex;
    int totalIndex;
    float offset_zoom;
    UIPageControl *t_pageControl;
}
-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

@property (nonatomic,assign) id <CycleScrollView_ZoomingDelegate> delegate;
@property (nonatomic,assign) BOOL zooming;
@end

@protocol CycleScrollView_ZoomingDelegate <NSObject>

-(void)cycleScrollView:(CycleScrollView_Zooming *)scrollView didSelectAtIndex:(NSInteger)index;

@end
