//
//  QYViewController.m
//  AlbumDemo
//
//  Created by qingyun on 15-4-8.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewController.h"
#import "QYScrollView.h"

#define kWidth      self.view.bounds.size.width
#define kHeight     self.view.bounds.size.height
#define kImageNum   3
#define kBaseTag    100
//#define NSUD   [NSUserDefaults standardUserDefaults]


static NSInteger preTag = kBaseTag;

@interface QYViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置scrollView
    [self setupScrollView];
    
}
- (void)setupScrollView
{
    _scrollView.contentSize = CGSizeMake(kWidth*kImageNum, kHeight);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.directionalLockEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubViews2ScrollView];
}

- (void)addSubViews2ScrollView
{
    for (int i = 0; i < kImageNum; i++) {
        QYScrollView *imgScrollView = [[QYScrollView alloc] initWithFrame:CGRectMake(kWidth*i, 0, kWidth, kHeight)];
        NSString *imgName = [NSString stringWithFormat:@"new_feature_%d", i+1];
        imgScrollView.imageView.image = [UIImage imageNamed:imgName];
        imgScrollView.tag = kBaseTag+i;
        [_scrollView addSubview:imgScrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentTag = self.scrollView.contentOffset.x / kWidth + kBaseTag;
    QYScrollView *preScrollView = (QYScrollView *)[_scrollView viewWithTag:preTag];
    if (currentTag != preTag) {
        if (preScrollView.zoomScale != 1.0) {
            preScrollView.zoomScale = 1.0;
        }
    }
    preTag = currentTag;
}

@end
