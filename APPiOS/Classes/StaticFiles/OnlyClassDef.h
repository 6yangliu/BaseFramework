//
//  OnlyClassDef.h
//  YHB_Prj
//
//  Created by dd on 15/11/21.
//  Copyright © 2015年 striveliu. All rights reserved.
//

#ifndef OnlyClassDef_h
#define OnlyClassDef_h

#define SYN_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##classname = [[classname alloc] init];\
}); \
return shared##classname;\
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \

#endif /* OnlyClassDef_h */
