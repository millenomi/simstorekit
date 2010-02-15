#!/usr/bin/env ruby

def here(h)
    File.join(File.dirname(__FILE__), h)
end

require 'rubygems'
require 'json'

prices = nil
File.open(here("Tiers.json"), "r") { |x| prices = JSON.parse(x.read) }

price_code = ''
locale_code = ''
constants_code = ''
first = true

prices.each do |k,v|
    price_code << "[NSArray arrayWithObjects:\n"
    
    e = v['exponent']
    v['mantissae'].each do |m|
        price_code << "ILSimDec(#{m}, #{e}),\n"
    end
    
    price_code << "nil], @\"#{k}\",\n"
    
    # ~~~
    
    locale_code << 'else ' unless first
    first = false
    locale_code << "if ([s isEqual:@\"#{k}\"])\n\tl = @\"#{v['locales'][0]}\";\n"
    
    # ~~~
    
    constants_code << "NSString* const kILSimStorefront_#{k} = @\"#{k}\";\n"
end

template = '''

//
//  ILSimSKTiers.m
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimSKTiers.h"
#import "ILSimSKPaymentQueue.h"

<# CONSTANTS #>

static NSString* storefront = nil;

static BOOL ILSimSKIsKnownStorefront(NSString* sf) {
	return [sf isEqual:kILSimStorefront_USD] || [sf isEqual:kILSimStorefront_CAD] ||
		[ILSimSKAllTierPricesByStorefront() objectForKey:sf] != nil;
}

NSString* ILSimSKCurrentStorefront() {
	if (!storefront) {
		NSString* e = [[[NSProcessInfo processInfo] environment] objectForKey:kILSimSKStorefrontCodeEnvironmentVariable];
		if (!e || !ILSimSKIsKnownStorefront(e))
			e = kILSimStorefront_USD;
		ILSimSKSetCurrentStorefront(e);
	}
	
	return storefront;
}
	
void ILSimSKSetCurrentStorefront(NSString* s) {
	if (storefront != s) {
		[storefront release];
		storefront = [s copy];
	}
}

#define ILSimDec(mantissaValue, exponentValue) \
	[NSDecimalNumber decimalNumberWithMantissa:(mantissaValue) exponent:(exponentValue) isNegative:NO]

NSDictionary* ILSimSKAllTierPricesByStorefront() {
	static NSDictionary* prices = nil; if (!prices)
		prices =
		[[NSDictionary alloc] initWithObjectsAndKeys:
		  
		  <# PRICES #>
		  
		 nil];
	
	return prices;
}

NSDecimalNumber* ILSimSKPriceAtTierForCurrentStorefront(NSUInteger index) {
	
	NSString* s = ILSimSKCurrentStorefront();
	
	if (index == 0)
		return [NSDecimalNumber zero];

	return [[ILSimSKAllTierPricesByStorefront() objectForKey:s] objectAtIndex:index];
}

NSLocale* ILSimSKLocaleForCurrentStorefront() {
	NSString* l = nil, * s = ILSimSKCurrentStorefront();
	
	<# LOCALES #>
	
	NSCAssert(l, @"Unknown storefront");
	return [[[NSLocale alloc] initWithLocaleIdentifier:l] autorelease];
}

'''

puts template \
    .gsub('<# CONSTANTS #>', constants_code) \
    .gsub('<# PRICES #>', price_code) \
    .gsub('<# LOCALES #>', locale_code)
    