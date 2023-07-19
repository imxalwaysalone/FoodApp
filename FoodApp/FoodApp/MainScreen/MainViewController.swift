//
//  ViewController.swift
//  FoodApp
//
//  Created by Владимир Дроздов on 17.07.23.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    var images = [UIImage]()
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchingApiData()
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

    func fetchingApiData() {
        let url = URL(string: "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54" )
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, responce, error in
            if let error = error {print(error); return}
            do{
                let parsingData = try JSONDecoder().decode(Categories.self, from: data!)
                let imageURLs = parsingData.сategories.map { $0.image_url }
                self.categories = parsingData.сategories
                let group = DispatchGroup()
                for imageURL in imageURLs {
                    group.enter()
                    URLSession.shared.dataTask(with: imageURL) { data, responce, error in
                        defer{ group.leave() }
                        if let error = error { print(error); return}
                        if let image = UIImage(data: data!) {
                            self.images.append(image)
                        }
                        
                    }.resume()
                }
                group.notify(queue: .main) {
                    self.collectionView.reloadData()
                }
            }
            catch {
                print("Parsing error")
            }
        }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.imageView.image = images[indexPath.row]
        cell.label.text = categories[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343, height: 148)
    }
    
    class CustomCell: UICollectionViewCell {
        let imageView = UIImageView()
        let label = UILabel()
        override init(frame: CGRect) {
            super .init(frame: frame)
            setupUI()
            setupViews()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: 40),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 0),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 0),
                label.topAnchor.constraint(equalTo: topAnchor, constant: 52),
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            ])
            imageView.translatesAutoresizingMaskIntoConstraints = false
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        private func setupUI() {
            label.font = .systemFont(ofSize: 20, weight: .regular)
        }
        private func setupViews() {
            addSubview(imageView)
            addSubview(label)
        }
    }
}

