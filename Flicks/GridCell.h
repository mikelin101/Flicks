//
//  GridCell.h
//  Flicks
//
//  Created by  Michael Lin on 1/24/17.
//  Copyright © 2017 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;

@end
