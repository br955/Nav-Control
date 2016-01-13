//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "AddCompany.h"
#import "EditCompany.h"

@class ProductViewController;
@class AddCompany;
@class EditCompany;

@interface CompanyViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSArray *companyIcons;

@property (nonatomic, retain) IBOutlet ProductViewController *productViewController;
@property (nonatomic, retain) AddCompany *AddCompany;
@property (nonatomic, retain) EditCompany *EditCompany;

@end
