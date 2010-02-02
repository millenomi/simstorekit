//
//  ILSimSKRequest.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ILSimSKProduct.h"
#import "ILSimSKRequest.h"

@protocol ILSimSKRequestDelegate;

@interface ILSimSKRequest : NSObject {

}

- (void) start;
- (void) cancel;

@property(assign) id <ILSimSKRequestDelegate> delegate;

@end



@protocol ILSimSKRequestDelegate <NSObject>

- (void)request:(ILSimSKRequest *)request didFailWithError:(NSError *)error;
- (void)requestDidFinish:(ILSimSKRequest *)request;

@end