//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductWebViewViewController.h"

@interface ProductViewController : UITableViewController
@property (nonatomic, retain) NSMutableArray *products;

@property (nonatomic, retain) NSMutableArray *apple;
@property (nonatomic, retain) NSMutableArray *samsung;
@property (nonatomic, retain) NSMutableArray *lg;
@property (nonatomic, retain) NSMutableArray *pantech;

@property (nonatomic, retain) ProductWebViewViewController *page;

@end
