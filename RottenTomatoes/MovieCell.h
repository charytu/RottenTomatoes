//
//  MovieCell.h
//  RottenTomatoes
//
//  Created by Chary Tu on 6/17/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLable;

@end
