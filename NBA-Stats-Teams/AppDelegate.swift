//
//  AppDelegate.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 4/27/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        preloadData();
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func preloadData(){
        let preloadedDataKey = "didPreloadData"
        let userDefaults = UserDefaults.standard
        print("Checking if Data needs Preloading...")
        if userDefaults.bool(forKey: preloadedDataKey) == false{
            // Preload
            print("Preloading Data...");
            guard let urlPath = Bundle.main.url(forResource: "PlayersData", withExtension: "plist") else {return}
            
            let backgroundContext = persistentContainer.newBackgroundContext();
            persistentContainer.viewContext.automaticallyMergesChangesFromParent = true;
            
            
            
            backgroundContext.perform {
                let arrayContents = NSArray(contentsOf: urlPath) as? [Dictionary<String, Any>];
                
                do {
                    for playerDict in arrayContents! {
                        
                        let playerObject = Player(context: backgroundContext)
                        playerObject.name = playerDict["Name"] as! String;
                        playerObject.pos = playerDict["Pos"] as! String;
                        playerObject.age = playerDict["Age"] as! Int16;
                        playerObject.team = playerDict["Team"] as! String;
                        playerObject.fg = playerDict["FG%"] as! Double;
                        playerObject.fg3 = playerDict["3P%"] as! Double;
                        playerObject.pts = playerDict["PTS"] as! Double;
                        playerObject.ast = playerDict["AST"] as! Double;
                        playerObject.reb = playerDict["REB"] as! Double;
                        playerObject.imageName = playerDict["Image"] as! String;
                        
                    }
                    try backgroundContext.save();
                    userDefaults.set(true, forKey: preloadedDataKey);
                    print("Data Successfully Loaded!")
                } catch {
                    print ("Data Failed to Preload!!!")
                    print(error.localizedDescription)
                    }
            }
                
            
            
            /*
            let arrayContents = NSArray(contentsOf: urlPath) as? [Dictionary<String, Any>];
            for playerDict in arrayContents! {
                //print(item)
                print(playerDict["Name"] as! String)
                
            }
            userDefaults.set(true, forKey: preloadedDataKey);
            */
            
        }

    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NBA_Stats_Teams")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

