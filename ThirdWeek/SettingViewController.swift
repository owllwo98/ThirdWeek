//
//  SettingViewController.swift
//  ThirdWeek
//
//  Created by 변정훈 on 1/10/25.
//

import UIKit


// 멤버와 값의 분리
// 이건 한 공간만 씀 -> 열거형 - 인스턴스 생성 X
// CaseIterable -> Case 를 배열로 표현해줄 수 있음
enum SettingOptions: Int, CaseIterable{
    case total
    case personal
    case others
    
    var mainOption: String {
        
        switch self {
        case .total:
            return "전체설정"
        case .personal:
            return "개인설정"
        case .others:
            return "기타"
        }
    }
    
    var subOption: [String] {
        switch self {
        case .total:
            return ["공지사항","실험실","버전정보"]
        case .personal:
            return ["개인/보안","알림","채팅"]
        case .others:
            return ["고객센터/도움말"]
        }
    }
    
}

// 1. 그럼 왜 이거 안써? -> 클래스/구조체 - 인스턴스 생성 O

// 2. 잠깐.. 근데 인스턴스 생성만 안하면 써도 되는거 아님? -> 맞다
// -> private init() {} 를 사용해서 인스턴스 생성을 막으면 된다.

// 3. 그럼에도 어떨 때 열거형을 굳이 쓸건가?
// -> 갖고있는 데이터가 고유성, 유일성 이 있을때

// 근데 밑에 처럼 변경 가능성이 있는데 일단은 같은 값을 쓸때
// 열거형을 쓰면 같은 이름으로 사용불가
struct Setting {
    static let others = "기타"
    static let total = "기타"
    static let personal = "개인 설정"
    
    private init () {}
}

class SettingViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    // 리터럴한 문자열을 숨긴다.
    let scectionList : [SettingOptions] = SettingOptions.allCases
    
    let rowList1 = ["공지사항","실험실","버전정보"]
    let rowList2 = ["개인/보안","알림","채팅"]
    let rowList3 = ["고객센터/도움말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        print(SettingOptions.others.mainOption)
        print(SettingOptions.allCases[0].subOption[2])
        
        
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].mainOption
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOptions.allCases[section].subOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].subOption[indexPath.row]
        
        return cell
    }
    
    
}
