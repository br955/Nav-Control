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

-(void) initModelContext {
    [self setModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self model]];
    

    NSURL *storeURL = [self archivePath];
    NSError *error = nil;
    
    if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
    }
    [self setManagedObjectContext:[[NSManagedObjectContext alloc]init]];
    [[self managedObjectContext]setPersistentStoreCoordinator:psc];
    [self.managedObjectContext setRetainsRegisteredObjects:YES];
}


-(NSURL*) archivePath{
    NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
    
    NSURL *storeURL = [NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:@"store.data"] isDirectory:NO];
    
    return storeURL;
}



-(id) init{
    self = [super init];
    [self loadData];
    return self;
}

-(void) loadData{
    NSError *error;
    if(self){
        self.companies = [[NSMutableArray alloc]init];
        self.products = [[NSMutableArray alloc]init];
        [self initModelContext];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CompanyMO"]; // add companies already in core data
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"companyID" ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObject:descriptor];
        [request setSortDescriptors:descriptors];
        NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
        int i = 0;
        while (i< results.count) {
            CompanyMO *tempCOMO = results[i];
            Company *tempCO = [[Company alloc]init];
            tempCO.ID = tempCOMO.companyID;
            tempCO.name = tempCOMO.name;
            tempCO.stockSymbol = tempCOMO.stockSymbol;
            [self.companies addObject:tempCO];
            [tempCO release];
            [tempCOMO release];
            i++;
        }
        request = [NSFetchRequest fetchRequestWithEntityName:@"ProductMO"]; // add products already in core data
        results = [self.managedObjectContext executeFetchRequest:request error:&error];
        i = 0;
        while (i< results.count) {
            ProductMO *tempPROMO =results[i];
            Product *tempPRO = [[Product alloc]init];
            tempPRO.companyID = tempPROMO.companyID;
            tempPRO.name = tempPROMO.name;
            tempPRO.siteURL = tempPROMO.siteURL;
            [self.products addObject:tempPRO];
            [tempPROMO release];
            [tempPRO release];
            i++;
        }
        
        if(self.companies.count == 0){  // hard code companies & products if no data is available
            [self loadDefaultData];
        }
        
            i = 0;
        while (i<self.products.count) {
            Product *tempPro = self.products[i];
            Company *tempCO = [self.companies objectAtIndex:[tempPro.companyID integerValue] - 1];
            if (tempCO.productList == nil) {
                tempCO.productList = [[NSMutableArray alloc ]init];
            }
            [tempCO.productList addObject:tempPro];
            long identity = [tempPro.companyID integerValue] - 1;
            self.companies[identity] = tempCO;
            i++;
        }
    }
    
}

