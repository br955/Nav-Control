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
@property (nonatomic, retain) NSString *companyIcon;
@property (nonatomic, retain) NSString *stockPrice;
@property (nonatomic, retain) NSString *stockSymbol;
@property (nonatomic, retain) NSNumber *ID;


-(id) initWithName: (NSString*) name Icon: (NSString*) icon;

@end
