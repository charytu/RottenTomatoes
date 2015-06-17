//
//  ViewController.h
//  RottenTomatoes
//
//  Created by Chary Tu on 6/13/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *synoposisLable;
@property (strong, nonatomic) NSDictionary *movie;

@end

