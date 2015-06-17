//
//  ViewController.m
//  RottenTomatoes
//
//  Created by Chary Tu on 6/13/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLable.text = self.movie[@"title"];
    self.synoposisLable.text = self.movie[@"synopsis"];
    NSString *posterURLString = [self.movie valueForKeyPath:@"posters.detailed"];
    posterURLString = [self convertPosterUrlStringToHighRes:posterURLString];
    [self.posterView setImageWithURL:[NSURL URLWithString:posterURLString]];

}

-(NSString *)convertPosterUrlStringToHighRes:(NSString *)URLString {
    NSRange rang = [URLString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue = URLString;
    if(rang.length >0 ) {
        returnValue = [URLString stringByReplacingCharactersInRange:rang withString:@"https://content6.flixster.com/"];
    }
    return returnValue;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
