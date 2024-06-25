//
//  AppDelegate.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// The app main window.
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    weak var viewController: UIViewController?
    /// The app dependency manager.
    private(set) var dependencyManager: DependencyManager!
    
    // MARK: - Core Data stack

      lazy var persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "QuickMovie")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()

      // MARK: - Core Data Saving support

      func saveContext() {
          let context = persistentContainer.viewContext
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window!.overrideUserInterfaceStyle = .light
        let environment: AppEnvironment = AppEnvironment.bootstrap(rootWindow: window)
        environment.startApp()
        return true
    }
}

extension AppDelegate {
    
}

