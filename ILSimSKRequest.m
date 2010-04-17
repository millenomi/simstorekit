//
//  ILSimSKRequest.m
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit


#import "ILSimSKRequest.h"


@implementation ILSimSKRequest

- (void) start {}
- (void) cancel {}

@dynamic delegate;

@end

#endif // #if kILSimAllowSimulatedStoreKit

