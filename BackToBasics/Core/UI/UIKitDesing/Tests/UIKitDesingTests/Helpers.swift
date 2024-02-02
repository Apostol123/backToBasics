//
//  File.swift
//  
//
//  Created by Alex.personal on 2/2/24.
//

import Foundation
import XCTest
@testable import UIKitDesing

extension XCTestCase {
    static func makeModels() -> [UIKitDesingImplDataModel] {
        [
            UIKitDesingImplDataModel(
                name: "a name",
                surname: "a surname",
                image: UIImageView()
            ),
            UIKitDesingImplDataModel(
                name: "another name",
                surname: "another surname",
                image: UIImageView()
            )
        ]
    }
}
