//
//  CompanyCollectionView.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/5/16.
//  Copyright (c) 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionView.h"

@interface CompanyCollectionView ()

@end

@implementation CompanyCollectionView

static NSString * const reuseIdentifier = @"CollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    // Uncomment the following line to preserve selection between presentations
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
   
    // Do any additional setup after loading the view.
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detectSwipeGesture:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];
    [swipeRecognizer release]; swipeRecognizer = nil;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.title = @"Mobile device makers";
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPresser:)];
    [self.view addGestureRecognizer:longPress];
    [longPress release];
    

    
    [self reloadInputViews];
}

-(void)viewWillAppear:(BOOL)animated{
    self.companyList = [NSMutableArray arrayWithArray:[[DAO sharedManager] getCompanyData]];
    
    [self.collectionView reloadData];
    [self setStockPrices];
//    NSTimer* myTimer = [NSTimer scheduledTimerWithTimeInterval: 60.0 target: self
//                                                      selector: @selector(setStockPrices) userInfo: nil repeats: YES];
//    
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
    return [self.companyList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.name.text = [[self.companyList objectAtIndex:[indexPath row]] name ];
    cell.stockPrice.text = [self.priceByCompany valueForKey:[[self.companyList objectAtIndex:[indexPath row]] name]];
    cell.layer.borderWidth = 8;
    cell.layer.borderColor = [[UIColor colorWithRed:173/255.0f green:34/255.0f blue:35/255.0f alpha:1]CGColor];
    
    return cell;
}

-(void) addButtonPressed {
    
    self.AddCompany = [[AddCompany alloc] initWithNibName:@"AddCompany" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:self.AddCompany animated:YES];
    [self.AddCompany release];
}

-(void)longPresser:(UILongPressGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [gestureRecognizer locationInView:self.collectionView];
        NSIndexPath *touchedIndexPath = [self.collectionView indexPathForItemAtPoint:location];
        self.EditCompany = [[EditCompany alloc]initWithNibName:@"EditCompany" bundle:[NSBundle mainBundle]];
        self.EditCompany.title = [[self.companyList objectAtIndex:[touchedIndexPath row]] valueForKey:@"name"];
        [self.navigationController pushViewController:self.EditCompany animated:YES];
        [self.EditCompany release];
    }
}

-(void)detectSwipeGesture: (UISwipeGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateEnded && recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [recognizer locationInView:self.collectionView];
        NSIndexPath *touchedIndexPath = [self.collectionView indexPathForItemAtPoint:location];
        Company *tempCompany =  self.companyList[touchedIndexPath.row];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Company" message:@"Do you want to delete this company?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:@"Delete Company"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 long i = [tempCompany.productList count]-1;
                                                                 while (i>=0) {
                                                                     [[DAO sharedManager] deleteProduct: [tempCompany.productList[i] name] fromCompany:tempCompany.name];
                                                                     i--;
                                                                 }
                                                                 [[DAO sharedManager] deleteCompany: tempCompany.name];
                                                                 [self.companyList removeObjectAtIndex:
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCollectionView *viewController = [[ProductCollectionView alloc] initWithNibName:@"ProductCollectionView" bundle:nil];
    self.productCollectionView = viewController;
    [viewController release]; viewController = nil;
    
    self.productCollectionView.title = [[self.companyList objectAtIndex:[indexPath row]] name];
    self.productCollectionView.companyID = [NSNumber numberWithLong:[indexPath row]]; // more like array ID
    [self.navigationController
     pushViewController:self.productCollectionView
     animated:YES];

}

-(void) setStockPrices{
    NSLog(@"updating stock prices");
    self.stockPriceUrl = @"http://finance.yahoo.com/d/quotes.csv?s=";
    for (int i = 0; i<self.companyList.count; i++) {
        if ([self.companyList[i] valueForKey:@"stockSymbol"]!=nil) {
            self.stockPriceUrl = [self.stockPriceUrl stringByAppendingString:[self.companyList[i] valueForKey:@"stockSymbol"]];
            self.stockPriceUrl = [self.stockPriceUrl stringByAppendingString:@"+"];
        }
    }
    
    
    self.stockPriceUrl = [self.stockPriceUrl stringByAppendingString:@"&f=a"];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [sessionManager GET:self.stockPriceUrl parameters:nil progress:nil success:^(NSURLSessionTask *task,
                                                                                 id responseObject) {
        
        NSString *dataString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSArray *temp =[dataString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        NSMutableArray *companyAndStockPrices = [NSMutableArray arrayWithArray:temp];
        [dataString release]; dataString = nil;
        int i = 0;
        while (i<companyAndStockPrices.count) {
            if ([companyAndStockPrices[i] isEqualToString: @""]) {
                [companyAndStockPrices removeObjectAtIndex:i];
            }
            i++;
        }
        NSMutableArray *stockCompanies = [NSMutableArray arrayWithCapacity:10];
        
        i = 0;
        while (i < self.companyList.count) {
            [stockCompanies addObject:[[self.companyList valueForKey:@"name"] objectAtIndex:i]];
            if ([[[self.companyList objectAtIndex:i]valueForKey:@"stockSymbol"] isEqualToString:@""]) {
                [stockCompanies removeObject:[[self.companyList objectAtIndex:i]valueForKey:@"name"]];
            }
            i++;
        }
        if (companyAndStockPrices.count == stockCompanies.count) {
            self.priceByCompany = [[NSMutableDictionary alloc]initWithObjects:companyAndStockPrices forKeys:stockCompanies];
        }
        [self.collectionView reloadData];
        
    }failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %ld", (long)error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
        NSLog(@"Reason: %@", [error localizedFailureReason]);
    }];
    
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