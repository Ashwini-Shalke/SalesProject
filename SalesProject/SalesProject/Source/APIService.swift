//
//  APIService.swift
//  SalesProject
//
//  Created by Ashwini shalke on 18/03/21.
//

import UIKit

class APIService : NSObject {

    static let sharedInstance = APIService()

    //reading JSON file
    func loadJson(filename fileName: String?) -> [Product]? {
        guard let file = fileName else { return nil }
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        let decoder = JSONDecoder()
        let jsonData = try? decoder.decode(SalesData.self, from: data)
        return jsonData?.sales
    }
    
    func getSalesDetailArray(jsonData : [Product]?) -> [String: [String : Int]]? {
        var salesDetail = [String: [String : Int]]()
        guard  let data = jsonData else { return nil }
        
        for index in data {
            if var productValue = salesDetail[index.prod] {
                if var priceValue = productValue[index.country] {
                    priceValue += index.price
                    productValue[index.country] = priceValue
                } else {
                    productValue[index.country] = index.price
                }
                salesDetail[index.prod] = productValue
            } else {
                var prodData = [String : Int]()
                prodData[index.country] = index.price
                salesDetail[index.prod] = prodData
            }
        }
        return salesDetail
    }
    
    func getProductName(prodData: [String: [String : Int]]?) -> [String]? {
        var prodName = [String]()
        guard let keys = prodData?.keys else {return nil}
        for key in keys {
            prodName.append(key)
        }
        prodName.sort()
        return prodName
    }
    
    
    func getMaxSalePrice(salesDetail : [String: [String : Int]], key: String ) -> String? {
        var maxSalesPrice : String?
        if let prodDetailArray = salesDetail[key] {
            let highestSale = prodDetailArray.max { a , b  in a.value < b.value}
            guard let countryValue = highestSale?.key else { return nil }
            guard let priceValue = highestSale?.value else { return nil }
            maxSalesPrice = "Max Total Sale in \(countryValue):\(priceValue)"
        }
        return maxSalesPrice
    }
}



