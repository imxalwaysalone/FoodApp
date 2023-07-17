//
//  MainTabBarController.swift
//  FoodApp
//
//  Created by Владимир Дроздов on 17.07.23.
//

import UIKit

class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genegateTabBar()
    }
    
    private func genegateTabBar() {
        viewControllers = [
        generateViewController(
            viewController: MainViewController(),
            title: "Главная",
            image: UIImage(named: "Home")),
        generateViewController(
            viewController: SearchViewController(),
            title: "Поиск",
            image: UIImage(named: "Search")),
        generateViewController(
            viewController: BasketViewController(),
            title: "Корзина",
            image: UIImage(named: "Basket")),
        generateViewController(
            viewController: AccountViewController(),
            title: "Аккаунт",
            image: UIImage(named: "Acc"))
        ]
    }
    private func generateViewController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}
