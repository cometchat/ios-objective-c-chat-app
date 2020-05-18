<div>
<img align="left" src="https://github.com/cometchat-pro-samples/ios-objective-c-chat-app/blob/master/Screenshots/appScreenshot.jpg">  </div>

<br></br><br></br>

CometChat Kitchen Sink Sample App (built using **CometChat UIKit**) is a fully functional messaging app capable of **one-on-one** (private) and **group** messaging as well as Calling. This sample app enables users to send **text** and **multimedia messages like images, videos, documents**. Also, users can make **Audio** and **Video** calls to other users or groups.
___
## Table of Contents

1. [Installation](#Installation)

2. [Running the sample app](#Running-the-sample-app)

3. [Add UIKit library to your App](#Add-UIKit-Library-to-your-App)

4. [Troubleshooting](#Troubleshooting)




# Installation
      
1. Simply clone the project from [ios-objective-c-chat-app](https://github.com/cometchat-pro-samples/ios-objective-c-chat-app/archive/master.zip) repository. After cloning the repository:

2. Select the appropriate version as per your Xcode version.

3. Navigate to project's folder and use below command to install the require pods.
   
   ```
   $ pod install
   ```
   
4. If you're facing any issues while installing pods, then kindly use below command ton install pods.
   
   ```
   pod install --repo-update
   ```

5. Build and run the Sample App.
___


# Running the sample app

To Run to sample app you have to do the following changes by Adding **APP_ID**, **API_KEY** and  **REGION_CODE**
   
   You can obtain your  *APP_ID*, *API_KEY* and *REGION_CODE* from [CometChat-Pro Dashboard](https://app.cometchat.io/)
          
   - Open the project in Xcode. 
          
   - Go to CometChatObjc -->  **AppConstants.h**.
                  
   - Modify *APP_ID* and *API_KEY*  and *REGION* with your own **API_KEY**, **APP_ID** and **REGION**.

   -  Select demo users or enter the **UID** at the time of login once the app is launched. 

![Studio Guide](https://github.com/cometchat-pro-samples/ios-objective-c-chat-app/blob/master/Screenshots/Auth.png) 

___

# Add UIKit Library to your App

Learn more about how to integrate [UI Kit](https://github.com/cometchat-pro/ios-chat-uikit) inside your app. 

___

# Important Steps for Objective - C.

- To receive real-time events for calls in Objective C you must have to register `CometchatCallDelegate` protocol and it's methods in AppDelegate. 

Please, [refer this guide](https://github.com/cometchat-pro-samples/ios-objective-c-chat-app/blob/master/RealtimeCallEvents.md) for more information. 

-  Kindly, run it sample app on the physical device. 

___

# Troubleshooting

Facing any issues while integrating or installing the UI Kit please <a href="https://forum.cometchat.com/"> visit our forum</a>.


