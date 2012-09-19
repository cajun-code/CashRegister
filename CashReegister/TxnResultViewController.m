//
//  TxnResultViewController.m
//  CashReegister
//
//  Created by Kishore on 9/19/12.
//  Copyright (c) 2012 Dealermatch. All rights reserved.
//

#import "TxnResultViewController.h"
#import "KSChange.h"

@interface TxnResultViewController ()

@end

@implementation TxnResultViewController
@synthesize transaction;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)doneReciept:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

    
    self.navigationItem.hidesBackButton = YES;
    self.title = @"Receipt";    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneReciept:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 3;
    else 
        return self.transaction.output.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSNumberFormatter *format = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        format = [[NSNumberFormatter alloc] init]; 
        [format setNumberStyle:NSNumberFormatterCurrencyStyle]; 
    });
    
    static NSString *CellIdentifier1 = @"cell1";
    static NSString *CellIdentifier2 = @"cell2";
    
    UITableViewCell *cell = nil;
    
    if(indexPath.section == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        switch (indexPath.row) {
            case 0:                
                cell.textLabel.text = @"Cash Handed";
                cell.detailTextLabel.text = [format stringFromNumber:self.transaction.cashHanded];
                cell.detailTextLabel.textColor = [UIColor colorWithRed:0.03 green:0.45 blue:0.02 alpha:1];
                break;
            case 1:                
                cell.textLabel.text = @"Purchase Price";             
                cell.detailTextLabel.text = [NSString stringWithFormat:@"-   %@", [format stringFromNumber:self.transaction.purchasePrice]];
                cell.detailTextLabel.textColor = [UIColor colorWithRed:0.45 green:0.03 blue:0.02 alpha:1];                
                break;
            case 2:   
                cell.textLabel.text = @"Change Due";                
                cell.detailTextLabel.text = [NSString stringWithFormat:@"=   %@", [format stringFromNumber:self.transaction.balance]];
                cell.detailTextLabel.textColor = [UIColor colorWithRed:0.03 green:0.03 blue:0.45 alpha:1];                                
                break;
            case 3:                
                cell.textLabel.text = @"";                                
                cell.detailTextLabel.text = @"";
                break;                
        }
    }
    else 
    {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        KSChange *change = [self.transaction.output objectAtIndex:indexPath.row];
        cell.textLabel.text = change.denomination;
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",change.count];
    }
    
    // Configure the cell...
    
    return cell;
}
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return @"Details";
    else {
        return @"Change";
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
