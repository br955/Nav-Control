//
//  EditCompany.h
//  NavCtrl
//
//  Created by Aditya Narayan on 1/13/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface EditCompany : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *editText;
- (IBAction)finishEditing:(id)sender;

@end
