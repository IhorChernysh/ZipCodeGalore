//
//  HomeViewModel.swift
//  ZipCodeGalore
//
//  Created by Ihor Chernysh on 11.05.2022.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didSelectPlace(_ place: PlaceInfo)
    func newInfoLoaded(_ place: PlaceInfo)
}

class HomeViewModel {
 
    weak var delegate: HomeViewModelDelegate?
    
    private var infoDataSource: [PlaceInfo] = []
    
    // MARK: - Methods
    
    func numberOfRows() -> Int {
        return infoDataSource.count
    }
    
    func itemByIndexPath(_ indexPath: IndexPath) -> PlaceInfo {
        let info = infoDataSource[indexPath.row]
        return info
    }
    
    func didSelectByIndexPath(_ indexPath: IndexPath) {
        let item = itemByIndexPath(indexPath)
        delegate?.didSelectPlace(item)
    }
    
    func fetchInfoByCode(enteredCode: String, completion: @escaping ((PlaceInfo?, String?) -> ())) {
        // 'selectedCountry' - for future implementation if needed from customer
        ZipCodeNetworkService().fetchInfoByZipCode(code: enteredCode, selectedCountry: "us") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let placeInfo):
                    completion(placeInfo, nil)
                case .failure(let error):
                    let errorDescription = self.handleErrorAndGetDescription(error)
                    completion(nil, errorDescription)
                }
            }
        }
    }
    
    func successfullyLoadedInfo(placeInfo: PlaceInfo?) {
        guard let placeInfo = placeInfo else {
            return
        }
        self.infoDataSource.append(placeInfo)

        delegate?.newInfoLoaded(placeInfo)
    }
    
    func findLastItemIndexPath() -> IndexPath {
        let allItemsAmount = self.infoDataSource.count
        let indexPath = IndexPath(item: allItemsAmount - 1, section: 0)
        
        return indexPath
    }
    
    private func handleErrorAndGetDescription(_ error: Error) -> String {
        if let err = error as? APIError {
            return err.descriptionForError
        }
        
        return error.localizedDescription
    }
}
