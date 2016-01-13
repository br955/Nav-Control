//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductWebViewViewController.h"
#import "DAO.h"
#import "AddProduct.h"


@class AddProduct;

@interface ProductViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSArray *companyList;


@property (nonatomic, retain) ProductWebViewViewController *page;
@property (nonatomic, retain) AddProduct *AddProduct;

@end
