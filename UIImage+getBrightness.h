//
//  UIImage+GetBrightness.h
//  ImageBrightness
//
//  Created by Luka Kvavilashvili on 9/13/15.
//  Copyright (c) 2015 Luka Kvavilashvili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface UIImage (GetBrightness)
- (UIColor *)colorAtPixel:(CGPoint)point;
- (float)getBrightness;
@end
