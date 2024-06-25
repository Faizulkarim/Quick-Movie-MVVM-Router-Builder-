//
//  BaseTabBarViewController.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//
import UIKit

class BaseTabBarViewController: UITabBarController {
    
    let dependencyManager = OTDependencyManager.defaultValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarControllers()
        configureTabBarTheme()
    }

    func configureTabBarControllers() {
        let tabHome = dependencyManager.homeBuilder().build()
        let tabHomeItem = UITabBarItem(title: "Home",
                                      image: dependencyManager.theme().imageTheme.tabbar_home,
                                      selectedImage: dependencyManager.theme().imageTheme.tabbar_home)
        tabHome.tabBarItem = tabHomeItem
        
        let tabFav = dependencyManager.favoriteBuilder().build()
        let tabFavItem = UITabBarItem(title: "Favorites",
                                      image: dependencyManager.theme().imageTheme.tabbar_Fav,
                                      selectedImage: dependencyManager.theme().imageTheme.tabbar_Fav)
        tabFav.tabBarItem = tabFavItem
 
        self.viewControllers = [tabHome,tabFav]
    }
    
    func configureTabBarTheme() {
        tabBar.tintColor = dependencyManager.theme().colorTheme.colorPrimaryRed
        tabBar.backgroundColor = dependencyManager.theme().colorTheme.colorLightGray
    }
    
    func activateTab(index:Int) {
        if let vcs = self.viewControllers {
            self.selectedViewController =  vcs[index]
        }
    }
}

extension BaseTabBarViewController {
    
    static func createObj() -> BaseTabBarViewController  {
        let baseStoryBoard = UIStoryboard(name: "BaseStoryboard", bundle: Bundle.main)
        let baseTabBarViewController = baseStoryBoard.instantiateViewController(withIdentifier: "BaseTabBarViewController") as! BaseTabBarViewController
        return baseTabBarViewController
    }
    
}
