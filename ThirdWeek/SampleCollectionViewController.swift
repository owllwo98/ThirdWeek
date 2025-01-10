//
//  SampleCollectionViewController.swift
//  ThirdWeek
//
//  Created by 변정훈 on 1/9/25.
//

import UIKit

class SampleCollectionViewController: UIViewController {
    @IBOutlet var bannerCollectionView: UICollectionView!
    @IBOutlet var listCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    // 전체 데이터
    var totalList: [Int] = Array<Int>(1...100)
    
    // 필터링된 데이터
    lazy var list: [Int] = totalList
    /*
     var list: [Int] = totalList -> 이거 왜 안됨?
     인스턴스 프로퍼티는 동시에 초기화된다.
     따라서 속도를 조절해주어야 하니까
     lazy var list: [Int] = totalList 와 같이 lazy 를 써준다.
     */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
//        searchBar.showsCancelButton = true

        configureCollectionView()
        configureCollectionViewLayout()
        configureListCollectionViewLayout()
        
        // DispatchQueue.main.async
//        print("1")
//        DispatchQueue.main.async {
//            print("2")
//        }
//        
//        print("3")
//        print("4")
        
        print(listCollectionView.frame.height)
        print(listCollectionView.frame.width)
    }
    
    func configureCollectionView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        let xib = UINib(nibName: SampleCollectionViewCell.identifier, bundle: nil)
        bannerCollectionView.register(xib, forCellWithReuseIdentifier: SampleCollectionViewCell.identifier)
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        
        listCollectionView.register(xib, forCellWithReuseIdentifier: SampleCollectionViewCell.identifier)
    }
    
   
    func configureCollectionViewLayout() {
       
        // cell 을 페이지처럼 해줌
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.collectionViewLayout = SampleCollectionViewController.CollectionViewLayout()
        listCollectionView.isPagingEnabled = true
    }
    
    func configureListCollectionViewLayout() {
        
        // 만약 너비가 ? 인 디바이스에서 3개의 cell 의 너비를 동일하게 만드려면?
        // ? - sectionInset * 2 - spacing * 2 / 3
        // ex) cell 3개 동일하게 그리기
        
        let sectionInset: CGFloat = 16
        let cellSpacing: CGFloat = 16
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        
        let deviceWidth = UIScreen.main.bounds.width
//        let listCollectionViewHeight = listCollectionView.frame.height
        let cellWidth = deviceWidth - (sectionInset * 2) - (cellSpacing * 2)
        
        
        layout.itemSize = CGSize(width: cellWidth / 3 , height: cellWidth / 3)
        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
       
        
        listCollectionView.collectionViewLayout = layout
    }
}

extension SampleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCollectionViewCell.identifier, for: indexPath) as! SampleCollectionViewCell
        
        cell.backgroundColor = .brown
        cell.titleLabel.text = "\(list[indexPath.item])"
        cell.image.backgroundColor = .white
        
        // 이게 실행되는 시점에서는 이상하게 그려진다
        // View Drawing Cycle
//        cell.image.layer.cornerRadius = cell.image.frame.width / 2
        
        // 대체 왜?
        // GCD
        // 가장 마지막에 실행
        DispatchQueue.main.async {
            cell.image.layer.cornerRadius = cell.image.frame.width / 2
        }
        
        return cell
    }
}

extension SampleCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        print(#function)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.showsCancelButton = false
    }
    
    // 검색하려고할때 화면전환하는 경우도 있다.
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
//        searchBar.showsCancelButton = true
        
        // 조금 더 자연스러운 등장
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var result: [Int] = []
        
        if searchText == "" {
            // 전체 데이터 가져와
            // 근데 데이터가 무지막지하게 커지면?
            result = totalList
        } else {
            for item in list {
                if item == Int(searchText)! {
                    result.append(item)
                }
            }
        }

        list = result
        listCollectionView.reloadData()
    }
    
}


