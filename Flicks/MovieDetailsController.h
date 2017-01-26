//
//  MovieDetailsController.h
//  Flicks
//
//  Created by  Michael Lin on 1/25/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface MovieDetailsController : UIViewController

@property(strong, nonatomic) MovieModel *movieModel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *runtime;
@property (weak, nonatomic) IBOutlet UILabel *rating;

@end
