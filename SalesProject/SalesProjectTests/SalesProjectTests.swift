//
//  SalesProjectTests.swift
//  SalesProjectTests
//
//  Created by Ashwini shalke on 18/03/21.
//

import XCTest
@testable import SalesProject

class SalesProjectTests: XCTestCase {
    
    func testLoadJson() {
        let data = APIService.sharedInstance.loadJson(filename: "Data")
        XCTAssertNotNil(data)
    }
    
    func testFailToLoadJson() {
        let data = APIService.sharedInstance.loadJson(filename: "Dat")
        XCTAssertNil(data)
    }
    
    func testValidJson() {
        let result = APIService.sharedInstance.loadJson(filename: "SampleData")
        let output = [Product(prod: "E", country: "USA", price: 8000), Product(prod: "C", country: "USA", price: 2000)]
        XCTAssertEqual(output, result)
    }

    func testgetSalesDetailArray(){
        let product = [Product(prod: "U", country: "US", price: 10), Product(prod: "U", country: "US", price: 20), Product(prod: "V", country: "UK", price: 20)]
        let productData = APIService.sharedInstance.getSalesDetailArray(jsonData: product)
        let result = ["V": ["UK": 20], "U": ["US": 30]]
        XCTAssertEqual(productData, result)
    }
 
    func testFalseGetSalesDetailArray(){
        let product = [Product(prod: "U", country: "US", price: 10), Product(prod: "U", country: "US", price: 20), Product(prod: "V", country: "UK", price: 20)]
        let productData = APIService.sharedInstance.getSalesDetailArray(jsonData: product)
        let result = ["V": ["UK": 30], "U": ["US": 30]]
        XCTAssertFalse(productData ==  result)
    }
    
    func testNilGetSalesDetailArray(){
        let productData = APIService.sharedInstance.getSalesDetailArray(jsonData: nil)
        XCTAssertNil(productData)
    }
     
    func testGetProductName() {
        let some: [String: [String : Int]] = ["anil" :["a": 10],"ashu" :["b": 11]]
        let value = APIService.sharedInstance.getProductName(prodData: some)
        XCTAssertEqual(["anil","ashu"], value)
    }
    
    func testNilGetProductName(){
        let value = APIService.sharedInstance.getProductName(prodData: nil)
        XCTAssertNil(value)
    }
    
    func testFalseGetProductName() {
        let some: [String: [String : Int]] = ["anil" :["a": 10],"ashu" :["b": 11]]
        let value = APIService.sharedInstance.getProductName(prodData: some)
        XCTAssertFalse(value == ["anil1","ashu"])
    }
}
