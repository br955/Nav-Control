//
//  AddCompany.h
//  NavCtrl
//
//  Created by Aditya Narayan on 1/12/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "CompanyViewController.h"
#import "ProductWebViewViewController.h"

@interface AddCompany : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *companyName;

- (IBAction)finishNamingCompany:(id)sender;


@end
