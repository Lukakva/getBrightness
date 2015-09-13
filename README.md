# getBrightness
This Objective C library which rates the brightness of UIImage from 0 to 1.

Function takes pretty long time to execute (depends on pixel count) but is pretty accurate and reliable.


# Usage
```objective-c
#import "UIImage+getBrightness.h"

UIImage *image = [[UIImage alloc] initWithContentsOfFile:@"image.jpg"];
float brightness = [image getBrightness];

if (brightness > 0.5) {
    // upload to server
] else {
    // nope
}
```

Note that there already is test code in ViewController.m, which tests the brightness of dark.jpg
you can try and change the test code to light.jpg and see the results