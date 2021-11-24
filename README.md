
<div style="width:100%">
    <div style="width:50%; display:inline-block">
        <p align="center">
        <img align="center" width="180" height="180" alt="" src="https://github.com/cometchat-pro/ios-objective-c-chat-app/blob/master/Screenshots/logo.png">    
        </p>    
    </div>    
</div>
</div>

</br>


# iOS Objective-C Chat App

<p align="left">

<a href=""><img src="https://img.shields.io/badge/Repo%20Size-15.6%20MB-brightgreen" /></a>
<a href=""> <img src="https://img.shields.io/badge/Contributors-5-yellowgreen" /></a>
<a href=" "> <img src="https://img.shields.io/badge/Version-3.0.5--1-red" /></a>
<a href=""> <img src="https://img.shields.io/github/stars/cometchat-pro/ios-objective-c-chat-app?style=social" /></a>
<a href=""> <img src="https://img.shields.io/twitter/follow/cometchat?style=social" /></a>

</p>
</br></br>


<div>
<img align="left" src="https://github.com/cometchat-pro-samples/ios-objective-c-chat-app/blob/master/Screenshots/appScreenshot.jpg">  
</div>

<br></br><br></br></br>

<br></br>

CometChat Kitchen Sink Sample App (built using **CometChat UIKit**) is a fully functional messaging app capable of **one-on-one** (private) and **group** messaging as well as Calling. This sample app enables users to send **text** and **multimedia messages like images, videos, documents**. Also, users can make **Audio** and **Video** calls to other users or groups.

</br>

---

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed the latest version of Xcode. (Above Xcode 12 Recommended)

- iOS Objective-C Chat App works for the iOS devices from iOS 11 and above.

NOTE: Please install the latest pod version on your Mac to avoid integration issues

```bash
Please follow the below steps:

sudo gem update cocoapods --pre
pod update
clean
build

```


## Installing iOS Objective-C Chat App
      
1. Simply clone the project from [ios-objective-c-chat-app](https://github.com/cometchat-pro-samples/ios-objective-c-chat-app/archive/master.zip) repository. After cloning the repository:

2. Navigate to project's folder and use below command to install the require dependancies.
   
   ```
   $ pod install
   ```
   
3. If you're facing any issues while installing pods, then kindly use the below command to install dependancies.
   
   ```
   pod install --repo-update
   ```

4. Build and run the Sample App.
---


## Running the sample app

To Run to sample app you have to do the following changes by Adding **AppID**, **AuthKey** and  **Region**
   
   You can obtain your  *App ID*, *Auth Key* and *Region* from [CometChat-Pro Dashboard](https://app.cometchat.io/). Create new app and head over to the Quick Start or API & Auth Keys section and note the *App ID*, *Auth Key*, and *Region*.
          
   - Open the project in Xcode. 
          
   - Go to CometChatObjc -->  **AppConstants.h**.
                  
   - Modify *App ID* and *Auth Key*  and *Region* with your own **App ID**, **Auth Key** and **Region**.

   -  Select demo users or enter the **UID** at the time of login once the app is launched. 

![Studio Guide](https://github.com/cometchat-pro-samples/ios-objective-c-chat-app/blob/master/Screenshots/Auth.png) 

---

## Add UIKit Library to your project

Learn more about how to integrate [UI Kit](https://github.com/cometchat-pro/ios-chat-uikit) inside your app. 

---

## Important Steps for Objective - C.

- To receive real-time events for calls in Objective C you must have to register `CometchatCallDelegate` protocol and it's methods in AppDelegate. 

Please, [refer this guide](https://github.com/cometchat-pro-samples/ios-objective-c-chat-app/blob/master/RealtimeCallEvents.md) for more information. 

-  Kindly, run it sample app on the physical device. 

---

# Troubleshooting

- To read the full dcoumentation on UI Kit integration visit our [Documentation](https://prodocs.cometchat.com/docs/ios-ui-kit)  .

- Facing any issues while integrating or installing the UI Kit please <a href="https://app.cometchat.io/"> connect with us via real time support present in CometChat Dashboard.</a>

---

# Contributors

Thanks to the following people who have contributed to this project:

[@pushpsenairekar2911 👨‍💻](https://github.com/pushpsenairekar2911) <br>
[@BudhabhooshanPatil 👨‍💻](https://github.com/BudhabhooshanPatil)
<br>
[@jeetkapadia 👨‍💻](https://github.com/jeetkapadia)
<br>
[@NishantTiwarins 👨‍💻](https://github.com/NishantTiwarins)
<br>
[@Abhijitinscripts 📝](https://github.com/Abhijitinscripts)

---

# Contact

Contact us via real time support present in [CometChat Dashboard.](https://app.cometchat.io/)

---

# License


This project uses the following [license](https://github.com/cometchat-pro/ios-objective-c-chat-app/blob/master/License.md).

---
