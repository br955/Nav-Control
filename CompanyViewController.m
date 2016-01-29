//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.title = @"Mobile device makers";
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPresser:)];
    [self.view addGestureRecognizer:longPress];
    [longPress release];
}

-(void) viewWillAppear:(BOOL)animated{
    self.companyList = [NSMutableArray arrayWithArray:[[DAO sharedManager] getCompanyData]];
    //[DAO release];
    [self.tableView reloadData];
    
    self.stockPriceUrl = @"http://finance.yahoo.com/d/quotes.csv?s=";
    for (int i = 0; i<self.companyList.count; i++) {
        if ([self.companyList[i] valueForKey:@"stockSymbol"]!=nil) {
            self.stockPriceUrl = [self.stockPriceUrl stringByAppendingString:[self.companyList[i] valueForKey:@"stockSymbol"]];
            self.stockPriceUrl = [self.stockPriceUrl stringByAppendingString:@"+"];
        }
    }
    
    
    self.stockPriceUrl = [self.stockPriceUrl stringByAppendingString:@"&f=a"];
    
    NSURL *stockDataURL = [NSURL URLWithString:self.stockPriceUrl];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:stockDataURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
        //Convert csv to string
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        if (data == nil) {
            NSLog(@"Error storing --- data is nil");
            NSLog(@"Domain: %@", error.domain);
            NSLog(@"Error Code: %ld", (long)error.code);
            NSLog(@"Description: %@", [error localizedDescription]);
            NSLog(@"Reason: %@", [error localizedFailureReason]);
            NSLog(@"Company  Updated");
            [dataString release]; dataString = nil;
            
        }else {
            int i = 0;
            NSArray *temp = [dataString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            NSMutableArray *companyAndStockPrices = [NSMutableArray arrayWithArray:temp];
            while (i<companyAndStockPrices.count) {
                if ([companyAndStockPrices[i] isEqualToString: @""]) {
                    [companyAndStockPrices removeObjectAtIndex:i];
                }
                i++;
            }
            [dataString release]; dataString = nil;
            
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[stockCompanies release];
                    //[companyAndStockPrices release];
                    //[self.priceByCompany autorelease];
                    [self.tableView reloadData];
                });
            }
        }
        
    }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [[self.companyList objectAtIndex:[indexPath row]] valueForKey:@"name" ];
    cell.imageView.image = [UIImage imageNamed:@"defaulticon.jpeg"];
    cell.detailTextLabel.text = [self.priceByCompany valueForKey:[[self.companyList objectAtIndex:[indexPath row]] valueForKey:@"name"]];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Company *tempCompany =  self.companyList[indexPath.row];
        [[DAO sharedManager]deleteCompany: tempCompany.name];
        [self.companyList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSObject *stringToMove = [self.companyList objectAtIndex:fromIndexPath.row];
    
    [self.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.companyList insertObject:stringToMove atIndex:toIndexPath.row];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        self.productViewController.title = [[self.companyList objectAtIndex:[indexPath row]] valueForKey:@"name"];
        self.productViewController.products = [[self.companyList objectAtIndex:[indexPath row]] valueForKey:@"productList"];
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
}


-(void) addButtonPressed {
    
    self.AddCompany = [[AddCompany alloc] initWithNibName:@"AddCompany" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:self.AddCompany animated:YES];
    [self.AddCompany release];
}

-(void)longPresser:(UILongPressGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [gestureRecognizer locationInView:self.tableView];
        NSIndexPath *touchedIndexPath = [self.tableView indexPathForRowAtPoint:location];
        self.EditCompany = [[EditCompany alloc]initWithNibName:@"EditCompany" bundle:[NSBundle mainBundle]];
        self.EditCompany.title = [[self.companyList objectAtIndex:[touchedIndexPath row]] valueForKey:@"name"];
        [self.navigationController pushViewController:self.EditCompany animated:YES];
        [self.EditCompany release];
    }
}


@end








