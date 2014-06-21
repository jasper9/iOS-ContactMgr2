//
//  Contact.h
//  ContactMgr2
//
//  Created by Josh Gray on 5/19/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject <NSCoding>

@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;


@end
