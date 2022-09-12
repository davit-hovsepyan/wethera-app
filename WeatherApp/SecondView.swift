//
//  SecondView.swift
//  WeatherApp
//
//  Created by Davit Hovsepyan on 12.09.22.
//

import UIKit

class SecondView: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private  func setupView(){
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.4)
    }
}
