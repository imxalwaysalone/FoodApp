//
//  SearchViewController.swift
//  FoodApp
//
//  Created by Владимир Дроздов on 17.07.23.
//

import UIKit

class SearchViewController: UIViewController {

    let firstScreen = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
       setupFirtsScreen()
    }
    private func setupFirtsScreen () {
        firstScreen.frame = view.bounds
    }

}
