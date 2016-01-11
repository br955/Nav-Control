//
//  Company.h
//  NavCtrl
//
//  Created by Aditya Narayan on 1/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface Company : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *productList;
@property (nonatomic, retain) UIImage *companyIcon;


-(id) initWithName: (NSString*) name Icon: (UIImage*) icon;

@end
