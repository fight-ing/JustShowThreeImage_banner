//
//  CycleScrollView_Zooming.m
//  JustShowThreeImage
//
//  Created by fei on 14-8-11.
//  Copyright (c) 2014年 self. All rights reserved.
//

#import "CycleScrollView_Zooming.h"

@implementation CycleScrollView_Zooming

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _zooming = NO;
        totalImageArray = [[NSMutableArray alloc] initWithArray:imageArray];
        currentImageArray = [[NSMutableArray alloc] initWithCapacity:0];
        totalIndex = imageArray.count;
        currentImageIndex = 1;
        t_imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        t_imageScrollView.delegate = self;
        t_imageScrollView.pagingEnabled = YES;
        t_imageScrollView.showsHorizontalScrollIndicator = NO;
        t_imageScrollView.showsVerticalScrollIndicator = NO;
        t_imageScrollView.contentSize = CGSizeMake(frame.size.width*3, frame.size.height);
        t_pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-40, frame.size.width, 30)];
        t_pageControl.numberOfPages = imageArray.count;
        t_pageControl.currentPage = currentImageIndex-1;
        [t_pageControl setCurrentPageIndicatorTintColor:[UIColor darkGrayColor]];
        [t_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        [self addSubview:t_imageScrollView];
        [self addSubview:t_pageControl];
        [self refreshScrollViewItems];
    }
    return self;
    
}

-(void)refreshScrollViewItems {
    NSArray *subViewsArray = [t_imageScrollView subviews];
    if (subViewsArray.count != 0) {
        [subViewsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    t_pageControl.currentPage = currentImageIndex - 1;
    [self getCurrentImageArrayWithCurrentIndex:currentImageIndex];
    for (int i = 0; i < currentImageArray.count; i ++) {
        UIScrollView *justScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(t_imageScrollView.frame.size.width*i, 0, t_imageScrollView.frame.size.width, t_imageScrollView.frame.size.height)];
        justScrollView.contentSize = CGSizeMake(t_imageScrollView.frame.size.width, t_imageScrollView.frame.size.height);
        justScrollView.delegate = self;
        justScrollView.maximumZoomScale = 3.0;
        justScrollView.minimumZoomScale = 1.0;
        justScrollView.zoomScale = 1.0;
        justScrollView.tag = 500+i;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, justScrollView.frame.size.width, justScrollView.frame.size.height)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 200 + i;
        imageView.image = [UIImage imageNamed:[currentImageArray objectAtIndex:i]];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [justScrollView addGestureRecognizer:tapGes];
        
        justScrollView.backgroundColor = [UIColor redColor];
        imageView.backgroundColor = [UIColor greenColor];
        
        [justScrollView addSubview:imageView];
        [t_imageScrollView addSubview:justScrollView];
    }
    [t_imageScrollView setContentOffset:CGPointMake(t_imageScrollView.frame.size.width, 0)];
    
}

-(void)getCurrentImageArrayWithCurrentIndex:(NSInteger)index {
    int pre = [self validIndexValueFrom:currentImageIndex-1];
    int nex = [self validIndexValueFrom:currentImageIndex+1];
    if (currentImageArray.count != 0) {
        [currentImageArray removeAllObjects];
    }
    [currentImageArray addObject:[totalImageArray objectAtIndex:pre-1]];
    [currentImageArray addObject:[totalImageArray objectAtIndex:currentImageIndex-1]];
    [currentImageArray addObject:[totalImageArray objectAtIndex:nex-1]];
    
}
-(int)validIndexValueFrom:(int)index {
    if (index == 0) index = totalIndex;
    if (index == totalIndex+1) index = 1;
    return index;
}

#pragma scrollView delegaate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:t_imageScrollView]) {
        
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView  {
    int x=t_imageScrollView.contentOffset.x;
    if(x>=2*t_imageScrollView.frame.size.width) //往下翻一张
    {
        currentImageIndex = [self validIndexValueFrom:currentImageIndex+1];
        [self refreshScrollViewItems];
    }
    
    if(x<=0)
    {
        currentImageIndex = [self validIndexValueFrom:currentImageIndex-1];
        [self refreshScrollViewItems];
    }

}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (_zooming) {
        if (scrollView.tag >= 500) {
            for (UIView *sView in [scrollView subviews]) {
                return sView;
            }
        }
    }
    return nil;
}

-(void)tapGesture:(UITapGestureRecognizer *)tap {
    
    UIScrollView  *scroll = (UIScrollView *)tap.view;
    if (scroll.zoomScale != 1) {
        [UIView animateWithDuration:scroll.zoomScale*0.1 animations:^{
            scroll.zoomScale = 1;
        } completion:^(BOOL isFinish){
            
        }];
        
    } else {
        if ([_delegate respondsToSelector:@selector(cycleScrollView:didSelectAtIndex:)]) {
            [_delegate cycleScrollView:self didSelectAtIndex:currentImageIndex-1];
        }
        NSLog(@"tap at index :%d",currentImageIndex);
    }
}

@end
