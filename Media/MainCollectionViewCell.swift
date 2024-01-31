//
//  MainCollectionViewCell.swift
//  Media
//
//  Created by SangRae Kim on 1/31/24.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainCollectionViewCell {
    func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    func configureViews() {
        contentView.backgroundColor = .clear
        posterImageView.image = UIImage(systemName: "xmark")
    }
    
    func configureConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}
