//
//  WQMeasurementsAbstractViewController.h
//  WaterQuality
//
//  Created by Hector Zarate on 11/10/12.
//  Copyright (c) 2012 HackWAW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQMeasurementsAbstractViewController : UIViewController

-(UIImage *)listIconForMeasurementWithCode:(NSInteger)theCode;
-(UIImage *)mapIconForMeasurementWithCode:(NSInteger)theCode;

@end
