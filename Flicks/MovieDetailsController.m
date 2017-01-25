//
//  MovieDetailsController.m
//  Flicks
//
//  Created by  Michael Lin on 1/25/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import "MovieDetailsController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation MovieDetailsController

-(void)viewDidLoad {
    [self.posterImage setImageWithURL:self.movieModel.posterURL];
    self.descriptionLabel.text = self.movieModel.movieDescription;
}
@end
