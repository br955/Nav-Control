//
//  Product.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(id)initWithName: (NSString*) name SiteURL: (NSString*) siteURL Icon:(UIImage *)icon{
    _name = name;
    _siteURL = siteURL;
    _icon = icon;
    return self;
}

@end