-(void) loadDefaultData{
    NSError *error;
    CompanyMO *apple = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:self.managedObjectContext];
    [apple setValue:@1 forKey:@"companyID"];
    [apple setValue:@"Apple Mobile Devices" forKey:@"name"];
    [apple setValue:@"AAPL" forKey:@"stockSymbol"];
    
    CompanyMO *samsung = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:self.managedObjectContext];
    [samsung setValue:@2 forKey:@"companyID"];
    [samsung setValue:@"Samsung Mobile Devices" forKey:@"name"];
    [samsung setValue:@"SSNLF" forKey:@"stockSymbol"];
    
    CompanyMO *lg = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:self.managedObjectContext];
    [lg setValue:@3 forKey:@"companyID"];
    [lg setValue:@"LG Electronics" forKey:@"name"];
    [lg setValue:@"LG" forKey:@"stockSymbol"];
    
    CompanyMO *pantech = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:self.managedObjectContext];
    [pantech setValue:@4 forKey:@"companyID"];
    [pantech setValue:@"Pantech" forKey:@"name"];
    [pantech setValue:@"5125.KL" forKey:@"stockSymbol"];
    
    NSArray *MOCompanies = [NSArray arrayWithObjects:apple, samsung, lg, pantech, nil];
    int i=0;
    while (i< MOCompanies.count) {    // add hard coded companies to company property
        CompanyMO *tempCOMO = MOCompanies[i];
        Company *tempCO = [[Company alloc]init];
        tempCO.ID = tempCOMO.companyID;
        tempCO.name = tempCOMO.name;
        tempCO.stockSymbol = tempCOMO.stockSymbol;
        [self.companies addObject:tempCO];
        [tempCO release];
        [tempCOMO release];
        i++;
    }
    
    ProductMO *iPad = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [iPad setValue:@1 forKey:@"companyID"];
    [iPad setValue:@"iPad" forKey:@"name"];
    [iPad setValue:@"http://www.apple.com/ipad/" forKey:@"siteURL"];
    
    ProductMO *iPod = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [iPod setValue:@1 forKey:@"companyID"];
    [iPod setValue:@"iPod Touch" forKey:@"name"];
    [iPod setValue:@"http://www.apple.com/ipod-touch/" forKey:@"siteURL"];
    
    ProductMO *iPhone = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [iPhone setValue:@1 forKey:@"companyID"];
    [iPhone setValue:@"iPhone" forKey:@"name"];
    [iPhone setValue:@"http://www.apple.com/iphone/" forKey:@"siteURL"];
    
    ProductMO *S4 = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [S4 setValue:@2 forKey:@"companyID"];
    [S4 setValue:@"Galaxy S4" forKey:@"name"];
    [S4 setValue:@"http://www.samsung.com/global/microsite/galaxys4/" forKey:@"siteURL"];
    
    ProductMO *Note = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [Note setValue:@2 forKey:@"companyID"];
    [Note setValue:@"Galaxy Note" forKey:@"name"];
    [Note setValue:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find" forKey:@"siteURL"];
    
    ProductMO *Tab = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [Tab setValue:@2 forKey:@"companyID"];
    [Tab setValue:@"Galaxy Tab" forKey:@"name"];
    [Tab setValue:@"http://www.samsung.com/global/microsite/galaxytab/10.1/index.html" forKey:@"siteURL"];
    
    ProductMO *G4 = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [G4 setValue:@3 forKey:@"companyID"];
    [G4 setValue:@"G4" forKey:@"name"];
    [G4 setValue:@"http://www.lg.com/us/mobile-phones/g4" forKey:@"siteURL"];
    
    ProductMO *gWatch = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [gWatch setValue:@3 forKey:@"companyID"];
    [gWatch setValue:@"G Watch" forKey:@"name"];
    [gWatch setValue:@"http://www.lg.com/global/gwatch/index.html#main" forKey:@"siteURL"];
    
    ProductMO *gFlex = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [gFlex setValue:@3 forKey:@"companyID"];
    [gFlex setValue:@"G Flex" forKey:@"name"];
    [gFlex setValue:@"http://www.lg.com/us/lg-g-flex-phones" forKey:@"siteURL"];
    
    ProductMO *Breakout = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [Breakout setValue:@4 forKey:@"companyID"];
    [Breakout setValue:@"Breakout" forKey:@"name"];
    [Breakout setValue:@"http://www.pantechusa.com/phones/breakout" forKey:@"siteURL"];
    
    ProductMO *Ease = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    
    [Ease setValue:@4 forKey:@"companyID"];
    [Ease setValue:@"Ease" forKey:@"name"];
    [Ease setValue:@"http://www.gsmarena.com/pantech_ease-3405.php" forKey:@"siteURL"];
    
    ProductMO *Hotshot = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    
    [Hotshot setValue:@4 forKey:@"companyID"];
    [Hotshot setValue:@"Hotshot" forKey:@"name"];
    [Hotshot setValue:@"http://www.gsmarena.com/pantech_breakout-4294.php" forKey:@"siteURL"];
    
    NSArray *MOProducts = [NSArray arrayWithObjects:iPad, iPhone, iPod, S4, Note, Tab, G4, gWatch, gFlex, Breakout, Ease, Hotshot, nil];
    i = 0;
    while (i< MOProducts.count) {       // add hard coded products to product property (only used to populate company product lists
        ProductMO *tempPROMO =MOProducts[i];
        Product *tempPRO = [[Product alloc]init];
        tempPRO.companyID = tempPROMO.companyID;
        tempPRO.name = tempPROMO.name;
        tempPRO.siteURL = tempPROMO.siteURL;
        [self.products addObject:tempPRO];
        [tempPROMO autorelease];
        [tempPRO autorelease];
        i++;
    }
    [self.managedObjectContext save:&error];
}


