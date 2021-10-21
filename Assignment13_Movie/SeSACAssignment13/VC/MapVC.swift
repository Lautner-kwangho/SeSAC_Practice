//
//  MapViewController.swift
//  SeSACAssignment13
//
//  Created by 최광호 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import SwiftUI
import CarPlay
import Accelerate

class MapVC: UIViewController {
    static let identifier = "MapVC"
    
    @IBOutlet weak var mapView: MKMapView!
    var mapAnnotation = MapAnnotations()
    let locationManager = CLLocationManager()
    let movie = ["메가박스", "롯데시네마", "CGV", "전체보기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        loopLocation(name: "전체보기")

        
    }
    
    // 위도와 경도, 스팬(영역 폭)을 입력받아 지도에 표시
    func movieLocation(type: String, latitudeValue: CLLocationDegrees, longtudeValue: CLLocationDegrees, span: Double, location: String) -> CLLocationCoordinate2D {
        let location = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
        let span = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        return location
    }
    

    
    func navigationItem() {
        let alertTheater = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(activationAlert))
        navigationItem.rightBarButtonItem = alertTheater
    
        

        navigationItem.title = "행복동"
    }
    
    func loopLocation(name: String) {
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)

        for movie in MapAnnotations().mapAnnotations.indices {
            let a = MapAnnotations().mapAnnotations[movie].type
            let b = MapAnnotations().mapAnnotations[movie].latitude
            let c = MapAnnotations().mapAnnotations[movie].longitude
            let d = MapAnnotations().mapAnnotations[movie].location
            
            let annotation = MKPointAnnotation()

            if a == name || name == "전체보기" {
            annotation.coordinate = (self.movieLocation(type: a, latitudeValue: CLLocationDegrees(b), longtudeValue: CLLocationDegrees(c), span: 0.2, location: d))
            annotation.title = a
            self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    @objc func activationAlert() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let megaAction = UIAlertAction(title: "메가박스", style: .default, handler: {_ in
            self.loopLocation(name: "메가박스")
        })
        let lotteAction = UIAlertAction(title: "롯데시네마", style: .default, handler: {_ in
            self.loopLocation(name: "롯데시네마")
        })
        let cgvAction = UIAlertAction(title: "CGV", style: .default, handler: {_ in
            self.loopLocation(name: "CGV")
        })
        let allAction = UIAlertAction(title: "전체보기", style: .default, handler: {_ in
            self.loopLocation(name: "전체보기")
        })
        let cancleAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(megaAction)
        alert.addAction(lotteAction)
        alert.addAction(cgvAction)
        alert.addAction(allAction)
        alert.addAction(cancleAction)
        
        self.present(alert, animated: false)
        
    }
    

}

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        guard let annotaionLocation = locations.last else { return }
        CLGeocoder().reverseGeocodeLocation(annotaionLocation) { placemarks, Error in
            guard let pm = placemarks?.first else { return }
            guard let contry = pm.locality else {return}
            var address: String = contry

            if let fare = pm.thoroughfare {
                address += " "
                address += fare
            }
            self.navigationItem.title = address
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 6. iOS15 이상 권한 확인 (매 업데이트)
        print(#function)
        checkUserLocationServiceAuthrization()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 7. iOS14 이하 권한 확인
        print(#function)
        checkUserLocationServiceAuthrization()
    }
    // 8. 여기서 정신 바짝 * UDF
    // 초기 권한 확인 _ 현재 위치 허용할지!
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        print(#function)

        let alertOk = UIAlertAction(title: "ok", style: .default, handler: {_ in
            self.locationManager.requestAlwaysAuthorization()})
//        let alertOk = UIAlertAction(title: "ok", style: .default, handler: nil)

        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted:
            let childrenAlert = UIAlertController(title: "Nooo", message: "접근 불가능해요", preferredStyle: .alert)
            childrenAlert.addAction(alertOk)
            self.present(childrenAlert, animated: true)
        case .denied:
            let deniedAlert = UIAlertController(title: "Denied Auth", message: "권한이 거부 되어 있습니다", preferredStyle: .alert)
            deniedAlert.addAction(alertOk)
            self.present(deniedAlert, animated: true)
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorized:
            return
        case .authorizedAlways:
            print("Always")
        @unknown default:
            print("default")
        }
        
        if #available(iOS 14.0, *) {
            let accuracyStatus = locationManager.accuracyAuthorization
            switch accuracyStatus {
            case .fullAccuracy:
                print("정확도 최상")
            case .reducedAccuracy:
                print("대충 여기쯤?")
            @unknown default:
                print("default")
            }
        }
    }
    // 9. iOS 분기 처리 + 서비스 켠지 안켠지 확인 (2가지가 들어가게 됨)
    func checkUserLocationServiceAuthrization() {
        print(#function)

        let authorizationStatus: CLAuthorizationStatus
        
        // iOS 분기처리
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        // 서비스 켠지 안켠지 확인
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus)
            self.mapView.setUserTrackingMode(.follow, animated: true)
        } else {
            let alert = UIAlertController(title: "iOS 위치 서비스 오류", message: "iOS 위치 서비스를 허용하셔야 앱을 이용하실 수 있습니다. 설정에서 권한 허용 후 이용해주시길 바랍니다", preferredStyle: .alert)
            let alertOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertOk)
            present(alert, animated: true, completion: nil)
        }
    }

}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(#function)
        print(mapView.selectedAnnotations)
        print("나 여기")
    }
}
