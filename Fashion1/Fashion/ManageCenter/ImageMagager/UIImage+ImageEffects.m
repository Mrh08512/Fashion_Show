
#import "UIImage+ImageEffects.h"
#import "NSString+StringManage.h"
#import <Accelerate/Accelerate.h>
#import <float.h>

#define JoeChenDocumentsHomePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define JoeChenLibraryHomePath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]



static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSData (MBBase64)

+ (id)dataWithBase64EncodedString:(NSString *)string;
{
	if (string == nil)
		[NSException raise:NSInvalidArgumentException format:@""];
	if ([string length] == 0)
		return [NSData data];
	
	static char *decodingTable = NULL;
	if (decodingTable == NULL)
	{
		decodingTable = malloc(256);
		if (decodingTable == NULL)
			return nil;
		memset(decodingTable, CHAR_MAX, 256);
		NSUInteger i;
		for (i = 0; i < 64; i++)
			decodingTable[(short)encodingTable[i]] = i;
	}
	
	const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
	if (characters == NULL)     //  Not an ASCII string!
		return nil;
	char *bytes = malloc((([string length] + 3) / 4) * 3);
	if (bytes == NULL)
		return nil;
	NSUInteger length = 0;
	
	NSUInteger i = 0;
	while (YES)
	{
		char buffer[4];
		short bufferLength;
		for (bufferLength = 0; bufferLength < 4; i++)
		{
			if (characters[i] == '\0')
				break;
			if (isspace(characters[i]) || characters[i] == '=')
				continue;
			buffer[bufferLength] = decodingTable[(short)characters[i]];
			if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
			{
				free(bytes);
				return nil;
			}
		}
		
		if (bufferLength == 0)
			break;
		if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
		{
			free(bytes);
			return nil;
		}
		
		//  Decode the characters in the buffer to bytes.
		bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
		if (bufferLength > 2)
			bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
		if (bufferLength > 3)
			bytes[length++] = (buffer[2] << 6) | buffer[3];
	}
	
	realloc(bytes, length);
	return [NSData dataWithBytesNoCopy:bytes length:length];
}

- (NSString *)base64Encoding;
{
	if ([self length] == 0)
		return @"";
	
    char *characters = malloc((([self length] + 2) / 3) * 4);
	if (characters == NULL)
		return nil;
	NSUInteger length = 0;
	
	NSUInteger i = 0;
	while (i < [self length])
	{
		char buffer[3] = {0,0,0};
		short bufferLength = 0;
		while (bufferLength < 3 && i < [self length])
			buffer[bufferLength++] = ((char *)[self bytes])[i++];
		
		//  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
		characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
		characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
		if (bufferLength > 1)
			characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
		else characters[length++] = '=';
		if (bufferLength > 2)
			characters[length++] = encodingTable[buffer[2] & 0x3F];
		else characters[length++] = '=';
	}
	
	return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end


@implementation UIImage (ImageEffects)

- (UIImage*)thumbnailImage:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width * screenScale;
    CGFloat targetHeight = targetSize.height * screenScale;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight)); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)applyLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyExtraLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyDarkEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor
{
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    int componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}


- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage{
    if (self.size.width < 1 || self.size.height < 1) {
//        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
//        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
//        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}


+(UIImage *)scaleImage:(UIImage *)image toWidth:(int)toWidth toHeight:(int)toHeight{
	int width=0;
	int height=0;
	int x=0;
	int y=0;
	
	if (image.size.width<toWidth){
	    width = toWidth;
		height = image.size.height*(toWidth/image.size.width);
		y = (height - toHeight)/2;
	}else if (image.size.height<toHeight){
		height = toHeight;
		width = image.size.width*(toHeight/image.size.height);
		x = (width - toWidth)/2;
	}else if (image.size.width>toWidth){
	    width = toWidth;
		height = image.size.height*(toWidth/image.size.width);
		y = (height - toHeight)/2;
	}else if (image.size.height>toHeight){
		height = toHeight;
		width = image.size.width*(toHeight/image.size.height);
		x = (width - toWidth)/2;
	}else{
		height = toHeight;
		width = toWidth;
	}
	
	CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	CGSize subImageSize = CGSizeMake(toWidth, toHeight);
    CGRect subImageRect = CGRectMake(x, y, toWidth, toHeight);
    CGImageRef imageRef = image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
    UIGraphicsBeginImageContext(subImageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, subImageRect, subImageRef);
    UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
	CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
	return subImage;
}

+(NSData *)imageObjectToData:(UIImage *)image
{
    float o = 0.8;
	if (!image)
    {//如果没有图则不操作
		return nil;
	}
    //	image = [self scaleImage:image toWidth:image.size.width/3 toHeight:image.size.height/3];
    image = [self scaleImage:image toWidth:640.0f toHeight:960.0f];
	
	NSData* pictureData = UIImageJPEGRepresentation(image,o);
	
	return pictureData;
}

+(NSString *)image2String:(UIImage *)image
{
    float o = 0.5;
	if (!image)
    {
        //如果没有图则不操作
		return @"";
	}
//    image = [self scaleImage:image toWidth:image.size.width/3 toHeight:image.size.height/3];
//    image = [self scaleImage:image toWidth:640.0f toHeight:960.0f];
	
	NSData   *pictureData       = UIImageJPEGRepresentation(image,o);
	NSString *pictureDataString = [pictureData base64Encoding];
	
	return pictureDataString;
}


+(NSString *) image2String:(UIImage *)image andSize:(CGSize)size
{
	
    float o = 0.5;
	if (!image)
    {//如果没有图则不操作
        
		return @"";
	}
//    image = [self scaleImage:image toWidth:image.size.width/3 toHeight:image.size.height/3];
//    image = [self scaleImage:image toWidth:size.width toHeight:size.height];
	
	NSData* pictureData = UIImageJPEGRepresentation(image,o);
	NSString* pictureDataString = [pictureData base64Encoding];
	
	return pictureDataString;
}

/*
 * 根据颜色生成图片
 */
+ (UIImage *)creatImageWithColor:(UIColor *)color andSize: (CGFloat) side
{
    UIGraphicsBeginImageContext(CGSizeMake(side, side));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, side, side));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


//判断文件是否存在
+ (BOOL)isExistsFile:(NSString *)fileName withDirectoryName:(NSString *)foldername
{
    NSFileManager   *fileManager = [NSFileManager defaultManager];
    NSString        *filePath    = [[JoeChenDocumentsHomePath stringByAppendingPathComponent:foldername] stringByAppendingPathComponent:fileName];
    return [fileManager fileExistsAtPath:filePath];
}



/*
 * 功能：存储图片到Documents\自己创建的文件夹名字
 *
 * 参数：
 * foldername  : 存储图片的文件夹名
 * fliename    : 存储图片的文件文字
 * image       : 存储的图片对象
 */
+ (BOOL)savePhotoFileToFolderWithFolderName:(NSString *)foldername
                                andFileName:(NSString *)filename
                                    andData:(NSData *)data
{
    if (!foldername || !filename || !data)
    {
        return NO;
    }
    
    
    // 判断存放图片的文件夹是否存在，不存在则创建对应文件夹
    NSFileManager *fileManager      = [NSFileManager defaultManager];
    NSString      *directoryPath    = [JoeChenDocumentsHomePath stringByAppendingPathComponent:foldername];
    NSString      *imageFilePath    = [directoryPath stringByAppendingPathComponent:filename];
    
    BOOL isDir = FALSE;
    
    BOOL isDirExist = [fileManager fileExistsAtPath:directoryPath
                                        isDirectory:&isDir];
    if(!(isDirExist && isDir))
        
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:directoryPath
                                 withIntermediateDirectories:YES
                                                  attributes:nil
                                                       error:nil];
        if(!bCreateDir)
        {
        }
        
    }
    
    
    //判断即将存储的文件是否存在
    BOOL isPicFileExist = [UIImage isExistsFile:filename withDirectoryName:foldername];
    if (!isPicFileExist)
    {
        BOOL isSucceedSave = [data writeToFile:imageFilePath atomically:YES];
        return isSucceedSave;
    }
    return NO;
}

/*
 * 功能：获取存储的图片
 *
 * 参数：
 * imageName  : 图片的名字
 * foldername : 存储图片的文件夹名
 */
+ (UIImage *)getImageFromSandboxWithImageName:(NSString *)imageName
                                fromDirectory:(NSString *)folderName
{
    if (imageName && [imageName length] > 0)
    {
        NSString      *directoryPath    = [JoeChenDocumentsHomePath stringByAppendingPathComponent:folderName];
        NSString      *imageFilePath    = [directoryPath stringByAppendingPathComponent:imageName];
        
        //判断即将存储的文件是否存在
        BOOL isPicFileExist = [UIImage isExistsFile:imageName withDirectoryName:folderName];
        if (isPicFileExist)
        {
            UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
            return image;
        }
    }
    return nil;
}


/*
 * 功能：删除指定的图片
 *
 * 参数：
 * nameArray  : 即将删除的图片名字数组
 * foldername : 存储图片的文件夹名
 */
+(void)deleteImageFileWithNamesArray:(NSArray *)nameArray
                       fromDirectory:(NSString *)folderName
{
    if (nameArray && [nameArray count] > 0)
    {
        for (int i=0; i<[nameArray count]; i++)
        {
            NSString     *imagePathString   = [nameArray objectAtIndex:i];
            if (imagePathString && [imagePathString length] > 0)
            {
                imagePathString = [NSString getMd5_32Bit_String:imagePathString];
                
                //判断即将删除的文件是否存在
                BOOL isPicFileExist = [UIImage isExistsFile:imagePathString withDirectoryName:folderName];
                if (isPicFileExist)
                {
                    NSString *filePath = [[JoeChenDocumentsHomePath stringByAppendingPathComponent:folderName] stringByAppendingPathComponent:imagePathString];
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    if ([fileManager isDeletableFileAtPath:filePath])
                    {
                        NSError *error;
                        BOOL isSucceed = [fileManager removeItemAtPath:filePath error:&error];
                        if (isSucceed)
                        {
                        }else
                        {
                        }
                    }else
                    {
                    }
                }else
                {
                }
            }
        }
    }
}


/*
 * 功能：删除指定文件夹的所有图片
 *
 * 参数：
 * foldername : 存储图片的文件夹名
 */
+(void)deleteAllImageFileFromDirectory:(NSString *)folderName
{
    if (folderName && [folderName length] > 0)
    {
        NSString *filePath = [JoeChenDocumentsHomePath stringByAppendingPathComponent:folderName];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ([fileManager isDeletableFileAtPath:filePath])
        {
            NSError *error;
            [fileManager removeItemAtPath:filePath error:&error];
            
        }
    }
}








@end
