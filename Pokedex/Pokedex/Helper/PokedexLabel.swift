//
//  MTLabel.swift
//  
//
//  Created by Khatib Mahad H. on 8/3/21.
//
import UIKit

final class PokedexLabel: UILabel {
    public init(style: UIFont.TextStyle, alignment: NSTextAlignment = .left) {
        super.init(frame: .zero)
        self.numberOfLines = 0
        self.textAlignment = alignment
        self.lineBreakMode = .byTruncatingTail
        self.font = .preferredFont(forTextStyle: style)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
