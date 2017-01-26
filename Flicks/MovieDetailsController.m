//
//  MovieDetailsController.m
//  Flicks
//
//  Created by  Michael Lin on 1/25/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "MovieDetailsController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

@implementation MovieDetailsController

-(void)viewDidLoad {
    [self.posterImage setImageWithURL:self.movieModel.posterURL];
    self.descriptionLabel.text = self.movieModel.movieDescription;
    NSLog(@"%d", self.movieModel.movieId);
    [self fetchMovies:nil];
}

- (void) fetchMovies:(id)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:false];
    
    NSString *apiKey = @"a07e22bc18f5cb106bfe4cc1f83ad8ed";
    
    NSString *urlBase;
    if([self.restorationIdentifier isEqualToString:@"top_rated"]) {
        urlBase = @"https://api.themoviedb.org/3/movie/%d?api_key=";
    } else {
        urlBase = @"https://api.themoviedb.org/3/movie/%d?api_key=";
    }
    
    NSString *urlString = [NSString stringWithFormat:[urlBase stringByAppendingString:apiKey], self.movieModel.movieId];
    
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
                                                [MBProgressHUD hideHUDForView:self.view animated:false];
                                                
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"%@", responseDictionary);
                                                    self.releaseDate.text = responseDictionary[@"release_date"];
//                                                    NSLog(@"%@", responseDictionary[@"runtime"]);
                                                    self.rating.text = [NSString stringWithFormat:@"%f", [responseDictionary[@"vote_average"] floatValue]];
                                                    self.runtime.text = [NSString stringWithFormat:@"%d", [responseDictionary[@"runtime"] intValue]];
                                                    
                                                } else {
                                                    NSLog(@"%@", error.description);
                                                    
                                                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                                                    
                                                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"There was a network error" preferredStyle:UIAlertControllerStyleAlert];
                                                    
                                                    [alert addAction:defaultAction];
                                                    
                                                    [self presentViewController:alert animated:false completion:nil];
                                                }
                                            }];
    [task resume];
}

@end
