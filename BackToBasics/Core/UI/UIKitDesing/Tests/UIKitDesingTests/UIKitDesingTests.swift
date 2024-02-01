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
    
    func test_sut_given_ViewModels_cellRendersViewModelData() {
        //Given
        let models = makeModels()
        let sut = makeSut(with: models)
        //When
        sut.viewDidLoad()
        let cell = sut.cellAtRow(row: 0)
        //Then
        XCTAssertEqual(cell?.nameLabel.text, models[0].name)
        XCTAssertEqual(cell?.surnameLabel.text, models[0].surname)
        XCTAssertEqual(cell?.userImage, models[0].image)
    }
    
    private func makeSut(with models: [UIKitDesingImplDataModel] = []) -> UIKitDesingImpl {
        return UIKitDesingImpl(models: models)
    }
    
    private func makeModels() -> [UIKitDesingImplDataModel] {
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

private extension UIKitDesingImpl {
    
    var numberOfRenderedCells: Int {
        return tableView(tableView, numberOfRowsInSection: 1)
    }
    
    func cellAtRow(row: Int) -> UIKitDesingCell? {
        let indexPath = IndexPath(row: row, section: 1)
        let cell = tableView(tableView, cellForRowAt: indexPath) as? UIKitDesingCell
        return cell
    }
}
