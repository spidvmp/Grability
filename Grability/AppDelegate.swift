//
//  AppDelegate.swift
//  Grability
//
//  Created by Vicente de Miguel on 18/3/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        var mainCont : UIViewController
        //creo  la estructura a mano, asi dependiendo del dispositivo solo cargo un controlador u otro
        //por defecto hago que si es iphone pues table, cualquier otro caso (solo deberia ser ipad) es collectionView
        if  UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            mainCont = IphoneTableViewController() as IphoneTableViewController!
        } else {
            //genero el layout
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            layout.itemSize = CGSize(width: 90, height: 90)
            //let a : IpadCollectionViewController = IpadCollectionViewController(
            mainCont = IpadCollectionViewController(collectionViewLayout: layout) as IpadCollectionViewController!
        }
        
        
        
        
        let navC = UINavigationController(rootViewController: mainCont)
        navC.title = "Catalogo"
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = navC
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

