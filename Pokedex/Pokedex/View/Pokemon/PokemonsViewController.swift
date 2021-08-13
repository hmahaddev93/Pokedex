//
//
//  Created by Khatib Mahad H. on 7/18/21.
//

import UIKit

final class PokemonsViewController: UIViewController {

    private let viewModel: PokemonViewModel
    private let alertPresenter: AlertPresenter_Proto = AlertPresenter()
    private let modalPresenter: ModalPresenter_Proto = ModalPresenter()

    lazy var pokemonsView = PokemonsView()

    init(viewModel: PokemonViewModel = PokemonViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = pokemonsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonsView.tableView.dataSource = self
        pokemonsView.tableView.delegate = self
        pokemonsView.searchBar.delegate = self
        pokemonsView.sortModeChangeHandler = { [unowned self] (sortMode) in
            self.viewModel.sortBy(mode: sortMode)
            self.pokemonsView.tableView.reloadData()
        }
        
        fetchPokemons()
    }
    
    private func fetchPokemons() {
        showSpinner()
        viewModel.fetchFirst151Pokemons { [unowned self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.hideSpinner()
                    self.update()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.hideSpinner()
                    self.display(error: error)
                }
            }
        }
    }
    
    private func update() {
        pokemonsView.tableView.reloadData()
    }
    
    private func display(error: Error) {
        alertPresenter.present(from: self,
                               title: "Unexpected Error",
                               message: "\(error.localizedDescription)",
                               dismissButtonTitle: "OK")
    }
    
    private func showSpinner() {
        self.pokemonsView.activityIndicatorView.startAnimating()
        self.pokemonsView.searchBar.isHidden = true
        self.pokemonsView.sortBySegment.isHidden = true
    }
    
    private func hideSpinner() {
        self.pokemonsView.activityIndicatorView.stopAnimating()
        self.pokemonsView.searchBar.isHidden = false
        self.pokemonsView.sortBySegment.isHidden = false
    }
    
    private func dismissKeyboard() {
        self.pokemonsView.searchBar.resignFirstResponder()
    }
}

extension PokemonsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.replacingOccurrences(of: " ", with: "") == "" {
            viewModel.filtered = viewModel.pokemons
        }
        else {
            viewModel.filterBy(query: searchText)
        }
        pokemonsView.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
}

extension PokemonsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filtered.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let pokemonCell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonCell {
            pokemonCell.pokemon = viewModel.filtered[indexPath.row]
            return pokemonCell
        }
        return UITableViewCell()
    }
}

extension PokemonsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissKeyboard()
        tableView.reloadRows(at: [indexPath], with: .fade)
        let pokemonSelected = viewModel.filtered[indexPath.row]
        modalPresenter.present(from: self, destination: PokemonDetailViewController(pokemon: pokemonSelected), animated: true)
    }
}


