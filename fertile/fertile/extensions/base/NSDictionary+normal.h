//
//  NSDictionary+normal.h
//  fertile_oc
//
//  Created by vincent on 15/10/30.
//  Copyright © 2015年 fruit. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary<KeyType, ObjectType> (normal)

- (void)setSafeObject:(id)anObject forKey:(id)aKey ;



- (void)removeSafeObjectForKey:(id)aKey;

@end
