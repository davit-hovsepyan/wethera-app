//
//  ViewController.swift
//  WeatherApp
//
//  Created by Davit Hovsepyan on 31.08.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var tempretureLable: UILabel!
    @IBOutlet var conditionLable: UILabel!
    @IBOutlet weak var textUserName: UITextField!
    
    private let weatherManager = WeaherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather()
       
     
    }
    private func fetchWeather(){
        weatherManager.fetchWeather(byCity: "yerevan") { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let model):
                this.updateView(with: model)
            case .failure(let error):
                print("error: \(error)")
            }
        }
        
    }
    
    private func updateView(with model: WeatherModel){
        tempretureLable.text = model.temp.toString().appending("°C")
        conditionLable.text = model.conditionDescription
        navigationItem.title = model.countryName
        conditionImageView.image = UIImage(named: model.conditionImage)
        
    }
    
    @IBAction func lockationButton(_ sender: Any) {
        performSegue(withIdentifier: "showAddCity", sender: nil)
    }
    @IBAction func lockationButtonPrest(_ sender: Any) {
    }
    
}

