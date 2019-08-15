//
//  AppDelegate.swift
//  LogoFInder
//
//  Created by Janki on 04/06/19.
//  Copyright © 2019 ravi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var reachability: Reachability?;
    var dialogForNetwork:CustomAlertDialog?;

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupNetworkReachability()
        if let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusBar.backgroundColor = UIColor.init(red: 241/255.0, green: 151/255.0, blue: 51/255.0, alpha: 1.0)
        }
        let notificationSettings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        return true
    }
    func setupNetworkReachability()
    {
        self.reachability = Reachability.init();
        do
        {
            try self.reachability?.startNotifier()
        }
        catch
        {
            print(error)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
        //    NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(FRESHCHAT_UNREAD_MESSAGE_COUNT_CHANGED), object: nil)
        
    }
    @objc func reachabilityChanged(note: NSNotification)
    {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable
        {
            if (APPDELEGATE.window?.viewWithTag(DialogTags.networkDialog)) != nil
            {
                dialogForNetwork?.removeFromSuperview()
            }
            if reachability.isReachableViaWiFi
            {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        } else {
            print("Network not reachable")
            openNetworkDialog()
            
        }
    }
    func  openNetworkDialog ()
    {
        dialogForNetwork  = CustomAlertDialog.showCustomAlertDialog(title: "INTERNET", message: "Internet not available", titleLeftButton: "EXIT", titleRightButton: "OK")
        
        self.dialogForNetwork!.onClickLeftButton =
            {
                self.dialogForNetwork!.removeFromSuperview();
                exit(0)
        }
        self.dialogForNetwork!.onClickRightButton =
            {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
//
//                if UIApplication.shared.canOpenURL(settingsUrl)
//                {
//                    if #available(iOS 10.0, *) {
//                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
//
//                        })
//                    } else
//                    {
////                        UIApplication.shared.openURL(settingsUrl)
//                    }
//                }
                self.dialogForNetwork?.removeFromSuperview();
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        print("Print entire notification message for preview:  \(notification)")
        
        let userInfoObject = notification.userInfo! as! [String : String]
        
        // Extract custom parameter value from notification message
        let customParameterValue = userInfoObject["customParameterKey_from"]! as String
        print("Message from sent by \(customParameterValue)")
        
        // Extract message alertBody
        let messageToDisplay = notification.alertBody
        
        // Display message alert body in a alert dialog window
        let alertController = UIAlertController(title: "Notification", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in
            
            print("Ok button tapped");
            
        }
        alertController.addAction(OKAction)
        
        // Present dialog window to user
        window?.rootViewController?.present(alertController, animated: true, completion:nil)
    }
}

