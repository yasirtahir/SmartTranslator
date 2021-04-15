
![# Let's build Smart Translator using HUAWEI ML Kit (Real-time Language Detection and Translation) in iOS native language (Swift)](https://github.com/yasirtahir/SmartTranslator/raw/main/images/img1.jpeg)

 

## Introduction


In this demo, we will show how to integrate Huawei ML Kit (Real-time Language Detection and Real-time Language Translation) in iOS using native language (Swift). The use case has been created to make Smart Translator supporting more than 38 languages with HMS open capabilities.

  
## Pre-Requisites

  
Before getting started, following are the requirements:

1.  Xcode (During this tutorial, we used latest version 12.4)  
    
2.  iOS 9.0 or later (ML Kit supports iOS 9.0 and above)
    
3.  Apple Developer Account
    
4.  iOS device for testing


  ## Development

1. Add **pod 'MLTranslate', '~>2.0.5.300'** and **pod 'MLLangDetection', '~>2.0.5.300'** in the PodFile.
2. Add **agconnect-services.plist** file in the project directory.  
3. We used **Lottie and ViewAnimator** library for animations in our demo to enhance look and feel.
4. Write necessary code for **MLLangDetect and MLTranslate** and call the required functions.
5. Once you get the detected language code, call the MLTranslate API to get translated string and show it as result.
6. We also saved translation history and display the items in **UITableView** in the History screen.


Whenever user travel to a new place, country or region, he can use this app to translate text from their native language to the visited place spoken language. Once they are done with translation, they can also check the translated history or show it to someone so that they can communicate with the locals easily and conveniently with Smart Translator.

  

  

## Run the Application

  

Download this repo code. Build the project, run the application and test on any iOS phone. In this demo, we used iPhone 11 Pro Max for testing purposes.

Using ML Kit, developers can develop different iOS applications with auto detect option to improve the UI/UX. ML Kit is a on-device and on-cloud open capability offered by Huawei which can be combined with other functionalities to offer innovative services to the end users.

  

![Demo](https://github.com/yasirtahir/SmartTranslator/raw/main/images/img2.gif "Demo")

  

## Point to Ponder

1.  Before calling the ML Kit, make sure the required  **agconnect-services.plist**  is added to the project and ML Kit APIs are enabled from the AGConnect console.
    
2.  ML Kit must be initiated with the API Key in the  **AppDelegate.swift**.
    
3.  There are no special permissions needed for this app. However, make sure that the device is connected to Internet and have active connection.
    
4.  Always use animation libraries like **Lottie or ViewAnimator** to enhance UI/UX in your application.
    

  

  

## References

### Huawei ML Kit Official Documentation:  
[https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/ios-real-time-translation-0000001062729936](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/ios-real-time-translation-0000001062729936)

### Huawei ML Kit FAQs:
[https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/faq-0000001050040135](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/faq-0000001050040135)

### Lottie iOS Documentation:  
[http://airbnb.io/lottie/#/ios](http://airbnb.io/lottie/#/ios)