-(NSMutableArray*) addCompany: (NSString*) name stockSymbol: (NSString*)stockSymbol{
    NSError *error;
    Company *newCompany = [[Company alloc] init];
    newCompany.name = name;
    newCompany.stockSymbol = stockSymbol;
    newCompany.ID = [NSNumber numberWithLong: self.companies.count + 1];
    
    CompanyMO *new = [NSEntityDescription insertNewObjectForEntityForName:@"CompanyMO" inManagedObjectContext:self.managedObjectContext];
    [new setCompanyID:newCompany.ID];
    [new setName: newCompany.name ];
    [new setStockSymbol: newCompany.stockSymbol];
    
    [self.companies addObject: [newCompany autorelease]];
    [self.managedObjectContext save:&error];
    return self.companies;
}

-(NSMutableArray*) addProduct: (NSString*) name forCompany: (NSString*) company{
    NSError *error;
    Product *newProduct = [[Product alloc]init];
    newProduct.name = name;
    newProduct.siteURL = @"www.google.com";
    int i = 0;
    while(i<self.companies.count){
        if([[[self.companies objectAtIndex:i] valueForKey:@"name"] isEqualToString:company]){
            newProduct.companyID = [NSNumber numberWithInt: i+1];
            Company *temp = [self.companies objectAtIndex:i];
            if (temp.productList == nil){
                temp.productList = [[NSMutableArray alloc]init];
            }
            [temp.productList addObject:newProduct];
            self.companies[i] = temp;
        }
        i++;
    }
    
    ProductMO *new = [NSEntityDescription insertNewObjectForEntityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [new setValue: newProduct.companyID forKey:@"companyID"];
    [new setValue: newProduct.name forKey:@"name"];
    [new setValue: newProduct.siteURL forKey:@"siteURL"];
    [self.managedObjectContext save:&error];
    return self.companies;
}

-(NSMutableArray*) editCompany: (NSString*) newName fromName: (NSString*) oldName{
    int i = 0;
    while (i<self.companies.count) {
        if ([[[self.companies objectAtIndex:i]valueForKey:@"name"] isEqualToString:oldName]) {
            Company *temp = self.companies[i];
            temp.name = newName;
            self.companies[i] = temp;
            [temp release];
        }
        i++;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
   
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", oldName];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    CompanyMO *temp = [results objectAtIndex:0];
    [fetchRequest release];
    temp.name = newName;
    [self.managedObjectContext save:&error];
    return self.companies;
}

-(NSMutableArray*) editProduct: (NSString*) newName fromName: (NSString*) oldName forCompany: (NSString*) company{
    //char *error;
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
                    self.companies[i] = tempCompany;
                    [tempCompany release];
                    [tempProduct release];
                    break;
                }
                z++;
            }
        }
        i++;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", oldName];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    ProductMO *temp = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] objectAtIndex:0];
    [fetchRequest release];
    temp.name = newName;
    [self.managedObjectContext save:&error];
    return self.companies;
}

-(NSMutableArray*) getCompanyData{
    [self loadData];
    return self.companies;
}



-(void) deleteCompany: (NSString*) name{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CompanyMO" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    [self.managedObjectContext deleteObject:[[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] objectAtIndex:0]];
    [self.managedObjectContext save:&error];
    }

-(void) deleteProduct: (NSString*) name{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ProductMO" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    [self.managedObjectContext deleteObject:[[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] objectAtIndex:0]];
    [self.managedObjectContext save:&error];
   }

@end








