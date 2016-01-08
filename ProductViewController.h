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


@interface ProductViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *products;

@property (nonatomic, retain) Company *apple;
@property (nonatomic, retain) Company *samsung;
@property (nonatomic, retain) Company *lg;
@property (nonatomic, retain) Company *pantech;

@property (nonatomic, retain) ProductWebViewViewController *page;

@end
