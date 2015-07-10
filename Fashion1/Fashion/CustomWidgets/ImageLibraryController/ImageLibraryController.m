//
//  ImageLibraryController.m
//  LoveHome
//
//  Created by MRH-MAC on 14/12/4.
//  Copyright (c) 2014年 卡莱博尔. All rights reserved.
//

#import "ImageLibraryController.h"
#import "CustomClipImageViewController.h"

@interface ImageLibraryController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,CustomClipImageViewControllerDelegate>
@property (nonatomic, assign) NSInteger pickerSourceType;
@property (nonatomic, assign) CGFloat heightScale;
@end

@implementation ImageLibraryController



- (id)initWithPickerType:(NSInteger )sourceType andScale:(CGFloat )scale;
{
    self = [super init];
    if (self) {
        self.pickerSourceType = sourceType;
        if (scale > 1 || scale == 0) {
            scale = 1;
        }
        
        _heightScale = scale;
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.delegate                     = self;
    self.sourceType                   = _pickerSourceType;


}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    if (!image)
    {
        return;
    }

    CustomClipImageViewController *controller = [[CustomClipImageViewController alloc] initWithImage:image andScale:_heightScale];
    controller.delegate = self;
    [picker pushViewController:controller animated:YES];
    
    //写入沙盒
    //    BOOL tyre = [[NSFileManager defaultManager] fileExistsAtPath:HeaderPath];
//    [data writeToFile:HeaderPath atomically:NO];
    
    
}


- (void)imageCropViewControllerDidCancelCrop:(CustomClipImageViewController *)controller
{
    [controller.navigationController popViewControllerAnimated:YES];

}

- (void)imageCropViewController:(CustomClipImageViewController *)controller didCropImage:(UIImage *)croppedImage
{
    if (croppedImage) {
        
        if (_imageBlock) {
            
            self.imageBlock(croppedImage);
        }
        

    }
    [controller.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
