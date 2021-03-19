//
//  APIService.swift
//  SalesProject
//
//  Created by Ashwini shalke on 18/03/21.
//

import UIKit

class APIService : NSObject {
    
    static let sharedInstance = APIService()
    var salesDetail = [String: [String : Int]]()
    
    //reading JSON file
    func loadJson(filename fileName: String) -> [Product]? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        let decoder = JSONDecoder()
        let jsonData = try? decoder.decode(SalesData.self, from: data)
        return jsonData?.sales
    }
    
    func getSalesDetailArray(jsonData : [Product]) -> [String: [String : Int]] {
        var prodData = [String : Int]()
        for index in jsonData {
            if var productValue = salesDetail[index.prod] {
                if var priceValue = productValue[index.country] {
                    priceValue += index.price
                    productValue[index.country] = priceValue
                } else {
                    productValue[index.country] = index.price
                }
                salesDetail[index.prod] = productValue
            } else {
                prodData[index.country] = index.price
                salesDetail[index.prod] = prodData
            }
        }
        return salesDetail
    }
    
    func getProductName(prodData: [String: [String : Int]]) -> [String] {
        var prodName = [String]()
        for key in salesDetail.keys {
            prodName.append(key)
        }
        prodName.sort()
        return prodName
    }
}



