//
//  EditProduct.m
//  NavCtrl
//
//  Created by Aditya Narayan on 1/13/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "EditProduct.h"

@interface EditProduct ()

@end

@implementation EditProduct

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.productName.text = self.title;
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
- (IBAction)renameProduct:(id)sender {
    [[DAO sharedManager]editProduct:self.productName.text fromName:self.title forCompany:self.company];
    [DAO release];
    [self.navigationController popViewControllerAnimated:YES];
    //[self dealloc];
}
@end
