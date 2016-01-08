//
//  Product.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)initWithName: (NSString*) name SiteURL: (NSString*) siteURL{
    _name = name;
    _siteURL = siteURL;
    return self;
}

@end
