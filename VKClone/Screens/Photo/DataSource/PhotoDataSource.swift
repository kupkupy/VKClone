//
//  PhotoTableViewDataSource.swift
//  vk-tanya
//
//  Created by Tanya on 14.07.2022.
//

import Foundation
import UIKit

class PhotoCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    let photoAPI = PhotoAPI()
    
    var dataSource: [Photo] = []
    var photosURL: [String] = []
    
    var isLoading = false
    
    func updatePhotos(_ photos: [Photo]) {
        self.dataSource = photos
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.identifier, for: indexPath) as? PhotosCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let photo = dataSource[indexPath.row]
        
        for item in photo.sizes {
            photosURL.append(item.url)
        }
       
        for url in photosURL {
            cell.configurePhoto(photoURL: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            
            if indexPath.row >= self.dataSource.count - 5 {
                
                if !isLoading {
                    isLoading = true
                    
                    photoAPI.getPhoto(offset: dataSource.count) { [weak self] result in
                        guard let self = self else { return }
                        
                        switch result {
                        case .success(let photos):
                            self.dataSource.append(contentsOf: photos)
                            collectionView.reloadData()
                        case .failure(let error):
                            print("Error", error)
                        }
                        
                        self.isLoading = false
                    }
                }
            }
        }
    }
}
