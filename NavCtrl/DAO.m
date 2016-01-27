//
//  DAO.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO

+(id) sharedManager {
    static DAO *theManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theManager = [[self alloc] init];
    });
    return theManager;
}

-(id) init{
    self = [super init];
    if(self){
        
    [self openDB];
        sqlite3_stmt *statement;
        self.companies = [[NSMutableArray alloc]init];
        
        if (sqlite3_open([self.dbPathString UTF8String], &_database) == SQLITE_OK) {
            [self.companies removeAllObjects];
            NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM Companies"];
            const char *query_sql = [querySQL UTF8String];
            if (sqlite3_prepare(self.database, query_sql, -1, &statement, NULL) == SQLITE_OK){
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSString *stockSymbol =[[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    Company *company = [[Company alloc]init];
                    company.name = name;
                    company.stockSymbol = stockSymbol;
                    [self.companies addObject:company];
                }
            }
            querySQL = [NSString stringWithFormat:@"SELECT * FROM Products"];
            query_sql = [querySQL UTF8String];
            if (sqlite3_prepare(self.database, query_sql, -1, &statement, NULL) == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    NSString *siteURL = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    Product *product = [[Product alloc]init];
                    product.name = name;
                    product.siteURL = siteURL;
                    long x = sqlite3_column_int(statement, 1);
                    product.companyID = [NSNumber numberWithLong:(x)];
                    Company *company = [self.companies objectAtIndex:[product.companyID intValue]-1];
                    if (company.productList == nil) {
                        company.productList = [[NSMutableArray alloc]init];
                    }
                    [company.productList addObject:product];
                    x = [product.companyID intValue]-1;
                    self.companies[x] = company;
                }
            }
            else {
             NSLog(@"sqlite prepare failed: %s", sqlite3_errmsg(self.database));
            }
        }

    }
    return self;
}

-(void)openDB{
    NSError *error;
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    self.dbPathString = [docPath stringByAppendingPathComponent:@"sqlitedatabase"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:self.dbPathString]){

            NSString *bundleDataBasePath = [[NSBundle mainBundle] pathForResource:@"sqlitedatabase" ofType:@"" ];
            [fileManager copyItemAtPath:bundleDataBasePath toPath:self.dbPathString error:&error];
            if(![fileManager fileExistsAtPath:self.dbPathString]){
                NSLog(@"%@", error);
            }
    }
}



-(NSMutableArray*) addCompany: (NSString*) name stockSymbol: (NSString*)stockSymbol{
    char *error;
    Company *newCompany = [[Company alloc] init];
    newCompany.name = name;
    newCompany.stockSymbol = stockSymbol;
    //sqlite3_stmt *statement;
    if (sqlite3_open([self.dbPathString UTF8String], &_database) == SQLITE_OK){
        NSString *addToSQLTable = [NSString stringWithFormat:@"INSERT INTO Companies(Name, stockSymbol) VALUES ('%@','%@')",newCompany.name, newCompany.stockSymbol];
        const char *sqlAdd = [addToSQLTable UTF8String];
        if (sqlite3_exec(_database, sqlAdd, NULL, NULL, &error)==SQLITE_OK) {
            NSLog(@"Company added to database");
            
        }
        sqlite3_close(_database);
    }
    [self.companies addObject: newCompany];
    return self.companies;
}

