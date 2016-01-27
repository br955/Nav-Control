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
#import "sqlite3.h"

@interface DAO : NSObject

@property (readwrite, nonatomic, retain) NSMutableArray *companies;
@property sqlite3 *database;
@property (nonatomic, retain) NSString *dbPathString;

+(id) sharedManager;

-(id) init;

-(NSMutableArray*) addCompany: (NSString*) name stockSymbol: (NSString*)stockSymbol;

-(NSMutableArray*) getCompanyData;

-(NSMutableArray*) addProduct: (NSString*) name forCompany: (NSString*) company;

-(NSMutableArray*) editCompany: (NSString*) newName fromName: (NSString*) oldName;

-(NSMutableArray*) editProduct: (NSString*) newName fromName: (NSString*) oldName forCompany: (NSString*) company;

-(void) deleteCompany: (NSString*) name;

-(void) deleteProduct: (NSString*) name;


@end
