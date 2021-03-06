//
//  TableViewCell.swift
//  SalesProject
//
//  Created by Ashwini shalke on 18/03/21.
//

import UIKit

class SalesTableView: UITableView {
    let cellId = "CellID"
    var salesDetail = [String: [String : Int]]()
    var productName = [String]()
    var maxSalesPrice = String()
    var selectedCell : IndexPath?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style:style)
        self.setupTableView()
        self.handleSalesData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleSalesData() {
        guard let data = APIService.sharedInstance.loadJson(filename: "Data") else { return }
        guard let sales = APIService.sharedInstance.getSalesDetailArray(jsonData: data) else { return }
        salesDetail = sales
        guard let products = APIService.sharedInstance.getProductName(prodData: salesDetail) else {return}
        productName = products
    }
    
    fileprivate func setupTableView() {
        self.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.delegate = self
        self.dataSource = self
        self.separatorColor = UIColor.clear
        self.rowHeight = 70
    }
}

extension SalesTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salesDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.selectionStyle = .none
        cell.textLabel?.text = "Product Name  \(productName[indexPath.row])"
        cell.accessoryType = UITableViewCell.AccessoryType.detailButton
        if selectedCell?.row == indexPath.row {
            cell.detailTextLabel?.text = maxSalesPrice
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let ProdKey = productName[indexPath.row]
        guard let maxSales = APIService.sharedInstance.getMaxSalePrice(salesDetail: salesDetail, key: ProdKey) else { return }
        maxSalesPrice = maxSales
        selectedCell = indexPath
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
  


