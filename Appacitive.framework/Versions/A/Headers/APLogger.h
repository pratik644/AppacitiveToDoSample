//
//  APLogger.h
//  Appacitive-iOS-SDK
//
//  Created by Pratik on 13-05-14.
//  Copyright (c) 2014 Appacitive Software Pvt. Ltd. All rights reserved.
//

typedef enum {
    APMessageTypeError,
    APMessageTypeDebug
} APMessageType;

/**
 An interface that logs the details of all the network calls that the SDK makes. All messages will be logged to the console.
 */

@interface APLogger : NSObject

/**
 Method to instantiate and return a static shared logger instance.
 
 @return static instance of a shared logger.
 */
+ (instancetype) sharedLogger;

/**
 Method to enable logging, which is disabled by default.
 
 @param answer Whether you want to enable logging.
 */
+ (void) enableLogging:(BOOL)answer;

/**
 The default logging mode is set to error that will only log error. Use this method to enable logging everything i.e. in debug mode.
 
 @param answer Whether you want  to enable verbose mode logging.
 */
+ (void) enableVerboseMode:(BOOL)answer;

/**
 Method to log message with specified message type.
 
 @param message     Message string to be logged.
 @param messageType Message type i.e. APMessageTypeError or APMessageTypeDebug.
 */
- (void) log:(NSString*)message withType:(APMessageType)messageType;

@end

