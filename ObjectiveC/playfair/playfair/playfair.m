//
//  playfair.m
//  playfair
//
//  Created by Jonathan Lozinski on 16/09/2012.
//  Copyright (c) 2012 Jonathan Lozinski. All rights reserved.
//

#import "playfair.h"

@implementation Playfair

-(NSString *)charString:(NSString *)string atIndex:(NSInteger)index {
    char keychar;
    keychar = [string characterAtIndex:index];
    return [NSString stringWithFormat:@"%c", keychar];
}

-(NSString *)charAtX:(NSInteger)x andY:(NSInteger)y {
    NSInteger position;
    position = (y*5)+x;
    return [self charString:_keytext atIndex: position];
}

-(id)initWithKeyText:(NSString *)keytext {
    self = [super init];
    _charmap = [[NSMutableDictionary alloc] initWithCapacity:25];
    if(self) {
        _keytext = [keytext copy];
        int pos = (int)[keytext length];
        int i;
        NSNumber *x, *y;
        NSString *character;
        for (i=0; i<pos; i++) {
            x = [NSNumber numberWithInt:(i % 5)];
            y = [NSNumber numberWithInt:(i / 5)];
            NSArray *coord = [[NSArray alloc] initWithObjects:x, y, nil];
            character = [self charString:keytext atIndex:i];
            [_charmap setValue:coord forKey:character];
        }
    }
    return self;
}

-(NSString *)encode:(NSString *)plain {
    NSInteger x, y;
    NSArray *a, *b;
    NSString *enc_a, *enc_b;
    a = [_charmap valueForKey:[self charString:plain atIndex:0]];
    b = [_charmap valueForKey:[self charString:plain atIndex:1]];
    x = [a[0] integerValue];
    y = [a[1] integerValue];
    enc_a = [self charAtX:x andY:((y+1) % 5)];
    x = [b[0] integerValue];
    y = [b[1] integerValue];
    enc_b = [self charAtX:x andY:((y+1) % 5)];
    return [NSString stringWithFormat:@"%@%@", enc_a, enc_b];
}
@end
