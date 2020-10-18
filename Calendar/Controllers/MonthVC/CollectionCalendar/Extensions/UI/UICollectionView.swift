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

        self.allowsSelection = clicableCell
        
        arrayNameCell?.forEach({ (cellName) in
            self.registerCell(cellName: cellName)
        })

        arrayNameHeders?.forEach({ (header) in
            self.registerHeader(headerName: header)
        })
    }

    func registerCell(cellName: String){
        self.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }

    func registerHeader(headerName: String){
        self.register(UINib(nibName: headerName, bundle: nil),
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: headerName);
    }


}

