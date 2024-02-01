//
//  BaseView.swift
//  Media
//
//  Created by SangRae Kim on 2/1/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(MainTableViewCell.self, forCellReuseIdentifier: "Main")
        view.rowHeight = 220
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(tableView)
    }
    
    func configureViews() {
        backgroundColor = .black
    }
    
    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
