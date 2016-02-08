//
//  ProductCollectionView.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductWebViewViewController.h"
#import "DAO.h"
#import "AddProduct.h"
#import "EditProduct.h"
#import "ProductCell.h"

@class AddProduct;
@class EditProduct;

@interface ProductCollectionView : UICollectionViewController

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSArray *companyList;
@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) ProductWebViewViewController *page;
@property (nonatomic, retain) AddProduct *AddProduct;
@property (nonatomic, retain) EditProduct *EditProduct;


@end
