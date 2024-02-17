import SwiftUI
import Combine

public struct SwifUITableView: View {
    @ObservedObject private var viewModel: SwiftUIViewModel

    public init(model: SwiftUIViewModel) {
        self.viewModel = model
    }

    public var body: some View {
        List(viewModel.listItems) { item in
            TableViewCell(item: item)
        }
        .onAppear { 
            viewModel.viewDidAppear()
        }
    }
}

struct TableViewCell: View {
    let item: SwiftUIImplDataModel
    
    init(item: SwiftUIImplDataModel) {
        self.item = item
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
            Text(item.surname)
        }
    }
}
