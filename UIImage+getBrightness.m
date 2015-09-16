//
//  UIImage+GetBrightness.m
//  ImageBrightness
//
//  Created by Luka Kvavilashvili on 9/13/15.
//  Copyright (c) 2015 Luka Kvavilashvili. All rights reserved.
//

#import <UIKit/UIKit.h>

@implementation UIImage (GetBrightness)
- (UIColor *)colorAtPixel:(CGPoint)point {
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }
    
    
    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = CGImageGetWidth(cgImage);
    NSUInteger height = CGImageGetHeight(cgImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4; // kCGBitmap requires 4 bytes
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {0, 0, 0, 0};
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, -pointY);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (float)getPixelBrightness:(UIColor *)pixel {
    CGFloat r = 0.0, g = 0.0, b = 0.0, a = 0.0;
    [pixel getRed:&r green:&g blue:&b alpha:&a];
    
    return (r + g + b) / 3;
}

- (float)getBrightness {
    CGFloat height = self.size.height;
    CGFloat width = self.size.width;
    
    float sum = 0;
    
    for (unsigned long h = 1; h <= height; h++) {
        for (unsigned long w = 1; w <= width; w++) {
            CGPoint pixelPosition = CGPointMake(w, h);
            UIColor *pixel = [self colorAtPixel:pixelPosition];
            float brightness = [self getPixelBrightness:pixel];
            sum += brightness;
        }
    }
    
    return sum / (width * height);
}
@end