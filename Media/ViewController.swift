//
//  ViewController.swift
//  Media
//
//  Created by SangRae Kim on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: BaseViewController {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(MainTableViewCell.self, forCellReuseIdentifier: "Main")
        view.rowHeight = 220
        view.backgroundColor = .clear
        return view
    }()
    
    var titles = ["유행하는 TV시리즈", "평점높은 TV시리즈", "인기있는 TV시리즈"]
    var list: [[TV]] = [[], [], []]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.fetchTrendingTV { result in
            self.list[0] = result
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchTopRatedTV { result in
            self.list[1] = result
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchPopularTV { result in
            self.list[2] = result
            group.leave()
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureViews() {
        view.backgroundColor = .black
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Main", for: indexPath) as! MainTableViewCell

        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        cell.collectionView.reloadData()
        cell.collectionView.tag = indexPath.row
        cell.titleLabel.text = titles[indexPath.row]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        let item = list[collectionView.tag][indexPath.item].poster
        
        if let item {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(item)")
            cell.posterImageView.kf.setImage(with: url)
            
        } else {
            cell.posterImageView.image = UIImage(systemName: "xmark")
        }
        
        return cell
    }
}
