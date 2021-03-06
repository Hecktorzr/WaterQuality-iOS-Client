//
//  WQMeasurementMainViewController.m
//  WaterQuality
//
//  Created by Hector Zarate on 11/10/12.
//  Copyright (c) 2012 HackWAW. All rights reserved.
//

#import "WQMeasurementMainViewController.h"
#import "WQWebServiceManager.h"
#import "WQFuelLikeIndicatorView.h"
#import "WQMeasurementDetailsViewController.h"
//#import "UIViewController+LoadingScreen.h"


#define kPERCENT_LABEL_RED_LABEL_LIMIT 20
#define kPERCENT_LABEL_ORANGE_LABEL_LIMIT 40
#define kPERCENT_LABEL_YELLOW_LABEL_LIMIT 60
#define kPERCENT_LABEL_DARK_GREEN_LABEL_LIMIT 80
#define kPERCENT_LABEL_GREEN_LABEL_LIMIT 100

@interface WQMeasurementMainViewController (Private)

-(void)setIconImageForCode:(NSInteger)code;
-(void)setPercentLabelForPercentage:(NSInteger)percentage;

-(void)requestMeasurementForLocation: (CLLocation *)location;

@end



@implementation WQMeasurementMainViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_iconImageView release];
    [_persentLabel release];
    [_placeNameLabel release];
    [_descriptionTextView release];
    [_qualityStripesView release];
    [_displayedMeasurement release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)presentMeasurementsDetails:(id)sender
{
    [self performSegueWithIdentifier:kSEGUE_PRESENT_MEASUREMENTS_DETAILS sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *targetView = nil;
    
    if ([segue.identifier isEqualToString:kSEGUE_PRESENT_MEASUREMENTS_DETAILS])
    {
        ((WQMeasurementDetailsViewController *)[segue destinationViewController]).measurementID = [self.displayedMeasurement valueForKey:@"pk"];
        
    }
    else
    {
        NSLog(@"Unrecognized Segue");
        
    }
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

-(void)setPercentLabelForPercentage:(NSInteger)percentage
{
    self.persentLabel.text = [NSString stringWithFormat:@"%d%%", percentage];
    
    NSArray *colorsForLabel = [NSArray arrayWithObjects: [UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor greenColor],  nil];
    
    int indexForColorLabel = lroundf(percentage / (100 / [colorsForLabel count]));
    
//    self.persentLabel.textColor = [colorsForLabel objectAtIndex:indexForColorLabel];
}

-(void)setIconImageForCode:(NSInteger)code
{
    NSString *iconImageName = [NSString stringWithFormat:@"%@%d", kCODE_ICON_NAME_PREFIX, code];
    
    UIImage *result = [UIImage imageNamed:iconImageName];
    
    if (!result)
    {
        iconImageName = [NSString stringWithFormat:@"%@%d", kCODE_ICON_NAME_PREFIX, kCODE_ICON_NAME_DEFAULT_INDEX];
        result = [UIImage imageNamed:iconImageName];
        NSLog(@"Warning: Unrecognized Code Image");
    }

    self.iconImageView.image = result;
    
}

-(void)updateUserInterfaceWithMeasurement:(NSDictionary *)dictionary
{
    self.displayedMeasurement = dictionary;
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    int waterQualityPercentage = [[dictionary valueForKey:@"quality"] intValue];
    
    [self setIconImageForCode:[[dictionary valueForKey:@"code"] intValue]];
    [self setPercentLabelForPercentage: waterQualityPercentage];
    [self.qualityStripesView updateFuelIndicatorWithPercent:waterQualityPercentage]
    ;    self.placeNameLabel.text = [dictionary valueForKey:@"locationName"];
    self.descriptionTextView.text = [dictionary valueForKey:@"comment"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Water Quality Here";
    
    if (!self.dontCalculateUserLocation)
    {
        CLLocationManager *locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager startMonitoringSignificantLocationChanges];
    }else
        [self updateUserInterfaceWithMeasurement:self.displayedMeasurement];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)receivedWebServiceManagerNotification:(NSNotification *)notification
{
    
//    [self hideLoadingScreen];
    NSLog(@"So this is the response: %@", notification.userInfo);
    [self updateUserInterfaceWithMeasurement:notification.userInfo];
}

-(void)requestMeasurementForLocation:(CLLocation *)location
{
//    [self showLoadingScreen];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedWebServiceManagerNotification:)
                                                 name:K_NOTIFICATION_MEASHUREMENT_FOR_LOCATION_COMPLETE
                                               object:nil];
    
    [[WQWebServiceManager sharedWebServiceManager] getMeasurementForLocation:location];
}

#pragma mark - LocationManager

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self requestMeasurementForLocation:newLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self requestMeasurementForLocation:[locations lastObject]];
}


@end
