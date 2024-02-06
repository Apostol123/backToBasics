//
//  UIKitDesignViewModellTests.swift
//
//
//  Created by Alex.personal on 1/2/24.
//

import XCTest
import URLRequestFactory
@testable import UIKitDesing
import NetworkServiceAbstractionLayer
import Stubs

final class UIKitDesignViewModellTests: XCTestCase {
    
    func test_viewModel_onGetDataRequest_withSucces_Expecte_sucessReturn() throws {
        //given
        let mockData = try makeUserMockData()
        let mockUser = try XCTUnwrap( makeUserMock().users.first)
        let model = UIKitDesingImplDataModel(name: mockUser.maidenName, surname: mockUser.firstName, imageURL: mockUser.image)
       
        //when
        URLProtocolStub.stub(data: mockData, response: nil, error: nil)
        completeGetData(with: .success([model]))
        
    }
    
    func test_viewModel_onGetDataRequest_withInvalidData_Expecte_ErrorReturn() throws {
        //given
        let mockData = try anyData()
        //when
        URLProtocolStub.stub(data: mockData, response: nil, error: nil)
        //then
        completeGetData(with: .failure(NetworkServiceAbstractionLayerError.decodingFailed))
        
    }
    
    func test_viewModel_onGetDataRequest_withError_Expecte_ErrorReturn() throws {
        //when
        URLProtocolStub.stub(data: nil, response: nil, error: anyError())
        //then
        completeGetData(with: .failure(NetworkServiceAbstractionLayerError.anyError(error: anyError())))
        
    }
    
    private func completeGetData(with giveResult:  Result<[UIKitDesingImplDataModel],Error>) {
        let mockNS = makeNetworkServiceAbstractionLayerStub()
        let sut = UIKitDesignViewModel(service: mockNS)
        let exp = expectation(description: "Wait for load completion")
        sut.getData { result in
            switch (giveResult, result) {
            case let (.success(givenModels), .success(expectedModels)):
                XCTAssertEqual(givenModels, expectedModels)
                
            case let (.failure(recievedError), .failure(expectedError)):
                XCTAssertEqual(recievedError as NSError, expectedError as NSError)
                
            default:
                XCTFail("Expected \(giveResult) got \(result) instead")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func makeNetworkServiceAbstractionLayerStub() -> NetworkServiceAbstractionLayerProtocol {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        return NetworkServiceAbstractionLayer(session: session)
    }

    enum ViewModelErrors: Error {
        case wrongImageURL
    }
    
    private func anyError() -> NSError {
        return NSError(domain: "www.anydomin.com", code: 0)
    }
    
    private func anyData() throws -> Data? {
        let data = String("Any-data").data(using: .utf8)
        return data
    }
    
    private func makeUserMock() -> Users {
        // Mock Values
        let mockCoordinates = Coordinates(lat: 37.7749, lng: -122.4194)
        let mockAddress = Address(address: "123 Mock St", city: "Mock City", coordinates: mockCoordinates, postalCode: "12345", state: "Mock State")
        let mockBank = Bank(cardExpire: "12/25", cardNumber: "**** **** **** 1234", cardType: "Visa", currency: "USD", iban: "US12345678901234567890")
        let mockCompanyAddress = Address(address: "456 Mock St", city: "Mock City", coordinates: mockCoordinates, postalCode: "54321", state: "Mock State")
        let mockCompany = Company(address: mockCompanyAddress, department: "Mock Department", name: "Mock Company", title: "Mock Title")
        let mockHair = Hair(color: "Brown", type: "Straight")
        
        // Mock User
        let mockUser = User(id: 1, firstName: "John", lastName: "Doe", maidenName: "Maiden", age: 25, gender: "Male", email: "john.doe@example.com", phone: "123-456-7890", username: "johndoe", password: "mockpassword", birthDate: "1999-01-01", image: "profile_image.jpg", bloodGroup: "O+", height: 180, weight: 75.5, eyeColor: "Blue", hair: mockHair, domain: "example.com", ip: "192.168.0.1", address: mockAddress, macAddress: "00:11:22:33:44:55", university: "Mock University", bank: mockBank, company: mockCompany, ein: "123456789", ssn: "987654321", userAgent: "Mock User Agent")
        
        // Mock Users
        let mockUsers = Users(users: [mockUser], total: 1, skip: 0, limit: 10)
        
        return mockUsers
    }
    
    private func makeUserMockData() throws -> Data? {
        
        let mockUsers = makeUserMock()
        
        return try JSONEncoder().encode(mockUsers)
        
    }
}

