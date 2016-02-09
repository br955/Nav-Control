//
//  ProductCollectionView.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/8/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "ProductCollectionView.h"

@interface ProductCollectionView ()

@end

@implementation ProductCollectionView

static NSString * const reuseIdentifier = @"ProductCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[ProductCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPresser:)];
    [self.view addGestureRecognizer:longPress];
    [longPress release];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detectSwipeGesture:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];
    [swipeRecognizer release]; swipeRecognizer = nil;

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.companyList = [NSMutableArray arrayWithArray:[[DAO sharedManager]getCompanyData]];
    self.products = [[self.companyList objectAtIndex:([self.companyID integerValue]-1)] productList];
    [self.collectionView reloadData];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.products count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // Configure the cell
    cell.name.text = [[self.products objectAtIndex:[indexPath row]] name];
    cell.layer.borderWidth = 8;
    cell.layer.borderColor = [[UIColor colorWithRed:173/255.0f green:34/255.0f blue:35/255.0f alpha:1]CGColor];
    return cell;
}

-(void)addButtonPressed{
    self.AddProduct = [[AddProduct alloc] initWithNibName:@"AddProduct" bundle:[NSBundle mainBundle]];
    self.AddProduct.companyName = self.title;
    [self.navigationController pushViewController:self.AddProduct animated:YES];
    [self.AddProduct autorelease];
    
}

-(void)longPresser:(UILongPressGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [gestureRecognizer locationInView:self.collectionView];
        NSIndexPath *touchedIndexPath = [self.collectionView indexPathForItemAtPoint:location];
        
        self.EditProduct = [[EditProduct alloc]initWithNibName:@"EditProduct" bundle:[NSBundle mainBundle]];
        self.EditProduct.title = [[self.products objectAtIndex:[touchedIndexPath row]] valueForKey:@"name"];
        self.EditProduct.company = self.title;
        [self.navigationController pushViewController:self.EditProduct animated:YES];
        [self.EditProduct autorelease];
    }
}

-(void)detectSwipeGesture: (UISwipeGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded && recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [recognizer locationInView:self.collectionView];
        NSIndexPath *touchedIndexPath = [self.collectionView indexPathForItemAtPoint:location];
        Product *tempProduct =  self.products[touchedIndexPath.row];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Product" message:@"Do you want to delete this product?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:@"Delete Product"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 [[DAO sharedManager] deleteProduct: tempProduct.name];
                                                                 [self.products removeObjectAtIndex:
                                                                  touchedIndexPath.row];
                                                                 [self.collectionView reloadData];
                                                                 
                                                             }];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
        [alertController addAction:actionDelete];
        [alertController addAction:actionCancel];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    
    ProductWebViewViewController *temp = [[ProductWebViewViewController alloc] initWithNibName:@"ProductWebViewViewController" bundle:[NSBundle mainBundle]];
    self.page = temp;
    [temp release];
    
    self.page.URLName = [[self.products objectAtIndex:[indexPath row]]valueForKey:@"siteURL"];
    
    
    [self.navigationController pushViewController: self.page animated:YES];
    
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