-(NSMutableArray*) addProduct: (NSString*) name forCompany: (NSString*) company{
    char *error;
    Product *newProduct = [[Product alloc]init];
    newProduct.name = name;
    newProduct.siteURL = @"www.google.com";
    int i = 0;
    while(i<self.companies.count){
        if([[[self.companies objectAtIndex:i] valueForKey:@"name"] isEqualToString:company]){
            newProduct.companyID = [NSNumber numberWithInt: i+1];
            Company *temp = [self.companies objectAtIndex:i];
            [temp.productList addObject:newProduct];
            self.companies[i] = temp;
        }
        i++;
    }
    if (sqlite3_open([self.dbPathString UTF8String], &_database) == SQLITE_OK){
        NSString *addToSQLTable = [NSString stringWithFormat:@"INSERT INTO Products(Companyid ,Name, siteURL) VALUES (%@,'%@','%@')", newProduct.companyID ,newProduct.name, newProduct.siteURL];
        const char *sqlAdd = [addToSQLTable UTF8String];
        if (sqlite3_exec(_database, sqlAdd, NULL, NULL, &error)==SQLITE_OK) {
            NSLog(@"Product added to database");
        }
        sqlite3_close(_database);
    }
    return self.companies;
}

-(NSMutableArray*) editCompany: (NSString*) newName fromName: (NSString*) oldName{
    char *error;
    int i = 0;
    while (i<self.companies.count) {
        if ([[[self.companies objectAtIndex:i]valueForKey:@"name"] isEqualToString:oldName]) {
            Company *temp = self.companies[i];
            temp.name = newName;
            self.companies[i] = temp;
        }
        i++;
    }
    if (sqlite3_open([self.dbPathString UTF8String], &_database) == SQLITE_OK){
        NSString *addToSQLTable = [NSString stringWithFormat:@"UPDATE Companies SET Name = '%@' WHERE Name = '%@'", newName, oldName];
        const char *sqlAdd = [addToSQLTable UTF8String];
        if (sqlite3_exec(_database, sqlAdd, NULL, NULL, &error)==SQLITE_OK) {
            NSLog(@"Company renamed");
        }
        sqlite3_close(_database);
    }
    return self.companies;
}

-(NSMutableArray*) editProduct: (NSString*) newName fromName: (NSString*) oldName forCompany: (NSString*) company{
    char *error;
    int i = 0;
    while (i<self.companies.count) {
        if ([[[self.companies objectAtIndex:i] valueForKey:@"name"] isEqualToString:company]) {
            int z = 0;
            Company *tempCompany = self.companies[i];
            while (z<tempCompany.productList.count) {
                if ([[[tempCompany.productList objectAtIndex:z] valueForKey:@"name"] isEqualToString:oldName]) {
                    Product *tempProduct = tempCompany.productList[z];
                    tempProduct.name = newName;
                    tempCompany.productList[z] = tempProduct;
                }
                z++;
            }
        }
        i++;
    }
    if (sqlite3_open([self.dbPathString UTF8String], &_database) == SQLITE_OK){
        NSString *addToSQLTable = [NSString stringWithFormat:@"UPDATE Products SET Name = '%@' WHERE Name = '%@'", newName, oldName];
        const char *sqlAdd = [addToSQLTable UTF8String];
        if (sqlite3_exec(_database, sqlAdd, NULL, NULL, &error)==SQLITE_OK) {
            NSLog(@"Product renamed");
        }
        sqlite3_close(_database);
    }
    return self.companies;
}

-(NSMutableArray*) getCompanyData{
    return self.companies;
}



-(void) deleteCompany: (NSString*) name{
    char *error;
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM Companies WHERE Name = '%@'", name];
    if (sqlite3_open([self.dbPathString UTF8String], &_database) == SQLITE_OK){
        const char *sqlDelete = [deleteQuery UTF8String];
        if (sqlite3_exec(_database, sqlDelete, NULL, NULL, &error) == SQLITE_OK) {
            NSLog(@"Company Deleted");
        }
    }
}

-(void) deleteProduct: (NSString*) name{
    char *error;
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM Products WHERE Name = '%@'", name];
    if (sqlite3_open([self.dbPathString UTF8String], &_database) == SQLITE_OK){
        const char *sqlDelete = [deleteQuery UTF8String];
        if (sqlite3_exec(_database, sqlDelete, NULL, NULL, &error) == SQLITE_OK) {
            NSLog(@"Product Deleted");
        }
    }
}

@end








