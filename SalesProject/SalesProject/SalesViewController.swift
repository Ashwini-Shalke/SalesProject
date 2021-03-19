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
        #warning("Pin tableview to viewcontroller")
        NSLayoutConstraint.activate([
            salesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            salesTableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            salesTableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
    }
}
