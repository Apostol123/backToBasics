//
//  File.swift
//  
//
//  Created by Alex.personal on 1/2/24.
//

import Foundation
import UIKit
import SwiftUI

public final class UIKitDesingCell: UITableViewCell {
    public static let reuseIdentifier: String = String(describing: UIKitDesingCell.self)
    
    public var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var surnameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var userImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var loaderIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var  stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, surnameLabel, userImage])
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    public func setupView() {
        loaderIndicator.frame = contentView.frame
        contentView.addSubview(loaderIndicator)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

public extension UIActivityIndicatorView {
     func toggleAnimation() {
        self.isAnimating ? self.stopAnimating() : self.startAnimating()
    }
}
