//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Khateeb Mahad H. on 8/12/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    static let reuseDefaultCellIdentifier = "DefaultCell"
    static let reuseImagesCellIdentifier = "ImagesCell"

    private let modalPresenter: ModalPresenter_Proto = ModalPresenter()
    private let pokemon: Pokemon
    lazy var detailView = PokemonDetailView()
    
    enum TableViewSection: Int, CaseIterable {
        case name
        case images
        case height
        case weight
        case types
        case stats
        case moves
    }
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.closeDetailViewHandler = { [unowned self] in
            modalPresenter.dismiss(from: self, animated: true)
        }
        detailView.tableView.dataSource = self
        detailView.tableView.reloadData()
    }
}

extension PokemonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableViewSection = TableViewSection(rawValue: section) else { return 0 }
        
        switch tableViewSection {
        case .name, .height, .weight, .images:
            return 1
        case .types:
            return pokemon.types.count
        case .stats:
            return pokemon.stats.count
        case .moves:
            return pokemon.moves.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewSection = TableViewSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        switch tableViewSection {
        case .name:
            var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: type(of: self).reuseDefaultCellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: type(of: self).reuseDefaultCellIdentifier)
            }
            cell.textLabel?.text = String(format:"%d %@", pokemon.id, pokemon.name.capitalized)
            return cell
            
        case .height:
            var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: type(of: self).reuseDefaultCellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: type(of: self).reuseDefaultCellIdentifier)
            }
            cell.textLabel?.text = String(format:"%d", pokemon.height)
            return cell
            
        case .weight:
            var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: type(of: self).reuseDefaultCellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: type(of: self).reuseDefaultCellIdentifier)
            }
            cell.textLabel?.text = String(format:"%d", pokemon.weight)
            return cell
            
        case .types:
            var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: type(of: self).reuseDefaultCellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: type(of: self).reuseDefaultCellIdentifier)
            }
            cell.textLabel?.text = String(format:"%@", pokemon.types[indexPath.row].type.name)
            return cell
        case .stats:
            var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: type(of: self).reuseDefaultCellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: type(of: self).reuseDefaultCellIdentifier)
            }
            cell.textLabel?.text = String(format:"%@ %d", pokemon.stats[indexPath.row].stat.name, pokemon.stats[indexPath.row].baseStat)
            return cell
        case .moves:
            var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: type(of: self).reuseDefaultCellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: type(of: self).reuseDefaultCellIdentifier)
            }
            cell.textLabel?.text = String(format:"%@", pokemon.moves[indexPath.row].move.name)
            return cell
        case .images:
            if let imagesCell = tableView.dequeueReusableCell(withIdentifier: type(of: self).reuseImagesCellIdentifier, for: indexPath) as? PokemonImagesCell {
                imagesCell.imageUrls = pokemon.sprites.getAllImagesURL()
                return imagesCell
            }
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableViewSection = TableViewSection(rawValue: section) else { return nil }
        
        switch tableViewSection {
        case .name:
            return "Number & Name"
        case .height:
            return "Height"
        case .weight:
            return "Weight"
        case .types:
            return "Types"
        case .stats:
            return "Stats"
        case .moves:
            return "Moves"
        case .images:
            return "Images"
        }
    }
}
