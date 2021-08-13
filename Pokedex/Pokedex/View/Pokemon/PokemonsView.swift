//
//
//  Created by Khatib Mahad H. on 7/19/21.
//

import UIKit

enum SortMode: Int {
    case number = 0, name, type
}

final class PokemonsView: UIView {

    var sortMode: SortMode = .number {
        didSet {
            self.sortBySegment.selectedSegmentIndex = sortMode.rawValue
        }
    }
    
    var sortModeChangeHandler: (( _ mode: SortMode)->())?
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Search Pokemon"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    let sortBySegment: UISegmentedControl = {
        let items  = ["Number", "Name", "Type"]
        let segmented = UISegmentedControl(items: items)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(onSortModeChanged(_:)), for: .valueChanged)
        return segmented
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PokemonCell.self, forCellReuseIdentifier: "PokemonCell")
        return tableView
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchBar, sortBySegment, tableView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(stackView)
        addSubview(activityIndicatorView)
        stackView.marginToSuperviewSafeArea(top: 0, bottom: 0, leading: 0, trailing: 0)
        activityIndicatorView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor, constant: 0).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor, constant: 0).isActive = true
        //sortByButton.topAnchor.constraint(equalTo: searchBar.topAnchor, constant: 12).isActive = true
        //sortByButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        //sortByButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //sortByButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onSortModeChanged(_ sender:UISegmentedControl) {
        sortModeChangeHandler?(SortMode(rawValue: sender.selectedSegmentIndex)!)
    }
}
