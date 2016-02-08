//
//  AddProduct.h
//  NavCtrl
//
//  Created by Aditya Narayan on 1/12/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "ProductWebViewViewController.h"

@interface AddProduct : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *productName;
@property (retain, nonatomic) NSString *companyName;

- (IBAction)finishNewProduct:(id)sender;

@end
