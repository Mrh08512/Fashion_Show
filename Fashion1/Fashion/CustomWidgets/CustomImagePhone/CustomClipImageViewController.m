//
// CutomImageCupViewController.h
//
// Copyright (c) 2014 Ruslan
//

//

#import "CustomClipImageViewController.h"
#import "CustomTouchView.h"
#import "CustomImageScrollView.h"
#import "UIImage+FixOrientation.h"

static const CGFloat kPortraitMaskRectInnerEdgeInset = 0.0f;
static const CGFloat kLandscapeMaskRectInnerEdgeInset = 45.0f;


@interface CustomClipImageViewController ()

@property (strong, nonatomic) UIColor *originalNavigationControllerViewBackgroundColor;
@property (assign, nonatomic) BOOL originalNavigationControllerNavigationBarHidden;
@property (assign, nonatomic) BOOL originalStatusBarHidden;
@property (assign, nonatomic) CGFloat heightSacale;
@property (strong, nonatomic) CustomImageScrollView *imageScrollView;
@property (strong, nonatomic) CustomTouchView *overlayView;
@property (strong, nonatomic) UIView *toolView;
@property (strong, nonatomic) CAShapeLayer *maskLayer;
@property (strong, nonatomic) UILabel *moveAndScaleLabel;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *chooseButton;
@property (strong, nonatomic) UITapGestureRecognizer *doubleTapGestureRecognizer;

@property (assign, nonatomic) BOOL didSetupConstraints;


@end

@implementation CustomClipImageViewController

#pragma mark - Lifecycle

- (instancetype)initWithImage:(UIImage *)originalImage
{
    self = [super init];
    if (self) {
        _originalImage = originalImage;
        _heightSacale = 0.618;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)originalImage andScale:(CGFloat)heightScale
{
    self = [super init];
    if (self) {
        _originalImage = originalImage;
        _heightSacale = heightScale;
        if (_heightSacale > 1) {
            _heightSacale = 1;
        }
    }
    return self;

}

- (void)loadView
{
    [super loadView];
    self.view.frame = [UIScreen mainScreen].bounds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    self.view.clipsToBounds = YES;
    
    self.originalStatusBarHidden = [UIApplication sharedApplication].statusBarHidden;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.originalNavigationControllerNavigationBarHidden = self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self.view addSubview:self.imageScrollView];
    [self.view addSubview:self.overlayView];
    [self.view addSubview:self.moveAndScaleLabel];
    [self.view addSubview:self.toolView];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.chooseButton];
    


//    [self.view addGestureRecognizer:self.doubleTapGestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.originalNavigationControllerViewBackgroundColor = self.navigationController.view.backgroundColor;
    self.navigationController.view.backgroundColor = [UIColor blackColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//
    [[UIApplication sharedApplication] setStatusBarHidden:self.originalStatusBarHidden];
    [self.navigationController setNavigationBarHidden:self.originalNavigationControllerNavigationBarHidden animated:animated];
    self.navigationController.view.backgroundColor = self.originalNavigationControllerViewBackgroundColor;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self layoutImageScrollView];
    [self layoutOverlayView];
    [self updateMaskPath];
    [self.view setNeedsUpdateConstraints];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (!self.imageScrollView.zoomView) {
        [self displayImage];
    }
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
//    self.cancelButton
//    self.chooseButton
    
    
    
    NSMutableArray *contrains = [[NSMutableArray alloc] init];
    
    
     [contrains addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_toolView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolView)]];
    [contrains addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_toolView(80)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_toolView)]];
    
    
    
    
    [contrains addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_cancelButton(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cancelButton)]];
    
     [contrains addObjectsFromArray: [NSLayoutConstraint constraintsWithVisualFormat:@"[_chooseButton(100)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_chooseButton)]];
    
    [contrains addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_cancelButton(30)]-25-|"  options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cancelButton)]];
    
     [contrains addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_chooseButton(30)]-25-|"  options:0 metrics:nil views:NSDictionaryOfVariableBindings(_chooseButton)]];
   
   
    [self.view addConstraints:contrains];
}

#pragma mark - Custom Accessors

- (CustomImageScrollView *)imageScrollView
{
    if (!_imageScrollView) {
        _imageScrollView = [[CustomImageScrollView alloc] init];
        _imageScrollView.clipsToBounds = NO;
    }
    return _imageScrollView;
}

- (CustomTouchView *)overlayView
{
    if (!_overlayView) {
        _overlayView = [[CustomTouchView alloc] init];
        _overlayView.receiver = self.imageScrollView;
        [_overlayView.layer addSublayer:self.maskLayer];
    }
    return _overlayView;
}

- (CAShapeLayer *)maskLayer
{
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.fillRule = kCAFillRuleEvenOdd;
        _maskLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor;
    }
    return _maskLayer;
}

