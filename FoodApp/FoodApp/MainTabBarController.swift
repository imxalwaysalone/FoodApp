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
            viewController: CategoryViewController(),
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
    private func generateViewController(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let nav = NavController(rootViewController: viewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return nav
    }
}
class NavController: UINavigationController {
    let navigationView = UIView()
    let imageView = UIImageView()
    let signatureView = UIImageView()
    let mainTitle = UILabel()
    let subTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViews()
        setupConstraints()
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 51),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signatureView.topAnchor.constraint(equalTo: view.topAnchor, constant: 54),
            signatureView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            mainTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 47),
            subTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 78)
        ])
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        signatureView.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setupUI() {
        navigationView.backgroundColor = .black
        signatureView.image = UIImage(named: "Signature")
        imageView.image = UIImage(named: "Profile")
        mainTitle.text = "Санкт-Петербург"
        mainTitle.font = .systemFont(ofSize: 18, weight: .bold)
        subTitle.font = .systemFont(ofSize: 14)
        subTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        subTitle.text = "12 Августа, 2023"
        
    }
    private func setupViews() {
        view.addSubview(navigationView)
        view.addSubview(imageView)
        view.addSubview(signatureView)
        view.addSubview(mainTitle)
        view.addSubview(subTitle)
    }
}
