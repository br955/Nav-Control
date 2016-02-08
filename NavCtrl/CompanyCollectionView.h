//
//  CompanyCollectionView.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/5/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "DAO.h"
#import "AddCompany.h"
#import "EditCompany.h"
#import "CollectionCell.h"
#import "ProductCollectionView.h"
#import "AFNetworking.h"

@class ProductCollectionView;
@class AddCompany;
@class EditCompany;

@interface CompanyCollectionView : UICollectionViewController <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSArray *companyIcons;
@property (nonatomic, retain) NSString *stockPriceUrl;
@property (nonatomic, retain) NSMutableDictionary *priceByCompany;

@property (nonatomic, retain) ProductCollectionView *productCollectionView;
@property (nonatomic, retain) AddCompany *AddCompany;
@property (nonatomic, retain) EditCompany *EditCompany;

@end
