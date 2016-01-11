//
//  Product.h
//  NavCtrl
//
//  Created by Aditya Narayan on 1/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *siteURL;
@property (nonatomic, retain) NSString *icon;

-(id)initWithName: (NSString*) name SiteURL: (NSString*) siteURL Icon: (NSString*) icon;

@end
