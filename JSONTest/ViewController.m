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
        self.array= [[NSMutableArray alloc] initWithCapacity:20];
        
        for (NSDictionary *item in json[@"Monday"]){
            tableCell *cell= [[tableCell alloc] init];
            [cell setTitle:[item objectForKey:@"title"]];
            [cell setSpeaker:[item objectForKey:@"speaker"]];
            [cell setTime:[item objectForKey:@"time"]];
            [cell setRoom:[item objectForKey:@"room"]];
            [cell setDetails:[item objectForKey:@"details"]];
            
            [self.array addObject:cell];
        }
        
        for (NSDictionary *item in json[@"Tuesday"]){
            tableCell *cell= [[tableCell alloc] init];
            [cell setTitle:[item objectForKey:@"title"]];
            [cell setSpeaker:[item objectForKey:@"speaker"]];
            [cell setTime:[item objectForKey:@"time"]];
            [cell setRoom:[item objectForKey:@"room"]];
            [cell setDetails:[item objectForKey:@"details"]];
            
            [self.array addObject:cell];
        }
        
        for (NSDictionary *item in json[@"Wednesday"]){
            tableCell *cell= [[tableCell alloc] init];
            [cell setTitle:[item objectForKey:@"title"]];
            [cell setSpeaker:[item objectForKey:@"speaker"]];
            [cell setTime:[item objectForKey:@"time"]];
            [cell setRoom:[item objectForKey:@"room"]];
            [cell setDetails:[item objectForKey:@"details"]];
            
            [self.array addObject:cell];
        }
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
    return 1;
}

// number of table cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array count];
}

// put content into table cell by index
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // set id of table cell
    static NSString *cellIdentifier = @"tableCell";
    
    UITableViewCell *cell= (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // get data from array( the data saved above method 'get data')
    tableCell* dic= [self.array objectAtIndex:indexPath.row];
    
    if (cell == nil)
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    // create view
    UILabel *titleLabel= [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.width, 20)];
    UILabel *speakerLabel= [[UILabel alloc] initWithFrame:CGRectMake(5, 30, self.width, 20)];
    UILabel *timeLabel= [[UILabel alloc] initWithFrame:CGRectMake(5, 55, self.width, 20)];
    UILabel *roomLabel= [[UILabel alloc] initWithFrame:CGRectMake(5, 80, self.width, 20)];
    UILabel *detailsLabel= [[UILabel alloc] initWithFrame:CGRectMake(5, 105, self.width, 20)];
    
    // set content into view
    [titleLabel setText:dic.title];
    [speakerLabel setText:dic.speaker];
    [timeLabel setText:dic.time];
    [roomLabel setText:dic.room];
    [detailsLabel setText:dic.details];

    // add view created above by code into the cell of table view
    [cell addSubview:titleLabel];
    [cell addSubview:speakerLabel];
    [cell addSubview:timeLabel];
    [cell addSubview:roomLabel];
    [cell addSubview:detailsLabel];
    
    return cell;
    
}

// set height of table view cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

@end
