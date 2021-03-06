//
//  WQMeasurementDetailsViewController.h
//  WaterQuality
//
//  Created by Hector Zarate on 11/10/12.
//  Copyright (c) 2012 HackWAW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQMeasurementDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSString *measurementID;

-(void)updateUserInterfaceWithMeasurementDetails:(NSArray *)measurementsArray;


@end
