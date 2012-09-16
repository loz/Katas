//
//  playfairTests.m
//  playfairTests
//
//  Created by Jonathan Lozinski on 16/09/2012.
//  Copyright (c) 2012 Jonathan Lozinski. All rights reserved.
//

#import "playfairTests.h"

@implementation playfairTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    NSString *keytext = @"ABCDE"
                         "FGHIK"
                         "LMNOP"
                         "QRSTU"
                         "VWXYZ";
    _subject = [[Playfair alloc] initWithKeyText:keytext];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)assertEncodings:(NSDictionary *)values {
    [values enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        STAssertEqualObjects(obj, [_subject encode:key], @"Expected Encoding Failed");
    }];
}

- (void)testEncodeAsDownshiftForDigraphInColumn
{    
    NSDictionary *values = [[NSDictionary alloc] initWithObjectsAndKeys:@"HS", @"CN",
                            @"RB", @"MW",
                            @"ZP", @"UK", nil];
    [self assertEncodings:values];
}

@end
