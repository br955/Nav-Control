//
//  ProductCell.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
        
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
    [super dealloc];
}
@end
