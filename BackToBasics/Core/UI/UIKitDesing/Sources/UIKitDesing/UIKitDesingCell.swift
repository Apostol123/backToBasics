//
//  File.swift
//  
//
//  Created by Alex.personal on 1/2/24.
//

import Foundation
import UIKit

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
}
