//
//  ILSimTransactionSimulator.m
//  SimStoreKit
//
//  Created by ∞ on 13/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ILSimTransactionSimulator.h"
#if kILSimAllowSimulatedStoreKit

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static char kILSimDefaultTransactionSimulator_iOSCompletionHandlerToken = 0;
static void* const kILSimDefaultTransactionSimulator_iOSCompletionHandlerKey = &kILSimDefaultTransactionSimulator_iOSCompletionHandlerToken;

@interface ILSimDefaultTransactionSimulator_iOS : NSObject <ILSimTransactionSimulator, UIAlertViewDelegate>
@end

@implementation ILSimDefaultTransactionSimulator_iOS

- (void) simulateTransaction:(ILSimSKPaymentTransaction *)transaction product:(ILSimSKProduct*) p forQueue:(ILSimSKPaymentQueue *)queue completionHandler:(void (^)(NSError *))block;
{
	UIAlertView* a = [[UIAlertView new] autorelease];
	a.delegate = self;
	objc_setAssociatedObject(a, kILSimDefaultTransactionSimulator_iOSCompletionHandlerKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
	
	NSNumberFormatter* numberFormatter = [[NSNumberFormatter new] autorelease];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setLocale:p.priceLocale];
	NSString* formattedPrice = [numberFormatter stringFromNumber:p.price];
	
	a.title = [NSString stringWithFormat:@"SIMULATED: Would you like to buy %d x '%@' at %@?", transaction.payment.quantity, p.localizedTitle, formattedPrice];
	[a addButtonWithTitle:@"Succeed Transaction"];
	[a addButtonWithTitle:@"Fail Transaction"];
	a.cancelButtonIndex = [a addButtonWithTitle:@"Cancel"];
	[a show];	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
	void (^completionHandler)(NSError*) = objc_getAssociatedObject(alertView, kILSimDefaultTransactionSimulator_iOSCompletionHandlerKey);
	if (!completionHandler)
		return;
	
	switch (buttonIndex) {
		case 0:
			completionHandler(nil);
			break;
		case 1:
			completionHandler([NSError errorWithDomain:kILSimSKErrorDomain code:kILSimSKErrorUnknown userInfo:nil]);
			break;
		case 2:
		default:
			completionHandler([NSError errorWithDomain:kILSimSKErrorDomain code:kILSimSKErrorPaymentCancelled userInfo:nil]);
			break;
	}
}

@end

#elif TARGET_OS_MAC && !TARGET_OS_IPHONE

#import <Cocoa/Cocoa.h>

@interface ILSimDefaultTransactionSimulator_Mac : NSObject <ILSimTransactionSimulator>
@end

@implementation ILSimDefaultTransactionSimulator_Mac

- (void) simulateTransaction:(ILSimSKPaymentTransaction *)transaction product:(ILSimSKProduct*) p forQueue:(ILSimSKPaymentQueue *)queue completionHandler:(void (^)(NSError *))block;
{
	NSAlert* a = [[NSAlert new] autorelease];
	
	NSNumberFormatter* numberFormatter = [[NSNumberFormatter new] autorelease];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setLocale:p.priceLocale];
	NSString* formattedPrice = [numberFormatter stringFromNumber:p.price];
	
	[a setMessageText:[NSString stringWithFormat:@"Simulated StoreKit: Would you like to buy %d x '%@' at %@?", transaction.payment.quantity, p.localizedTitle, formattedPrice]];

	[a addButtonWithTitle:@"Succeed Transaction"];
	[a addButtonWithTitle:@"Cancel"];
	[a addButtonWithTitle:@"Fail Transaction"];

	NSInteger result = [a runModal];
	switch (result) {
		case NSAlertFirstButtonReturn:
			block(nil);
			break;
			
		case NSAlertSecondButtonReturn:
			block([NSError errorWithDomain:kILSimSKErrorDomain code:kILSimSKErrorUnknown userInfo:nil]);
			break;
			
		case NSAlertThirdButtonReturn:
			block([NSError errorWithDomain:kILSimSKErrorDomain code:kILSimSKErrorUnknown userInfo:nil]);
			break;
	}
}

@end

#endif


id <ILSimTransactionSimulator> ILSimDefaultTransactionSimulator() {
	static id simulator = nil; if (!simulator) {
#if TARGET_OS_IPHONE
		simulator = [ILSimDefaultTransactionSimulator_iOS new];
#elif TARGET_OS_MAC && !TARGET_OS_IPHONE
		simulator = [ILSimDefaultTransactionSimulator_Mac new];
#endif
	}
	
	return simulator;
}


#endif // kILSimAllowSimulatedStoreKit
