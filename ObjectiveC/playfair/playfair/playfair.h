//
//  playfair.h
//  playfair
//
//  Created by Jonathan Lozinski on 16/09/2012.
//  Copyright (c) 2012 Jonathan Lozinski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Playfair : NSObject

-(id)initWithKeyText:(NSString *)keytext;
-(NSString *)encode:(NSString *)plain;

@property NSString *keytext;
@property NSMutableDictionary *charmap;

@end
