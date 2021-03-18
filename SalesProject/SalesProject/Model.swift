//
//  Model.swift
//  SalesProject
//
//  Created by Ashwini shalke on 18/03/21.
//

import UIKit

struct SalesData:Decodable {
    var sales: [Product]
}

struct Product : Decodable {
    var prod: String
    var country: String
    var price: Int
}
