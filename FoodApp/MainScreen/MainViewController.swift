//
//  ViewController.swift
//  FoodApp
//
//  Created by Владимир Дроздов on 17.07.23.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupCollectionView()
        fetchingApiData(URL: "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54") { result in
            print(result)
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint .activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
         ])
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
    }
    func fetchingApiData(URL url:String, completion: @escaping (Categories) -> Void) {
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, responce, error in
                do{
                    let parsingData = try JSONDecoder().decode(Categories.self, from: data!)
                    completion(parsingData)
                }
                catch {
                    print("Parsing error")
                }
        }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343, height: 148)
    }
    
    class CustomCell: UICollectionViewCell {
        let button: UIButton = {
            let button = UIButton()
            button.backgroundColor = .black
            
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        override init(frame: CGRect) {
            super .init(frame: frame)
            addSubview(button)
            NSLayoutConstraint .activate([
               button.topAnchor.constraint(equalTo: topAnchor),
               button.bottomAnchor.constraint(equalTo: bottomAnchor),
               button.leadingAnchor.constraint(equalTo: leadingAnchor),
               button.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

