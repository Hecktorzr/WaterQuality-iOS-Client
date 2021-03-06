//
//  WQConstants.h
//  WaterQuality
//
//  Created by Hector Zarate on 11/10/12.
//  Copyright (c) 2012 HackWAW. All rights reserved.
//


// Web Services Defaults:
/* ------------------------------------------------------------------------- */
#define kWEB_SERVICE_BASE_URL @"http://192.168.3.107:8000"
/* ------------------------------------------------------------------------- */


// Default settings for Maps
/* ------------------------------------------------------------------------- */

#define kRADIO_BY_DEFAULT_DEGREE_ZERO 0

#define kRADIO_BY_DEFAULT_DEGREE 0.3

#define kDEFAULT_LATITUDE_ 52.2297
#define kDEFAULT_LONGITUDE_ 21.0122
/* ------------------------------------------------------------------------- */


//Notofication defines
/* ------------------------------------------------------------------------- */
#define K_NOTIFICATION_MEASHUREMENT_FOR_LOCATION_COMPLETE @"locationComplet"
#define K_NOTIFICATION_MEASHUREMENT_PARAMETERFOR_LOCATION_COMPLETE @"locationParameterComplete"
#define K_NOTIFICATION_MEASHUREMENTS_LIST_COMPLETE @"locationListComplete"
/* ------------------------------------------------------------------------- */


// Keys and Defaults for Web Service

/* ------------------------------------------------------------------------- */
#define kPARAMETER_KEY_FOR_OFFSET @"offset"
#define kPARAMETER_KEY_FOR_LIMIT @"limit"

#define kDEFAULT_LIMIT_FOR_MEASUREMENTS @"35"
/* ------------------------------------------------------------------------- */

#define kCODE_ICON_NAME_PREFIX @"CodeIcon_"
#define kCODE_ICON_NAME_SUFFIX_LIST @"_list" // using same images as in main view right now
#define kCODE_ICON_NAME_SUFFIX_MAP @"_map"
#define kCODE_ICON_NAME_DEFAULT_INDEX 0

#define kLOADING_VIEW_TAG 8576

// Segues Keys

#define kSEGUE_PRESENT_MEASUREMENTS_DETAILS @"PresentMeasurementDetailsSegue"