//
//  UICollectionView.swift
//  Calendar
//
//  Created by Username on 31.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView{

    func baseSettingsCV(obj: UICollectionViewDelegateFlowLayout & UICollectionViewDataSource,
                        scrollEnabled: Bool = true,
                        clicableCell: Bool = true,
                        arrayNameCell: [String]?,
                        arrayNameHeders: [String]? = nil){

        self.delegate = obj
        self.dataSource = obj
        self.backgroundColor = UIColor.clear
        self.isScrollEnabled = scrollEnabled

        //  скорость с которой движУТся ячейки
        //  collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

//        self.allowsSelection = clicableCell
        
//        if clicableCell {
//            self.conisUserInteractionEnabled = true
//        }

        arrayNameCell?.forEach({ (cellName) in
            self.register(UINib(nibName: cellName, bundle: nil),
                                forCellWithReuseIdentifier: cellName)
        })

        arrayNameHeders?.forEach({ (header) in
            self.register(UINib(nibName: header, bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: header);
        })




    }


}


//func setCollectionViewDataSourceDelegate<D: UICollectionViewDelegateFlowLayout & UICollectionViewDataSource>(_ dataSourceDelegate: D, forRow row: Int) {
//
//    collectionView.register(UINib(nibName: CollectionCellDataVC.className, bundle: nil),
//                            forCellWithReuseIdentifier: CollectionCellDataVC.className)
//
//    collectionView.delegate = dataSourceDelegate
//    collectionView.dataSource = dataSourceDelegate
//    collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
//    collectionView.tag = row
//    collectionView.backgroundColor = UIColor.clear
//    collectionView.setContentOffset(collectionView.contentOffset, animated: false)
//    collectionView.isScrollEnabled = dataArray.count > 1
//
//    collectionView.allowsSelection = false
//    collectionView.reloadData()
