//
//  ViewController.swift
//  Media
//
//  Created by SangRae Kim on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    let mainView = MainView()
    var titles = ["유행하는 TV시리즈", "평점높은 TV시리즈", "인기있는 TV시리즈", "시청중인 콘텐츠", "슬기로운 의사생활과 비슷한 콘텐츠", "슬기로운 의사생활 출연진"]
    var list: [[TV]] = [[], [], []]
    var dramaList: [DramaModel] = []
    var recommendList: [TV] = []
    var aggregateCredits: [Person] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        requestToTMDB()
    }
}

extension ViewController {
    func requestToTMDB() {
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.fetchToTVSeries(api: .trending) { result in
            self.list[0] = result
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchToTVSeries(api: .topRated) { result in
            self.list[1] = result
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchToTVSeries(api: .popular) { result in
            self.list[2] = result
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchInfoDrama(api: .info(id: 96102)) { result in
            self.dramaList.append(result)
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchToTVSeries(api: .recommendation(id: 96102)){ result in
            self.recommendList = result
            group.leave()
        }
        group.enter()
        TMDBAPIManager.shared.fetchAggregateCredits(api: .credit(id: 96102)) { result in
            self.aggregateCredits = result
            group.leave()
        }
        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
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
        switch collectionView.tag {
        case 0...2 : return list[collectionView.tag].count
        case 3: return dramaList.count
        case 4: return recommendList.count
        case 5: return aggregateCredits.count
        default:
            return -1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        
        var item: String?
        
        switch collectionView.tag {
        case 0...2: item = list[collectionView.tag][indexPath.item].poster
        case 3: item = dramaList[0].poster
        case 4: item = recommendList[indexPath.item].poster
        case 5: item = aggregateCredits[indexPath.item].profile
        default: print("error")
        }
        if let item {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(item)")
            cell.posterImageView.kf.setImage(with: url)
        } else {
            cell.posterImageView.image = UIImage(systemName: "xmark")
        }
        
        return cell
    }
}
