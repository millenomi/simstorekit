//
//  TestApp.h
//  SimStoreKit
//
//  Created by ∞ on 03/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ILSimReplaceRealStoreKit 1
#import "ILSimStoreKit.h"

@interface TestApp : NSObject <UIApplicationDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate> {
	IBOutlet UIWindow* window;
}

- (IBAction) buy;

@end
