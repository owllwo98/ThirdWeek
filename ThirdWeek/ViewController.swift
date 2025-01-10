//
//  ViewController.swift
//  ThirdWeek
//
//  Created by 변정훈 on 1/8/25.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var mapView: MKMapView!
    
    let user: [User] = [
        User(name: "a"),
        User(name: "b")
    ]
    
    
    let person: [User] = [
        .init(name: "a"),
        .init(name: "b")
    ]
    
    let pickerView = UIPickerView()
    
    var list = ["가", "나", "다"]
    let array = ["1", "2", "3", "4",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondTextField.textColor = .red
        secondTextField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        userTextField.delegate = self
        
        mapView.delegate = self
        
        configureMapView()
    }
}

class User {
    var name: String
    init(name: String) {
        self.name = name
    }
}


// MARK: 피커뷰 설정
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? list.count : array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? list[row] : array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print(component, row)
        
        if component == 0 {
            secondTextField.text = list[row]
        } else {
            secondTextField.text = array[row]
        }
    }
}

// MARK: TextField 설정
extension ViewController: UITextFieldDelegate {
    
    // did end on exit 이랑은 조금 다르다
    // 키보드에서 엔터키 클릭했을 때
    // 만약 userTextField 에서만 해당 기능을 사용하고 싶고 secondTextField 에서는 사용하고 싶지 않다면
    /*
     1. 해당 메서드에 제약조건
     2. delegate 연결안하기
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userTextField {
            view.endEditing(true)
        }
        return true
    }
}

// MARK: Configure 설정
extension ViewController {
    
    /*
     1. 중간지점
     2. 축척 100m
     3. 핀 설정 -> 어노테이션
     */
    
    func configureMapView() {
        
        let center = CLLocationCoordinate2D(latitude: 37.65370, longitude: 127.04740)
        
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "우히히"
        
        mapView.addAnnotation(annotation)
    }
}
