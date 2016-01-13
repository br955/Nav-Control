//
//  EditProduct.h
//  NavCtrl
//
//  Created by Aditya Narayan on 1/13/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface EditProduct : UIViewController


@property (nonatomic, retain) NSString *company;
@property (retain, nonatomic) IBOutlet UITextField *productName;

- (IBAction)renameProduct:(id)sender;

@end