- (UILabel *)moveAndScaleLabel
{
    if (!_moveAndScaleLabel) {
        _moveAndScaleLabel = [[UILabel alloc] init];
        _moveAndScaleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _moveAndScaleLabel.backgroundColor = [UIColor clearColor];
        _moveAndScaleLabel.textColor = [UIColor whiteColor];
        _moveAndScaleLabel.opaque = NO;
    }
    return _moveAndScaleLabel;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        _cancelButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];

        _cancelButton.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
        [_cancelButton setTitle:@"取  消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(onCancelButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.opaque = NO;
    }
    return _cancelButton;
}

- (UIButton *)chooseButton
{
    if (!_chooseButton) {
        _chooseButton = [[UIButton alloc] init];
        _chooseButton.translatesAutoresizingMaskIntoConstraints = NO;
        _chooseButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        [_chooseButton setTitle:@"选  择" forState:UIControlStateNormal];

        _chooseButton.titleEdgeInsets = UIEdgeInsetsMake(0, 35, 0, 0);
        [_chooseButton addTarget:self action:@selector(onChooseButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        _chooseButton.opaque = NO;
    }
    return _chooseButton;
}


- (UIView *)toolView
{
    if (!_toolView) {
        _toolView = [[UIView alloc] init];
        _toolView.translatesAutoresizingMaskIntoConstraints = NO;
        _toolView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        _toolView.opaque = NO;
    }
    return _toolView;
}

- (UITapGestureRecognizer *)doubleTapGestureRecognizer
{
    if (!_doubleTapGestureRecognizer) {
        _doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _doubleTapGestureRecognizer.delaysTouchesEnded = NO;
        _doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    }
    return _doubleTapGestureRecognizer;
}

#pragma mark - Action handling

- (void)onCancelButtonTouch:(UIButton *)sender
{
    [self cancelCrop];
}

- (void)onChooseButtonTouch:(UIButton *)sender
{
    [self cropImage];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    [self resetZoomScale:YES];
    [self resetContentOffset:YES];
}

#pragma mark - Private

- (void)resetZoomScale:(BOOL)animated
{
    CGFloat zoomScale;
    if (CGRectGetWidth(self.view.bounds) > CGRectGetHeight(self.view.bounds)) {
        zoomScale = CGRectGetHeight(self.view.bounds) / self.originalImage.size.height;
    } else {
        zoomScale = CGRectGetWidth(self.view.bounds) / self.originalImage.size.width;
    }
    [self.imageScrollView setZoomScale:zoomScale animated:animated];
}

- (void)resetContentOffset:(BOOL)animated
{
    CGSize boundsSize = self.imageScrollView.bounds.size;
    CGRect frameToCenter = self.imageScrollView.zoomView.frame;
    CGPoint contentOffset = self.imageScrollView.contentOffset;
    contentOffset.x = (frameToCenter.size.width - boundsSize.width) / 2.0;
    contentOffset.y = (frameToCenter.size.height - boundsSize.height) / 2.0;
    [self.imageScrollView setContentOffset:contentOffset animated:animated];
}

- (void)displayImage
{
    if (self.originalImage) {
        [self.imageScrollView displayImage:self.originalImage];
        [self resetZoomScale:NO];
    }
}

- (void)layoutImageScrollView
{
    self.imageScrollView.frame = [self maskRect];
}

- (void)layoutOverlayView
{
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) * 2, CGRectGetHeight(self.view.bounds) * 2);

    self.overlayView.frame = frame;
}

