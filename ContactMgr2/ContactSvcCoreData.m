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
        [self initializeCoreData];
        return self;
    }
    return nil;
}

- (Contact *) createContact:(Contact *)contact {
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:moc];
    [managedObject setValue:contact.name forKey:@"name"];
    [managedObject setValue:contact.phone forKey:@"phone"];
    [managedObject setValue:contact.email forKey:@"email"];
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"createContact ERROR: %@", [error localizedDescription]);
    }
    
    return contact;
}

- (NSMutableArray *) retrieveAllContacts {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *contacts = [NSMutableArray arrayWithCapacity:fetchedObjects.count];
    for (NSManagedObject *managedObject in fetchedObjects) {
        Contact *contact = [[Contact alloc] init];
        contact.name = [managedObject valueForKey:@"name"];
        contact.phone = [managedObject valueForKey:@"phone"];
        contact.email = [managedObject valueForKey:@"email"];
        NSLog(@"contact: %@ ", [contact description]);
        [contacts addObject:contact];
        
        
        
    }
    return contacts;
}

- (Contact *) updateContact:(Contact *)contact {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:moc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@ AND phone = %@ AND email = %@", contact.name, contact.phone, contact.email];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    
    return contact;
}

- (Contact *) deleteContact:(Contact *)contact {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:moc];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@ AND phone = %@ AND email = %@", contact.name, contact.phone, contact.email];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    
    if ([fetchedObjects count] == 1)
    {
        NSManagedObject *managedObject = [fetchedObjects objectAtIndex:0];
        [moc deleteObject:managedObject];
        
    }
    return contact;
}

- (void) initializeCoreData
{
    // initialize (load) the schema model
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // initialize the persistent store coordinator with the model
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"ContactsMgr.sqlite"];
    NSError *error = nil;
    psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    if ([psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        //initialize the managed object context
        moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
               [moc setPersistentStoreCoordinator:psc];
               
    } else {
        NSLog(@"initializeCoreData FAILED with error: %@", error);
                   
    }
         
         
    
}



@end
