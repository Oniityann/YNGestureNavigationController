//
//  YNGesNavBar.m
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/9.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import "YNGesNavBar.h"
#import "Masonry.h"

#define kSelfWidth self.bounds.size.width
#define kSelfHeight self.bounds.size.height

@interface YNGesNavBar ()

@property (strong, nonatomic) UIView      *fakeStatusBar;
@property (strong, nonatomic) UIView      *contentView;

/** 右起第一个按钮 */
@property (strong, nonatomic) UIButton    *firstRightItem;
@property (strong, nonatomic) UIButton    *secondRightItem;

@property (strong, nonatomic) UILabel     *titleLabel;

@property (strong, nonatomic) UIImageView *contentBgImageView;

@property (assign, nonatomic) CGFloat contentViewCenterX;

@end

static const CGFloat kStatusBarHeight = 20.0f;
static const CGFloat kBorderMargin    = 10.0f;

@implementation YNGesNavBar

#pragma mark - initial

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initPrivate];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initPrivate];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initPrivate];
    }
    return self;
}

- (void)initPrivate {
    
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.98f];
    
    _fakeStatusBar = [[UIView alloc] init];
    _contentView   = [[UIView alloc] init];
    _contentBgImageView = [[UIImageView alloc] init];
    _titleLabel    = [[UILabel alloc] init];
    
    _titleLabel.font = [UIFont boldSystemFontOfSize:21];
    _contentBgImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview:self.contentBgImageView];
    [self addSubview:self.fakeStatusBar];
    [self addSubview:self.contentView];
    
    [_contentView addSubview:_titleLabel];
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.fakeStatusBar.frame = CGRectMake(0, 0, kSelfWidth, kStatusBarHeight);
    self.contentView.frame = CGRectMake(0, kStatusBarHeight, kSelfWidth, kSelfHeight - kStatusBarHeight);
    self.contentBgImageView.frame = self.bounds;
    
    self.titleView.frame = CGRectOffset(self.titleView.bounds, (self.contentView.bounds.size.width-self.titleView.bounds.size.width)/2, (self.contentView.bounds.size.height-self.titleView.bounds.size.height)/2);
    
    if (self.leftItem) {
        self.leftItem.center = CGPointMake(kBorderMargin + self.leftItem.bounds.size.width / 2, self.contentView.frame.size.height / 2);
    }
    
    if (self.firstRightItem) {
        self.firstRightItem.center = CGPointMake(kSelfWidth - kBorderMargin - self.firstRightItem.bounds.size.width/2, self.contentView.frame.size.height / 2);
    }
    
    if (self.secondRightItem) {
        self.secondRightItem.center= CGPointMake(kSelfWidth - 2 * kBorderMargin - self.firstRightItem.bounds.size.width - self.secondRightItem.bounds.size.width / 2, self.contentView.frame.size.height / 2);
    }
    
    [self.titleLabel sizeToFit];
    self.titleLabel.center = CGPointMake(self.contentView.bounds.size.width / 2, self.contentView.bounds.size.height / 2);
}

#pragma mark - setter

- (void)setTitle:(NSString *)title {
    
    if (self.titleView) {
        [self.titleView removeFromSuperview];
    }
    
    if (_title != title) {
        _title = [title copy];
    }
    
    self.titleLabel.text = self.title;
}

- (void)setTitleView:(UIView *)titleView {
    if (self.titleLabel) {
        [self.titleLabel removeFromSuperview];
    }
    
    if (_titleView != titleView) {
        _titleView = titleView;
    }
    
    [self.contentView addSubview:self.titleView];
}

- (void)setLeftItem:(UIButton *)leftItem {
    
    if (_leftItem != leftItem) {
        _leftItem = leftItem;
    }
    
    [self.contentView addSubview:self.leftItem];
}

- (void)setStatusBarBgColor:(UIColor *)statusBarBgColor {
    if (_statusBarBgColor != statusBarBgColor) {
        _statusBarBgColor = statusBarBgColor;
    }
    
    self.fakeStatusBar.backgroundColor = self.statusBarBgColor;
}

- (void)setNavContentColor:(UIColor *)navContentColor {
    if (_navContentColor != navContentColor) {
        _navContentColor = navContentColor;
    }
    
    self.contentView.backgroundColor = self.navContentColor;
}

- (void)setNavBgColor:(UIColor *)navBgColor {
    if (_navBgColor != navBgColor) {
        _navBgColor = navBgColor;
    }
    
    self.fakeStatusBar.backgroundColor = self.navBgColor;
    self.contentView.backgroundColor = self.navBgColor;
    self.backgroundColor = self.navBgColor;
}

- (void)setNavBgImage:(UIImage *)navBgImage {
    if (_navBgImage != navBgImage) {
        _navBgImage = navBgImage;
    }
    
    self.fakeStatusBar.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentBgImageView.image = self.navBgImage;
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
    }
    
    self.titleLabel.textColor = titleColor;
}

- (void)setRightItems:(NSMutableArray *)rightItems {
    if (_rightItems != rightItems) {
        _rightItems = rightItems;
    }
    
    switch (self.rightItems.count) {
        case 0:
            break;
            
        case 1:
        {
            if (_firstRightItem) {
                [_firstRightItem removeFromSuperview];
                _firstRightItem = nil;
            }
            
            self.firstRightItem = [self.rightItems firstObject];
            [self.contentView addSubview:self.firstRightItem];
        }
            break;
            
        case 2:
        {
            if (_firstRightItem) {
                [_firstRightItem removeFromSuperview];
                _firstRightItem = nil;
            }
            
            if (_secondRightItem) {
                [_secondRightItem removeFromSuperview];
                _secondRightItem = nil;
            }
            
            self.firstRightItem  = [self.rightItems firstObject];
            self.secondRightItem = [self.rightItems lastObject];
            [self.contentView addSubview:self.firstRightItem];
            [self.contentView addSubview:self.secondRightItem];
        }
            break;
            
        default:
            break;
    }
    
    if (self.rightItems.count > 2) {
        @throw [NSException exceptionWithName:@"Count of the right side items beyond bounds"
                                       reason:@"beyond 2"
                                     userInfo:nil];
    }
}

@end
