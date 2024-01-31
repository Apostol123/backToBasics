import XCTest
@testable import UIKitDesing

final class UIKitDesingTests: XCTestCase {
    func test_sut_on_viewLoad_loads_models() throws {
        //given
        let models = makeModels()
        let sut = makeSut(with: models)
       
        //When
        sut.viewDidLoad()
        //Then
        XCTAssertEqual(sut.numberOfRenderedCells, models.count)
    }
    
    private func makeSut(with models: [UIKitDesingImplDataModel] = []) -> UIKitDesingImpl {
        return UIKitDesingImpl(models: models)
    }
    
    private func makeModels() -> [UIKitDesingImplDataModel] {
        [UIKitDesingImplDataModel(), UIKitDesingImplDataModel()]
    }
}

private extension UIKitDesingImpl {
    
    var numberOfRenderedCells: Int {
        return tableView(tableView, numberOfRowsInSection: 1)
    }
}
