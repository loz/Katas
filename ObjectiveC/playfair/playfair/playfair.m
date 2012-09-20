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

-(BOOL)isInColumn:(NSArray *)a withB:(NSArray *)b {
    return [a[0] integerValue] == [b[0] integerValue];
}

-(BOOL)isInRow:(NSArray *)a withB:(NSArray *)b {
    return [a[1] integerValue] == [b[1] integerValue];
}

-(NSString *)encode:(NSString *)plain {
    plain = [self padString:plain];
    NSMutableString *encoded = [[NSMutableString alloc] initWithString:@""];
    NSString *digraph;
    NSArray *digraphs;
    digraphs = [self splitDigraphs:plain];
    for (digraph in digraphs) {
        [encoded appendString:[self encodeDigraph:digraph]];
    }
    return encoded;
}

-(NSString *)padString:(NSString *)plain {
    if (([plain length] % 2) == 0) {
        return plain;
    } else {
        return [NSString stringWithFormat:@"%@Z", plain];
    }
}

-(NSArray *)splitDigraphs:(NSString *)string {
    NSInteger digraph_count = [string length];
    NSMutableArray *parts = [[NSMutableArray alloc] initWithCapacity:[string length]/2];
    NSMutableString *part;
    unichar a, b;
    for(int i=0; i<digraph_count; i+=2) {
        a = [string characterAtIndex:i];
        if (i == digraph_count-1) {
            part = [NSString stringWithFormat:@"%cZ", a];
        } else {
            b = [string characterAtIndex:i+1];
            if (a == b) {
                //Pad identical chars with X
                part = [NSString stringWithFormat:@"%cX", a];
                i--;
            } else {
                part = [NSString stringWithFormat:@"%c%c", a, b];
            }
        }
        [parts addObject:part];
    }
    return parts;
}

-(NSString *)encodeDigraph:(NSString *)digraph {
    NSArray *a, *b;
    a = [_charmap valueForKey:[self charString:digraph atIndex:0]];
    b = [_charmap valueForKey:[self charString:digraph atIndex:1]];
    if ([self isInColumn:a withB:b]) {
        return [self downShiftDigraphA:a andB:b];
    } else if ([self isInRow:a withB:b]) {
        return [self rightShiftDigraphA:a andB:b];
    } else {
        return [self encodeRectangleA:a toB:b];
    }
}

-(NSString *)downShiftDigraphA:(NSArray *)a andB:(NSArray *)b {
    NSInteger x, y;
    NSString *enc_a, *enc_b;
    x = [a[0] integerValue];
    y = [a[1] integerValue];
    enc_a = [self charAtX:x andY:((y+1) % 5)];
    x = [b[0] integerValue];
    y = [b[1] integerValue];
    enc_b = [self charAtX:x andY:((y+1) % 5)];
    return [NSString stringWithFormat:@"%@%@", enc_a, enc_b];
}

-(NSString *)rightShiftDigraphA:(NSArray *)a andB:(NSArray *)b {
    NSInteger x, y;
    NSString *enc_a, *enc_b;
    x = [a[0] integerValue];
    y = [a[1] integerValue];
    enc_a = [self charAtX:((x+1) % 5) andY:y];
    x = [b[0] integerValue];
    y = [b[1] integerValue];
    enc_b = [self charAtX:((x+1) % 5) andY:y];
    return [NSString stringWithFormat:@"%@%@", enc_a, enc_b];
}

-(NSString *)encodeRectangleA:(NSArray *)a toB:(NSArray *)b {
    NSInteger ax, ay, bx, by;
    NSString *enc_a, *enc_b;
    ax = [a[0] integerValue];
    ay = [a[1] integerValue];
    bx = [b[0] integerValue];
    by = [b[1] integerValue];
    enc_a = [self charAtX:bx andY:ay];
    enc_b = [self charAtX:ax andY:by];
    return [NSString stringWithFormat:@"%@%@", enc_a, enc_b];
}
@end
