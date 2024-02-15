//
//  File.swift
//  
//
//  Created by Alex.personal on 14/2/24.
//

import Foundation

public struct SwiftUIImplDataModel: Equatable, Identifiable {
    public var id = UUID()
    public let name: String
    public let surname: String
    public let imageURL: String
}
