//
//  AddProduct.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/12/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "AddProduct.h"

@interface AddProduct ()

@end

@implementation AddProduct

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_productName release];
    [super dealloc];
}

- (IBAction)finishNewProduct:(id)sender {
    NSString *name = self.productName.text;
    [[DAO sharedManager]addProduct:name forCompany:self.companyName];
   // [DAO release];
    [self.navigationController popViewControllerAnimated:YES];
    //[self dealloc];
}
@end
