//
//  CategoryViewController.swift
//  FoodApp
//
//  Created by Владимир Дроздов on 19.07.23.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var categoryCollectionView: UICollectionView!
    var icons = [UIImage]()
    var dishes = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoryCollectionView()
        
    }
    private func setupCategoryCollectionView() {
        let layout = UICollectionViewLayout()
        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(categoryCollectionView)
        
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func parsingApiData() {
        let url = URL(string: "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if let error = error { print(error); return }
            do {
                let dataForParsing = try JSONDecoder().decode(Welcome.self, from: data!)
                let imageURLs = dataForParsing.dishes.map(\.imageURL)
                self.dishes = dataForParsing.dishes
                let group = DispatchGroup()
                for imageURL in imageURLs {
                    group.enter()
                    URLSession.shared.dataTask(with: imageURL) { data, response, error in
                        defer{ group.leave() }
                        if let error = error { print(error); return}
                        if let icon = UIImage(data: data!) {
                            self.icons.append(icon)
                        }
                    }.resume()
                }
                group.notify(queue: .main) {
                    self.categoryCollectionView.reloadData()
                }
            } catch {
                print("Parsing error ")
            }
        }.resume()
    }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
            cell.imageView.image = icons[indexPath.row]
            return cell
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return icons.count
        }
        class CustomCell: UICollectionViewCell {
            let imageView = UIImageView()
            override init(frame: CGRect) {
                super.init(frame: frame)
            }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            private func setupView() {
                addSubview(imageView)
            }
        }
    }
    
