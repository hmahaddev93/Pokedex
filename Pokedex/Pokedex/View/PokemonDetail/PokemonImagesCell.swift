//
//  PokemonImagesCell.swift
//  Pokedex
//
//  Created by Khateeb Mahad H. on 8/12/21.
//

import UIKit

final class PokemonImagesCell: UITableViewCell {

    var imageUrls: [String]? {
        didSet {
            guard let imageUrls = imageUrls else {
                return
            }
            
            stackView.removeFullyAllArrangedSubviews()
            for imageUrl in imageUrls {
                let imageView: UIImageView = {
                    let imageView = UIImageView(frame: .zero)
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                    NSLayoutConstraint.activate([
                        imageView.widthAnchor.constraint(equalToConstant: 40),
                        imageView.heightAnchor.constraint(equalToConstant: 40)
                    ])
                    return imageView
                }()
                imageView.loadThumbnail(urlSting: imageUrl)
                stackView.addArrangedSubview(imageView)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.spacing = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func commonInit() {
        backgroundColor = .white
        safelyAddSubview(stackView)
    }
}
