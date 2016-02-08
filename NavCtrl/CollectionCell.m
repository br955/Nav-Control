//
//  CollectionCell.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/5/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {

        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [[arrayOfViews objectAtIndex:0 ]retain];
        
        
    }
    return self;
}

- (void)dealloc {
    [_name release];
    [_stockPrice release];
    [super dealloc];
}
@end
