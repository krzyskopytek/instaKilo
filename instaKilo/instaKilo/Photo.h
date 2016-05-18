//
//  Photo.h
//  instaKilo
//
//  Created by Krzysztof Kopytek on 2016-05-18.
//  Copyright © 2016 Krzysztof Kopytek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) UIImage *image;

-(instancetype) initWithName:(NSString *)name subject:(NSString *)subject location:(NSString *)location;


@end
