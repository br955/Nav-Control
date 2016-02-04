//
//  ProductMO.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/3/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ProductMO : NSManagedObject

@property (nonatomic, retain) NSString * siteURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * companyID;
@property (nonatomic, retain) NSNumber * productID;

@end
