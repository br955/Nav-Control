//
//  DAO.h
//  NavCtrl
//
//  Created by Aditya Narayan on 1/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
#import "CompanyMO.h"
#import "ProductMO.h"
#import <CoreData/CoreData.h>


@interface DAO : NSObject

@property (readwrite, nonatomic, retain) NSMutableArray *companies;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, retain) NSManagedObjectModel *model;

-(void) initModelContext;

-(NSURL*) archivePath;

+(id) sharedManager;

-(id) init;

-(void) loadData;

-(void) loadDefaultData;

-(NSMutableArray*) addCompany: (NSString*) name stockSymbol: (NSString*)stockSymbol;

-(NSMutableArray*) getCompanyData;

-(NSMutableArray*) addProduct: (NSString*) name forCompany: (NSString*) company;

-(NSMutableArray*) editCompany: (NSString*) newName fromName: (NSString*) oldName;

-(NSMutableArray*) editProduct: (NSString*) newName fromName: (NSString*) oldName forCompany: (NSString*) company;

-(void) deleteCompany: (NSString*) name;

-(void) deleteProduct: (NSString*) name;




@end
