//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Khateeb Mahad H. on 8/12/21.
//

import UIKit

final class PokemonDetailView: UIView {

    var closeDetailViewHandler: (()->())?

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PokemonImagesCell.self, forCellReuseIdentifier: "ImagesCell")
        return tableView
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.closeIcon, for: .normal)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
        button.addTarget(self, action: #selector(onClose(sender:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(tableView)
        addSubview(closeButton)
        
        tableView.marginToSuperviewSafeArea(top: 48, bottom: 0, leading: 0, trailing: 0)
        closeButton.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onClose(sender: Any) {
        self.closeDetailViewHandler?()
    }
}
