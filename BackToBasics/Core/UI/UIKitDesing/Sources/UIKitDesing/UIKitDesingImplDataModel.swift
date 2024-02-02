//
//  File.swift
//  
//
//  Created by Alex.personal on 31/1/24.
//

import Foundation
import UIKit

public struct UIKitDesingImplDataModel: Equatable {
    public let name: String
    public let surname: String
    public let image: UIImageView
    
    public static func == (lhs: UIKitDesingImplDataModel, rhs: UIKitDesingImplDataModel) -> Bool {
        return lhs.name == rhs.name &&
        lhs.surname == rhs.surname &&
        lhs.image.image?.pngData() == rhs.image.image?.pngData()
    }
    
}
