# Windows Phone Todo App

A simple todo app backed by [Appacitive Cloud Platform](http://www.appacitive.com) and uses [Appacitive iOS SDK](http://devcenter.appacitive.com/ios/) for managing application data. 

This app demonstrates ***Data Store*** and ***Users*** features provided by the Appacitive iOS SDK.

### Getting Started

To execute this app you will require the [Appacitive iOS SDK](http://devcenter.appacitive.com/ios/downloads) and [Appacitive Account](https://portal.appacitive.com/).

If you don't have an Appacitive Account, [sign up](https://portal.appacitive.com/signup.html) for a free account today.

##### Step 1: Modeling the backend
To model your application backend on Appacitive Platform, please watch [this](http://player.vimeo.com/video/89849527) video. If you already have the backend ready with you, you can jump to the next step.

##### Step 2: Download the source code
You can download the source code for this sample Todo App from https://github.com/apalsapure/wp-todoapp/archive/master.zip.

##### Step 3: Authenticating the app
Once you have downloaded the source code, launch the xcode project and open the Appdelegate.m file. In the `application:didLaunchWithOptions:` replace the `YOUR_API_KEY` with your Appacitive Application API Key.

```objectivec
[Appacitive registerAPIKey:@"YOUR_API_KEY" useLiveEnvironment:NO];
```

To get these details, open your app on [Appacitive Portal](https://portal.appacitive.com). API key for the app is available on your app's home page at the bottom.

Once your done, run the application.

### Build your own Todo App 

If you want to build your own Todo App, please visit http://devcenter.appacitive.com/ios/samples/todo/. This tutorial will explain each and every step required to build this sample app.