- (void)updateMaskPath
{
    CGRect frameRect = CGRectMake(self.overlayView.frame.origin.x - 1, self.overlayView.frame.origin.y - 2, self.overlayView.bounds.size.width , self.overlayView.bounds.size.width);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRect:frameRect];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:[self maskRect]];
    
    [clipPath appendPath:maskPath];
    clipPath.usesEvenOddFillRule = YES;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = [CATransaction animationDuration];
    pathAnimation.timingFunction = [CATransaction animationTimingFunction];
    [self.maskLayer addAnimation:pathAnimation forKey:@"path"];
    
    self.maskLayer.path = [clipPath CGPath];
    self.maskLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.maskLayer.borderWidth = 0.1;
}

- (CGRect)maskRect
{
    CGRect bounds = self.view.bounds;
    
    CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    
    CGFloat diameter;
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        diameter = MIN(width, height) - kPortraitMaskRectInnerEdgeInset * 2;
    } else {
        diameter = MIN(width, height) - kLandscapeMaskRectInnerEdgeInset * 2;
    }
    
    CGFloat radius = diameter / 2;
    CGPoint center = CGPointMake(width / 2, height / 2);
    
    CGRect maskRect = CGRectMake(center.x - radius, center.y - (diameter * _heightSacale / 2), diameter, diameter * _heightSacale);

    

    return maskRect;
}

- (CGRect)cropRect
{
    CGRect cropRect = CGRectZero;
    float zoomScale = 1.0 / self.imageScrollView.zoomScale;
    
    cropRect.origin.x = self.imageScrollView.contentOffset.x * zoomScale;
    cropRect.origin.y = self.imageScrollView.contentOffset.y * zoomScale;
    cropRect.size.width = CGRectGetWidth(self.imageScrollView.bounds) * zoomScale;
    cropRect.size.height = CGRectGetHeight(self.imageScrollView.bounds) * zoomScale;
    
    CGSize imageSize = self.originalImage.size;
    CGFloat x = CGRectGetMinX(cropRect);
    CGFloat y = CGRectGetMinY(cropRect);
    CGFloat width = CGRectGetWidth(cropRect);
    CGFloat height = CGRectGetHeight(cropRect);
    
    UIImageOrientation imageOrientation = self.originalImage.imageOrientation;
    if (imageOrientation == UIImageOrientationRight || imageOrientation == UIImageOrientationRightMirrored) {
        cropRect.origin.x = y;
        cropRect.origin.y = imageSize.width - CGRectGetWidth(cropRect) - x;
        cropRect.size.width = height;
        cropRect.size.height = width;
    } else if (imageOrientation == UIImageOrientationLeft || imageOrientation == UIImageOrientationLeftMirrored) {
        cropRect.origin.x = imageSize.height - CGRectGetHeight(cropRect) - y;
        cropRect.origin.y = x;
        cropRect.size.width = height;
        cropRect.size.height = width;
    } else if (imageOrientation == UIImageOrientationDown || imageOrientation == UIImageOrientationDownMirrored) {
        cropRect.origin.x = imageSize.width - CGRectGetWidth(cropRect) - x;;
        cropRect.origin.y = imageSize.height - CGRectGetHeight(cropRect) - y;
    }
    
    return cropRect;
}

- (UIImage *)croppedImage:(UIImage *)image cropRect:(CGRect)cropRect
{
    CGImageRef croppedCGImage = CGImageCreateWithImageInRect(image.CGImage, cropRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:croppedCGImage scale:1.0f orientation:image.imageOrientation];
    CGImageRelease(croppedCGImage);
    return [croppedImage fixOrientation];
    return nil;
}

- (void)cropImage
{
    
     __weak CustomClipImageViewController * myself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *croppedImage = [self croppedImage:self.originalImage cropRect:[self cropRect]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([myself.delegate respondsToSelector:@selector(imageCropViewController:didCropImage:)]) {
                [myself.delegate imageCropViewController:self didCropImage:croppedImage];
               
            }
        });
    });
   
}

- (void)cancelCrop
{
    if ([self.delegate respondsToSelector:@selector(imageCropViewControllerDidCancelCrop:)]) {
        [self.delegate imageCropViewControllerDidCancelCrop:self];
       
    }
}

@end
