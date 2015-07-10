
#import <UIKit/UIKit.h>

@interface NSData (MBBase64)

+ (id)dataWithBase64EncodedString:(NSString *)string;     //  Padding '=' characters are optional. Whitespace is ignored.
- (NSString *)base64Encoding;
@end

@interface UIImage (ImageEffects)
/* 根据给的尺寸得到缩率图 */
- (UIImage*)thumbnailImage:(CGSize)targetSize;
/* 毛玻璃效果处理 */
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
/*
 * 图片转换为字符串
 */
+(NSString *) image2String:(UIImage *)image;
+(NSString *) image2String:(UIImage *)image andSize:(CGSize)size;

/*
 * 根据颜色生成图片
 */
+ (UIImage *)creatImageWithColor:(UIColor *)color andSize: (CGFloat) side;

+(NSData *)imageObjectToData:(UIImage *)image;

/*
 * 功能：存储图片到Documents\自己创建的文件夹名字
 *
 * 参数：
 * foldername  : 存储图片的文件夹名
 * fliename    : 存储图片的文件文字
 * data        : 存储的图片数据
 */
+ (BOOL)savePhotoFileToFolderWithFolderName:(NSString *)foldername
                                andFileName:(NSString *)filename
                                    andData:(NSData *)data;

/*
 * 功能：获取存储的图片
 *
 * 参数：
 * imageName  : 图片的名字
 * foldername : 存储图片的文件夹名
 */
+ (UIImage *)getImageFromSandboxWithImageName:(NSString *)imageName
                                fromDirectory:(NSString *)folderName;



/*
 * 功能：删除指定的图片
 *
 * 参数：
 * nameArray  : 即将删除的图片名字数组
 * foldername : 存储图片的文件夹名
 */
+(void)deleteImageFileWithNamesArray:(NSArray *)nameArray
                       fromDirectory:(NSString *)folderName;


/*
 * 功能：删除指定文件夹的所有图片
 *
 * 参数：
 * foldername : 存储图片的文件夹名
 */
+(void)deleteAllImageFileFromDirectory:(NSString *)folderName;


@end
