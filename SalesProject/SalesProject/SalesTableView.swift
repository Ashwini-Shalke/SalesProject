//
//  TableViewCell.swift
//  SalesProject
//
//  Created by Ashwini shalke on 18/03/21.
//

import UIKit

protocol salesTableViewDelegate : AnyObject {
    func handleSelectRowAt(country: String, price : Int)
}

class SalesTableView: UITableView {
    weak var salesTableDelegate: salesTableViewDelegate?

    let cellId = "CellID"
    var jsonData = [Product]()
    var prodData = [String : Int]()
    var prodDetail = [String: [String : Int]]()
    var prodKeys = [String]()
    
    let screenLockSwitch: UISwitch = {
        let screenLock = UISwitch(frame: .zero)
        screenLock.isUserInteractionEnabled = true
        return screenLock
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style:style)
        self.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.delegate = self
        self.dataSource = self
        self.separatorColor = UIColor.clear
        self.rowHeight = 70
        guard let data = loadJson(filename: "Data") else {return}
        jsonData = data
        getProductDetailArray()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getProductDetailArray(){
        for index in jsonData {
            if var productValue = prodDetail[index.prod] {
                if var priceValue = productValue[index.country] {
                    priceValue += index.price
                    productValue[index.country] = priceValue
                } else {
                    productValue[index.country] = index.price
                 }
                prodDetail[index.prod] = productValue
            } else {
                prodData[index.country] = index.price
                prodDetail[index.prod] = prodData
            }
        }
        
        prodKeys = fetchKeyProdDetail()
        print(prodKeys)
        
    }
    
    func fetchKeyProdDetail() -> [String]{
        var keys = [String]()
        for key in prodDetail.keys {
            keys.append(key)
        }
        keys.sort()
        return keys
    }
    
}

extension SalesTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prodDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "Product Name  \(prodKeys[indexPath.row])"
        return cell
    }
    
    func loadJson(filename fileName: String) -> [Product]? {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(SalesData.self, from: data)
                    return jsonData.sales
                } catch {
                    print("error:\(error)")
                }
            }
            return nil
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ProdKey = prodKeys[indexPath.row]
        if let prodDetailArray = prodDetail[ProdKey] {
           let highestSale = prodDetailArray.max { a , b  in a.value < b.value}
            guard let countryValue = highestSale?.key else {return}
            guard let priceValue = highestSale?.value else {return }
            salesTableDelegate?.handleSelectRowAt(country: countryValue, price: priceValue)
            }     
        }
    }
    
    

