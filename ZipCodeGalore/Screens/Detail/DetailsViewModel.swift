//
//  DetailsViewModel.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 12.05.2022.
//

import Foundation

class DetailsViewModel {
        
    private(set) var selectedInfo: PlaceInfo?
    
    init(placeInfo: PlaceInfo?) {
        self.selectedInfo = placeInfo
    }
    
    // MARK: - Methods
    
    func numberOfRows() -> Int {
        return selectedInfo?.places.count ?? 0
    }
    
    func itemByIndexPath(_ indexPath: IndexPath) -> Places? {
        let placeToSet = selectedInfo?.places[indexPath.row]
        return placeToSet
    }
}
