//
//  Contact.m
//  ContactMgr2
//
//  Created by Josh Gray on 5/19/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import "Contact.h"

static  int *const ID = 0;
static  NSString *const NAME = @"name";
static  NSString *const PHONE = @"phone";
static  NSString *const EMAIL = @"email";

@implementation Contact

- (NSString *) description {
    return [NSString stringWithFormat: @"%@ %@ %@" , _name, _phone, _email];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    //[coder encodeObject:self.id forKey:ID];
    [coder encodeObject:self.name forKey:NAME];
    [coder encodeObject:self.phone forKey:PHONE];
    [coder encodeObject:self.email forKey:EMAIL];
}


- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
      //  _id = [coder decodeObjectForKey:ID];
        _name = [coder decodeObjectForKey:NAME];
        _phone = [coder decodeObjectForKey:PHONE];
        _email = [coder decodeObjectForKey:EMAIL];
    }
    return self;
}


@end
