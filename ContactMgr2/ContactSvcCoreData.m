//
//  ContactSvcCoreData.m
//  ContactMgr2
//
//  Created by Josh Gray on 6/20/14.
//  Copyright (c) 2014 msse650. All rights reserved.
//

#import "ContactSvcCoreData.h"

@implementation ContactSvcCoreData

NSManagedObjectModel *model = nil;
NSPersistentStoreCoordinator *psc = nil;
NSManagedObjectContext *moc = nil;


- (id)  init {
    if(self = [super init]) {
        return self;
    }
    return nil;
}

- (Contact *) createContact:(Contact *)contact {
    return contact;
}

- (NSMutableArray *) retrieveAllContacts {
    return nil;
}

- (Contact *) updateContact:(Contact *)contact {
    return contact;
}

- (Contact *) deleteContact:(Contact *)contact {
    return contact;
}

- (void) initializeCoreData
{
    // initialize (load) the schema model
    //NSURL *modelURL = [[[NSBundle mainBundle]] URLForResource:@"]
    
}



@end
