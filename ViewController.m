//
//  ViewController.m
//  ImageBrightness
//
//  Created by Luka Kvavilashvili on 9/13/15.
//  Copyright (c) 2015 Luka Kvavilashvili. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+getBrightness.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"light" ofType:@"jpg"]]];

    float brightness = [image getBrightness];
    NSLog(@"%f", brightness);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
