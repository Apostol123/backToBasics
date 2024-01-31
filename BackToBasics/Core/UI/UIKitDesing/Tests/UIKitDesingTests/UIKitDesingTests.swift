import XCTest
@testable import UIKitDesing

final class UIKitDesingTests: XCTestCase {
    func test_sut_on_viewLoad_loads_cells() throws {
        //given
        let sut = makeSut()
        //When
        sut.viewDidLoad()
        //Then
        XCTAssertEqual(sut.numberOfRenderedCells, 1)
    }
    
    private func makeSut() -> UIKitDesingImpl {
        return UIKitDesingImpl(nibName: nil, bundle: nil)
    }
}

private extension UIKitDesingImpl {
    
    var numberOfRenderedCells: Int {
        return tableView(tableView, numberOfRowsInSection: 1)
    }
}
