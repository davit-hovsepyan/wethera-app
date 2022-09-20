//
//  SecondView.swift
//  WeatherApp
//
//  Created by Davit Hovsepyan on 12.09.22.
//

import UIKit

class SecondView: UIViewController{
    
    
    
    @IBOutlet var cityText: UITextField!
    @IBOutlet var searcthLable: UIButton!
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet var statusLable: UILabel!
    
    private let weatherManager = WeatherManager()
    weak var delegate: WeatherViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cityText.becomeFirstResponder()
        activity.isHidden = true
    }
    
    private  func setupView(){
        view.backgroundColor = UIColor(white: 0.9, alpha: 0.4)
        statusLable.isHidden = true
    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissViewController(){
        dismiss(animated: true, completion: nil)
        
    }
 
    @IBAction func didAction(_ sender: Any) {
        statusLable.isHidden = true
        activity.isHidden = false
        guard let querty = cityText.text, !querty.isEmpty else {
            funcshovSearch(text: "City canot be empty. Pleas try again")
            return }
        searchForCity(querty: querty)
        
    }
    private func funcshovSearch (text: String){
        statusLable.isHidden = false
        statusLable.textColor = .systemRed
        statusLable.text = text
        activity.isHidden = true
    }
    
  private func searchForCity(querty: String){
        activity.startAnimating()
        weatherManager.fetchWeather(byCity: querty) { [weak self] (result) in
            guard let this = self else { return }
            this.activity.stopAnimating()
                switch result {
                case .success(let model):
                    this.handleSearch(model: model)
                case .failure(let error):
                    this.funcshovSearch(text: error.localizedDescription)
                }
            }
      }
    private func handleSearch(model: WeatherModel){
        statusLable.isHidden = false
        statusLable.textColor = .systemGreen
        statusLable.text = "Success"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){ [weak self] in
            
            self?.delegate?.didUpdatWeatherFormSearch(model: model)
        }
    }
    }

extension SecondView: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}
