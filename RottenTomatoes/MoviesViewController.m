//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Chary Tu on 6/16/15.
//  Copyright (c) 2015 chary tu. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "ViewController.h"
#import <UIImageView+AFNetworking.h>
#import <SVProgressHUD.h>

@interface MoviesViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSArray *movies;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UILabel *errorLable;
@property (weak, nonatomic) IBOutlet UIImageView *errorImageView;


@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyMovieCell"];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1];
 
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.errorImageView.hidden = YES;
    self.errorView.hidden = YES;
    [self handleTabledata];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    
    [refreshControl addTarget:self action:@selector(refreshTable:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
}

-(void) refreshTable:(UIRefreshControl *)refreshControl
{
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}

- (void)handleTabledata {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(connectionError != nil) {
            self.errorView.hidden = NO;
            self.errorImageView.hidden = NO;
            self.errorLable.text = @"Networking Error";
        } else {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = dict[@"movies"];
            [self.tableView reloadData];
        }
    }];
    
}

- (IBAction)dismiss:(id)sender {
    [SVProgressHUD dismiss];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMovieCell" forIndexPath:indexPath];
    NSDictionary *movie =self.movies[indexPath.row];
    //NSString *title = movie[@"title"];
    cell.titleLable.text = movie[@"title"];
    cell.synopsisLable.text = movie[@"synopsis"];
    NSString *posterURLString = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterURLString]];
    return cell;
    //cell.textLabel
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *movie = self.movies[indexPath.row];
    ViewController *destioationVC = segue.destinationViewController;
    destioationVC.movie = movie;
      
}




@end
