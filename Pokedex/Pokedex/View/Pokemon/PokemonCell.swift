//
//
//  Created by Khatib Mahad H. on 7/19/21.
//

import UIKit

final class PokemonCell: UITableViewCell {

    var pokemon: Pokemon? {
        didSet {
            
            guard let id = pokemon?.id, let name = pokemon?.name.capitalized else {
                return
            }
            self.nameLabel.text = String(format: "%d %@", id, name)
            
            guard let defaultImageURL:String = pokemon?.sprites.frontDefault else {
                return
            }
            self.thumbImageView.loadThumbnail(urlSting: defaultImageURL)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let thumbImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        return imageView
    }()
    let nameLabel = PokedexLabel(style: .title3)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thumbImageView, nameLabel])
        stackView.spacing = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func commonInit() {
        backgroundColor = .white
        safelyAddSubview(stackView)
        
        thumbImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        thumbImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: thumbImageView.centerYAnchor, constant: 0).isActive = true
    }
}
