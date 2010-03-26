# Simulated StoreKit

The sources in this repository simulate Apple's StoreKit framework. 

First of all, this code is available under the CC0 license (which, to be blunt, means it's public domain). Legalities:

<p xmlns:dct="http://purl.org/dc/terms/" xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#" style="border: 1px solid black; text-align: center">
  <a rel="license" href="http://creativecommons.org/publicdomain/zero/1.0/">
    <img src="http://i.creativecommons.org/l/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />
  </a>
  <br />
  To the extent possible under law, <a href="http://infinite-labs.net/me/" rel="dct:publisher"><span property="dct:title">Emanuele Vulcano</span></a>
  has waived all copyright and related or neighboring rights to
  <span property="dct:title">Simulated StoreKit</span>.
This work is published from
<span about="http://infinite-labs.net/me/" property="vcard:Country" datatype="dct:ISO3166" content="IT">Italy</span>.
</p>

There. Legalities are done. Let's get to it.

## What does this do

This code reimplements the contract of Apple's StoreKit framework exactly, except that it prefixes all classes, protocols and constants with `ILSim` or `kILSim` (constants only). This can be used to test a IAP app in the simulator, for example, or to provide beta testers a IAP-based app without requiring them to have IAP test accounts or make purchases. Sky's the limit.

Additionally, the ILSimStoreKit.h header includes a set of preprocessor definitions that can be used to switch an app written for StoreKit (using `SK…` symbols) to SimStoreKit transparently.

## How to use it

Write an app that uses StoreKit.

Where you would import StoreKit, replace:
	
	#import <StoreKit/StoreKit.h>
	
with

	#define ILSimReplaceRealStoreKit 1
	#import "ILSimStoreKit.h"
	
Also make sure you compile all the `.m` files of SimStoreKit in your app, and that all `.h` files are on the headers path. (The easiest way is to simply drag them all into your project, but see the next section for caveats.)

The library needs to simulate the IAP server using a property list of products, which is set using environment variables (in Xcode, use Project > Edit Active Executable and look in the second tab to set them up). Env variables you can use and the expected format for the products list are documented at the top of `ILSimSKPaymentQueue.h`.
	
## This is for testing only!

Do not ship apps containing this code! (Duh!) Currently, SimStoreKit does not have a way to remove itself from the build for release builds, so you'll have to make up something on your own (editing the implementation files to have a `#if AllowSimStoreKit` or other preprocessor tricks are probably the way to go).