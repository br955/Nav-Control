//
//  CompanyMO.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/3/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CompanyMO : NSManagedObject

@property (nonatomic, retain) NSNumber* companyID;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* stockSymbol;

@end
