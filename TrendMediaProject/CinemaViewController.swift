//
//  cinemaViewController.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/21.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import SwiftUI

class CinemaViewController: UIViewController {
    
    
    static let identifier = "CinemaViewController"
    
    let locationManager = CLLocationManager()
    
    var cinemaList = CinemaList()
    
    @IBOutlet weak var cinemaMapView: MKMapView!
    
    //commit
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let Location = CLLocationCoordinate2D(latitude: 37.5561245942409024, longitude: 126.97172843927478)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: Location, span: span)
        cinemaMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "HERE"
        annotation.coordinate = Location
        cinemaMapView.addAnnotation(annotation)
        
        
        //2.CLLocationManager() delegate연결
        locationManager.delegate = self

        let BtnImg = UIImage(systemName:"mappin.and.ellipse")
        let filterBtn = UIBarButtonItem(image:BtnImg, style:.plain, target: self, action: #selector(filterBtn(_:)))
        
        
        self.navigationItem.rightBarButtonItem = filterBtn
        
        ShowAnnotation()
    }

    func ShowAnnotation () {
        
        for cinema in cinemaList.mapAnnotations {
            let location = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
            let annotation = MKPointAnnotation()
            annotation.title = cinema.type
            annotation.subtitle = "TestSubtitle"
            annotation.coordinate = location
            
            
            cinemaMapView.addAnnotation(annotation)
            
        }
    }
    
    
}




extension CinemaViewController: CLLocationManagerDelegate {
    
  
    @objc func filterBtn(_ sender: UIBarButtonItem) {
        
    //    let sb = UIStoryboard(name: "Main", bundle: nil)
    //
    //    let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
    //
    //    let nav = UINavigationController(rootViewController: vc)
    //
    //    nav.modalPresentationStyle = .fullScreen
    //
    //    present(nav, animated: true, completion: nil)
    //
    //
    //    print("SearchClicked")
    }
    
    
    func checkUserLocationServicesAuthorization(){
        
            
            let authorizationStatus: CLAuthorizationStatus
            
            if #available(iOS 14.0, *) {
                
            authorizationStatus = locationManager.authorizationStatus //iOS14 이상에만 사용가능!
            } else {
            authorizationStatus = CLLocationManager.authorizationStatus() //iOS14미만일 때 사용!
            }
            //iOS위치 서비스 확인
            if CLLocationManager.locationServicesEnabled(){
                //권한 상태 확인 및 권한 요청 가능 (7번메서드 실행)
                checkCurrentLocationAuthorization(authorizationStatus)
            } else {
                print("위치서비스를 켜주세요")
            }
        }

    func checkCurrentLocationAuthorization(_ authorizationStatus:CLAuthorizationStatus){
        
        switch authorizationStatus{
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
        print("denied, 설정으로 유도")
            
        case .authorizedAlways:
            print("Always")
            
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()//위치접근 시작! => didUpdatedLocation 실행!
            
        @unknown default:
            print("default")
        }
        
        if #available(iOS 14.0, *){
            
            //정확도 체크: 정확도가 감소되어 있을경우 1시간 4번, 미리알림
            let accurancyState = locationManager.accuracyAuthorization
            
            switch accurancyState {
            case .fullAccuracy:
                print("Full")
            case .reducedAccuracy:
                print("ReDuce")
            @unknown default:
                print("DEFAULt")
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
    
        
        if let coordinate = locations.last?.coordinate {
            
            let annotation = MKPointAnnotation()
            annotation.title = "Current Location"
            annotation.coordinate = coordinate
            cinemaMapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            cinemaMapView.setRegion(region, animated: true)
            
            //8. 중요
            locationManager.startUpdatingLocation()
            
            showTitle(coordi:coordinate)
            
        } else {
            print("Location Cannot Find")
        }
    }
    
    
    func getCurrentAdress(location:CLLocation){
        let geoCoder : CLGeocoder = CLGeocoder()
        let location : CLLocation = location
        //한국어 주소 설정
        let locale = Locale(identifier: "Ko-kr")
        //위경도를 통해 주소 변환
        geoCoder.reverseGeocodeLocation(location, preferredLocale: locale, completionHandler: {(placemark,error)->Void in
            guard error == nil, let place = placemark?.first else {
                print("주소설정 불가능")
                return
            }
            
            if let administrativeArea = place.administrativeArea {
                print(administrativeArea)
            }
            if let locality = place.locality {
                print(locality)
            }
            if let subLocality = place.subLocality{
                print(subLocality)
            }
            
            if let subThoroughfare = place.subThoroughfare{
                print(subThoroughfare)
            }
        })
    }
    //5.위치 접근 실패시
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let coordinate = CLLocationCoordinate2D(latitude: 37.5561245942409024, longitude: 126.97172843927478)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.title="서울시청"
        annotation.coordinate = coordinate
        cinemaMapView.addAnnotation(annotation)
        
        cinemaMapView.setRegion(region, animated: true)
    }
    
    
    
    //6-1 iOS14 미만: 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌.
    //권한이 변경될 때 마다 감지해서 실행이 됨
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        print(#function)
    }
    
    //6-2. iOS14 이상: 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌.
    //권한이 변경될 때 마다 감지해서 실행이 됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    //내 위치 표시하기
    
    func showTitle(coordi:CLLocationCoordinate2D){
        let geocoder = CLGeocoder()
        let findLocation = CLLocation(latitude: coordi.latitude, longitude: coordi.longitude)
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address : [CLPlacemark] = placemarks {
                let gu = address[0].locality!
                let dong = address[0].thoroughfare!
                
                self.title = "\(gu) \(dong)"
            }
            
        })
    }


}
