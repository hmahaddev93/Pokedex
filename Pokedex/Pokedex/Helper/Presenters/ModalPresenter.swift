//
//  ModalPresenter.swift
//  Pokedex
//
//  Created by Khateeb Mahad H. on 8/12/21.
//

import UIKit

protocol ModalPresenter_Proto {
    func present(from: UIViewController, destination: UIViewController, animated: Bool)
    func dismiss(from: UIViewController, animated: Bool)
}

class ModalPresenter: ModalPresenter_Proto {
    func dismiss(from: UIViewController, animated: Bool) {
        from.dismiss(animated: true)
    }
    
    func present(from: UIViewController, destination: UIViewController, animated: Bool) {
        from.present(destination, animated: true)
    }
}
