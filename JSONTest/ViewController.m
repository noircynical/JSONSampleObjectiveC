//
//  ViewController.m
//  JSONTest
//
//  Created by noirCynical on 2015. 3. 26..
//  Copyright (c) 2015년 LuceteK. All rights reserved.
//

#import "ViewController.h"
#import "tableCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> // so important

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // get width and height value from application
    self.width= [[UIScreen mainScreen] bounds].size.width;
    self.height= [[UIScreen mainScreen] bounds].size.height;
    
    // set up the table view for displaying content
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.width, self.height-20) style:UITableViewStylePlain];
    // set delegate and datasource of table view ( so important )
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    // add table view created above into main view
    [self.view addSubview:self.tableView];
    
    // read data method ( below method )
    [self getData];
}

-(void)getData{
    NSError *error= nil;
    // file name : test.json  in Supporting Files
    NSString *file= [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *data= [NSData dataWithContentsOfFile:file];
    NSDictionary *json= [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if(error != nil)
        NSLog(@"json parsing error");
    else{
        self.array= [[NSMutableArray alloc] initWithCapacity:3];
        
        NSMutableArray* arr1= [[NSMutableArray alloc] initWithCapacity:5];
        for (NSDictionary *item in json[@"Monday"]){
            tableCell *cell= [[tableCell alloc] init];
            [cell setTitle:[item objectForKey:@"title"]];
            [cell setSpeaker:[item objectForKey:@"speaker"]];
            [cell setTime:[item objectForKey:@"time"]];
            [cell setRoom:[item objectForKey:@"room"]];
            [cell setDetails:[item objectForKey:@"details"]];
            // get image from url, uri in (key - image) of item
            [cell setImage:[UIImage imageWithData:[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [item objectForKey:@"image"]]]]];
            
            [arr1 addObject:cell];
        }
        [self.array addObject:arr1];
        
        arr1= [[NSMutableArray alloc] initWithCapacity:5];
        for (NSDictionary *item in json[@"Tuesday"]){
            tableCell *cell= [[tableCell alloc] init];
            [cell setTitle:[item objectForKey:@"title"]];
            [cell setSpeaker:[item objectForKey:@"speaker"]];
            [cell setTime:[item objectForKey:@"time"]];
            [cell setRoom:[item objectForKey:@"room"]];
            [cell setDetails:[item objectForKey:@"details"]];
            [cell setImage:[UIImage imageWithData:[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [item objectForKey:@"image"]]]]];
            
            [arr1 addObject:cell];
        }
        [self.array addObject:arr1];
        
        arr1= [[NSMutableArray alloc] initWithCapacity:5];
        for (NSDictionary *item in json[@"Wednesday"]){
            tableCell *cell= [[tableCell alloc] init];
            [cell setTitle:[item objectForKey:@"title"]];
            [cell setSpeaker:[item objectForKey:@"speaker"]];
            [cell setTime:[item objectForKey:@"time"]];
            [cell setRoom:[item objectForKey:@"room"]];
            [cell setDetails:[item objectForKey:@"details"]];
            [cell setImage:[UIImage imageWithData:[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [item objectForKey:@"image"]]]]];
            
            [arr1 addObject:cell];
        }
        [self.array addObject:arr1];
    }
    
    // update the table view to put data
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// for table view-------------------------------------------------------------------------------

// number of section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.array count];
}

// number of table cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.array objectAtIndex:section] count];
}

// put content into table cell by index
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // set id of table cell
    static NSString *cellIdentifier = @"tableCell";
    
    UITableViewCell *cell= (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // get data from array( the data saved above method 'get data')
    tableCell* dic= [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    if (cell == nil)
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    // create view
    UIImageView *imgImageView= [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 120, 120)];
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(130, 5, self.width-135, 20)];
    UILabel *speakerLabel= [[UILabel alloc] initWithFrame:CGRectMake(130, 30, self.width-135, 20)];
    UILabel *timeLabel= [[UILabel alloc] initWithFrame:CGRectMake(130, 55, self.width-135, 20)];
    UILabel *roomLabel= [[UILabel alloc] initWithFrame:CGRectMake(130, 80, self.width-135, 20)];
    UILabel *detailsLabel= [[UILabel alloc] initWithFrame:CGRectMake(130, 105, self.width-135, 20)];
    
    // set content into view
    [imgImageView setImage:dic.image];
    
    [titleLabel setText:dic.title];
    // set text alignment
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    // set text color
    [titleLabel setTextColor:[UIColor colorWithRed:88/255.0 green:140/255.0 blue:115/255.0 alpha:1.0]];
    
    [speakerLabel setText:dic.speaker];
    [speakerLabel setTextAlignment:NSTextAlignmentRight];
    
    [timeLabel setText:dic.time];
    [timeLabel setTextAlignment:NSTextAlignmentRight];
    
    [roomLabel setText:dic.room];
    [roomLabel setTextAlignment:NSTextAlignmentRight];
    
    [detailsLabel setText:dic.details];
    // set text line break mode
    [detailsLabel setLineBreakMode:NSLineBreakByTruncatingMiddle];
    [detailsLabel setTextColor:[UIColor colorWithRed:87/255.0 green:124/255.0 blue:159/255.0 alpha:1.0]];

    // add view created above by code into the cell of table view
    [cell addSubview:imgImageView];
    [cell addSubview:titleLabel];
    [cell addSubview:speakerLabel];
    [cell addSubview:timeLabel];
    [cell addSubview:roomLabel];
    [cell addSubview:detailsLabel];
    
    return cell;
}

// set section of table view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50.0)];
    sectionHeaderView.backgroundColor = [UIColor colorWithRed:88/255.0 green:140/255.0 blue:115/255.0 alpha:1.0];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, self.width-30, 25.0)];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor= [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    switch (section) {
        case 0:
            headerLabel.text = @"Monday";
            break;
        case 1:
            headerLabel.text = @"Tuesday";
            break;
        case 2:
            headerLabel.text = @"Wednesday";
            break;
        default:
            break;
    }
    
    [sectionHeaderView addSubview:headerLabel];
    return sectionHeaderView;
}

// set height of table view cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

// set height of table view section cell
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

@end
