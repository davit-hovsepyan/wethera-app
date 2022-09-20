//
//  ViewController.swift
//  WeatherApp
//
//  Created by Davit Hovsepyan on 31.08.22.
//

import UIKit
import SkeletonView

protocol WeatherViewControllerDelegate: AnyObject {
    func didUpdatWeatherFormSearch(model: WeatherModel)
}

class ViewController: UIViewController {
 
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var tempretureLable: UILabel!
    @IBOutlet var conditionLable: UILabel!
    
    private let weatherManager = WeatherManager()
    
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
                print("error: \(error.localizedDescription)")
            }
        }
        
    }
    
    private func updateView(with model: WeatherModel){
        tempretureLable.text = model.temp.toString().appending("°C")
        conditionLable.text = model.conditionDescription
        conditionImageView.image = UIImage(named: model.conditionImage)
        navigationItem.title = model.countryName

    }
    
    @IBAction func lockationButton(_ sender: Any) {
        performSegue(withIdentifier: "showAddCity", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddCity" {
            if let destination = segue.destination as? SecondView {
                
                destination.delegate = self
            }
        }
    }
    
    @IBAction func lockationButtonPrest(_ sender: Any) {
    }
    
}

extension ViewController: WeatherViewControllerDelegate {
    func didUpdatWeatherFormSearch(model: WeatherModel) {
        presentedViewController?.dismiss(animated: true, completion: { [weak self] in
            guard let this = self else {return}

            this.updateView(with: model)
        })

    }
  
}
