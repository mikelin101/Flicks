//
//  ViewController.m
//  Flicks
//
//  Created by  Michael Lin on 1/23/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "ViewController.h"
#import "MovieCell.h"
#import "GridCell.h"
#import "MovieModel.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ViewController () <UITableViewDataSource, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray<MovieModel *> *movies;
@end

@implementation ViewController

- (IBAction)onValueChanged:(UISegmentedControl *)sender {
    switch(sender.selectedSegmentIndex) {
        case 0:
            NSLog(@"list");
            _collectionView.hidden = true;
            _movieTableView.hidden = false;
            break;
        case 1:
            NSLog(@"grid");
            _movieTableView.hidden = true;
            _collectionView.hidden = false;
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self onValueChanged:_segmentedControl];

    self.movieTableView.dataSource = self;
    self.collectionView.dataSource = self;

    [self fetchMovies];
}

- (void) fetchMovies {
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";

    NSString *urlBase;
    if([self.restorationIdentifier isEqualToString:@"top_rated"]) {
        urlBase = @"https://api.themoviedb.org/3/movie/top_rated?api_key=";
    } else {
        urlBase = @"https://api.themoviedb.org/3/movie/now_playing?api_key=";
    }
    
    NSString *urlString =
    [urlBase stringByAppendingString:apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    
                                                    NSArray *results = responseDictionary[@"results"];
                                                    NSMutableArray *models = [NSMutableArray array];
                                                
                                                    for (NSDictionary *result in results) {
                                                        MovieModel *model = [[MovieModel alloc] initWithDictionary:result];
                                                        NSLog(@"Model - %@", model);
                                                        
                                                        [models addObject:model];
                                                    }
                                                    self.movies = models;
                                                    [self.movieTableView reloadData];
                                                    [self.collectionView reloadData];
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                }
                                            }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"
    
    MovieCell* cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    
    MovieModel *model = [self.movies objectAtIndex:indexPath.row];
    cell.titleLabel.text = model.title;
    cell.overviewLabel.text = model.movieDescription;
//    [cell.posterImage setImage:[UIImage imageNamed:@"YahooIcon.png"]];

//    cell.posterImage.contentMode = UIViewContentModeScaleAspectFit;
    [cell.posterImage setImageWithURL:model.posterURL];
    
    NSLog(@"row number= %ld", indexPath.row);
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld", indexPath.row);
    
    GridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell" forIndexPath:indexPath];
    
    MovieModel *model = [self.movies objectAtIndex:indexPath.row];
    cell.title.text = model.title;
    [cell.posterImage setImageWithURL:model.posterURL];

    return cell;
}

@end
