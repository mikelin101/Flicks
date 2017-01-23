//
//  MovieFetcher.h
//  Flicks
//
//  Created by  Michael Lin on 1/23/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

typedef void (^MovieFetcherCallback)(NSArray *movies, NSError* error);
typedef void (^MovieImageFetcherCallback)(UIImage *image, NSError* error);

@interface MovieFetcher : NSObject
+ (id)sharedInstance ;
-(void) fetchTopRated:(MovieFetcherCallback)callback;
-(void) fetchNowPlaying:(MovieFetcherCallback)callback;
-(void) fetchImageForURL:(NSURL*)url withCallback:(MovieImageFetcherCallback)callback;
@end
