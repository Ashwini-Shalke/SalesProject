//
//  ViewController.swift
//  SalesProject
//
//  Created by Ashwini shalke on 18/03/21.
//

import UIKit

class SalesViewController: UIViewController {
   
   lazy var salesTableView: SalesTableView = {
        var salesTableView = SalesTableView()
        salesTableView.salesTableDelegate = self
        return salesTableView
    }()
    
    let salesDetailLabel: UILabel = {
       let salesDetail = UILabel()
        salesDetail.backgroundColor     = .systemRed
        salesDetail.font    = UIFont(name: "georgia", size: 20)
        salesDetail.textColor = .white
        salesDetail.textAlignment = .center
        salesDetail.layer.borderColor   = UIColor.white.cgColor
        salesDetail.layer.cornerRadius  = 5
        salesDetail.layer.borderWidth   = 4.0
        salesDetail.translatesAutoresizingMaskIntoConstraints = false
        return salesDetail
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupLayout()
    }
    
    func setupLayout(){
        salesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(salesTableView)
        NSLayoutConstraint.activate([
                                        salesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                        salesTableView.heightAnchor.constraint(equalToConstant: 250),
                                        salesTableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)])
        
        view.addSubview(salesDetailLabel)
        NSLayoutConstraint.activate([
                                        salesDetailLabel.topAnchor.constraint(equalTo: salesTableView.bottomAnchor, constant: 30),
                                        salesDetailLabel.heightAnchor.constraint(equalToConstant: 70),
                                        salesDetailLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)])
        
    }
}

extension SalesViewController : salesTableViewDelegate {
    
    func handleSelectRowAt(country: String, price: Int) {
        salesDetailLabel.text = "\(country) - Totalprice :\(price)"
    }
}



