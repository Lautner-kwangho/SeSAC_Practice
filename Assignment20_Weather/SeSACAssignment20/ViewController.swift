//
//  ViewController.swift
//  SeSAC_05Week
//
//  Created by 최광호 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {
        
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblCurrentPlace: UILabel!
    
    @IBOutlet weak var lblCurrentTemperatur: UILabel!
    @IBOutlet weak var lblCurrentHumidity: UILabel!
    @IBOutlet weak var lblCurrentAirVolume: UILabel!
    
    @IBOutlet weak var CurrentImage: UIImageView!
    @IBOutlet weak var HappyToday: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(patternImage: UIImage(named: "배경화면")!).withAlphaComponent(0.7)
        CurrentImage.backgroundColor = .white
        CurrentImage.layer.cornerRadius = CurrentImage.frame.size.height * 0.1
        apiSet()
        SetLabel()
    }
    
    func apiSet() {
        let apiID = APIKEY.apiID
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=37.555215936154354&lon=126.9707527092061&appid=\(apiID)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let country = json["sys"]["country"].stringValue
                let name = json["name"].stringValue
                let temp = json["main"]["temp"].doubleValue - 273.1
                let humidity = json["main"]["humidity"].intValue
                let speed = json["wind"]["speed"].doubleValue
                let icon = json["weather"][0]["icon"].stringValue
                
                let iconURL = "\(icon)".addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed)!
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "MM월 dd일 HH시 mm분"
                let time = formatter.string(from: date)
                
                self.lblCurrentTime.text = "\(time)"
                self.lblCurrentPlace.text = "\(country), \(name)"
                self.lblCurrentTemperatur.text = " 지금은 \(round(temp))°C 에요 "
                self.lblCurrentHumidity.text = " \(humidity)% 만큼 습해요 "
                self.lblCurrentAirVolume.text = " \(round(speed))m/s의 바람이 불어요 "
                self.CurrentImage.kingfisher("http://openweathermap.org/img/wn/\(iconURL)@2x.png")
                self.HappyToday.text = " 오늘도 행복한 하루 보내세요 "
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func SetLabel() {
        SetUILabel(lblCurrentTime, size: 15, backgroundColor: .clear, fontColor: .white)
        SetUILabel(lblCurrentPlace, size: 25, backgroundColor: .clear, fontColor: .white)
        SetUILabel(lblCurrentTemperatur, size: 17, backgroundColor: .white, fontColor: .black)
        SetUILabel(lblCurrentHumidity, size: 17, backgroundColor: .white, fontColor: .black)
        SetUILabel(lblCurrentAirVolume,size: 17, backgroundColor: .white, fontColor: .black)
        SetUILabel(HappyToday, size: 17, backgroundColor: .white, fontColor: .black)
    }
    
    func SetUILabel(_ lbl: UILabel, size: CGFloat, backgroundColor: UIColor, fontColor: UIColor) {
        lbl.font = UIFont.systemFont(ofSize: size)
        lbl.backgroundColor = backgroundColor
        lbl.textColor = fontColor
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = lbl.frame.size.height * 0.2
    }

    @IBAction func reloadButton(_ sender: UIButton) {
        viewWillAppear(true)
    }
}

extension UIImageView {
    func kingfisher(_ url: String){
        let url = URL(string: url)
        self.kf.setImage(with: url)
    }
}
