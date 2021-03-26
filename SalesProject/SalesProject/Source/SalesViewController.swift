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
        return salesTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white        
        setupLayout()
    }
    
    func setupLayout(){
        salesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(salesTableView)
        NSLayoutConstraint.activate([
            salesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            salesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            salesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            salesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
