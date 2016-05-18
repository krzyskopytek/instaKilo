//
//  Photo.m
//  instaKilo
//
//  Created by Krzysztof Kopytek on 2016-05-18.
//  Copyright © 2016 Krzysztof Kopytek. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(instancetype) initWithName:(NSString *)name subject:(NSString *)subject location:(NSString *)location{


    self = [super init];
    if (self) {
        _name = name;
        _subject = subject;
        _location = location;
    }
    return self;

}

@end
