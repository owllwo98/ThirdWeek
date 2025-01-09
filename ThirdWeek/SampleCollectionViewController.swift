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
    

    var list: [Int] = Array<Int>(1...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureCollectionViewLayout()
        configureListCollectionViewLayout()
        
        // DispatchQueue.main.async
        print("1")
        DispatchQueue.main.async {
            print("2")
        }
        
        print("3")
        print("4")
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
        let cellWidth = deviceWidth - (sectionInset * 2) - (cellSpacing * 2)
        
        layout.itemSize = CGSize(width: cellWidth / 3, height: cellWidth / 3 * 1.2)
        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        
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
        cell.titleLabel.text = "\(indexPath.item)"
        cell.image.backgroundColor = .white
        
        // 이게 실행되는 시점에서는 이상하게 그려진다
        // View Drawing Cycle
//        cell.image.layer.cornerRadius = cell.image.frame.width / 2
        
        // 대체 왜?
        // GCD
        // 가장 마지막에 실행
        DispatchQueue.main.async {
            cell.image.layer.cornerRadius = cell.image.frame.width / 2
            print("5")
        }
        
        return cell
    }
}

extension SampleCollectionViewController: UISearchBarDelegate {
    
}


