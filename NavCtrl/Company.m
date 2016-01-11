//
//  Company.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

-(id) initWithName: (NSString*) name Icon: (UIImage*) icon{
    _name = name;
    _companyIcon = icon;
    return self;
}

@end
