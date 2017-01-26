//
//  MovieModel.h
//  Flicks
//
//  Created by  Michael Lin on 1/23/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

@property (nonatomic, assign) NSInteger movieId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *movieDescription;
@property (nonatomic, strong) NSURL *posterURL;

@end
