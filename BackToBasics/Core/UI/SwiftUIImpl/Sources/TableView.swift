//
//  SwiftUIView.swift
//  
//
//  Created by Alex.personal on 13/2/24.
//

import SwiftUI

public struct SwifUITableView: View {
    private let viewModel: SwiftUIViewModel
    
    public init(model: SwiftUIViewModel) {
        self.viewModel = model
    }
    
    @State var listItems: [SwiftUIImplDataModel] = []
    public var body: some View {
        
        List(listItems) { item in
            Text(item.name)
            Text(item.surname)
           
        }.onAppear {
            viewModel.getData { result in
                switch result {
                case .success(let success):
                    self.listItems = success
                case .failure(let failure):
                    break
                }
            }
        }
       
    }
}

