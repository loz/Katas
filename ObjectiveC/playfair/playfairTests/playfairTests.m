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

- (void)testEncodAsRightshiftedForDigraphInRow {
    NSDictionary *values = [[NSDictionary alloc] initWithObjectsAndKeys:@"BC", @"AB",
                            @"FH", @"KG",
                            @"RT", @"QS", nil];
    [self assertEncodings:values];
}

- (void)testEncodeOppositeCornersForRectangle {
    NSDictionary *values = [[NSDictionary alloc] initWithObjectsAndKeys:@"AZ", @"EV",
                            @"GP", @"KM",
                            @"YB", @"WD", nil];
    [self assertEncodings:values];
}

- (void)testEncodesDigraphPairs {
    NSString *expected, *actual, *plaintext;
    plaintext = @"CNABEV";
    expected  = @"HSBCAZ";
    actual = [_subject encode:plaintext];
    
    STAssertEqualObjects(expected, actual, @"expected to encode digraph pairs");
}

-(void)testPadsIdenticalDigraphLettersWithX {
    STAssertEqualObjects([_subject encode:@"TREE"],
                         [_subject encode:@"TREXE"],
                         @"expected to X-pad");
    STAssertFalse([_subject encode:@"TOO"] == [_subject encode:@"TOXO"],
                  @"expected to not X-pad");
}

-(void)testPadsOddLastDigraphWithZ {
    STAssertEqualObjects([_subject encode:@"ONE"],
                         [_subject encode:@"ONEZ"],
                         @"expected to Z-pad");
}
@end
