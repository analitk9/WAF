//
//  FavouriteStorage.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import Foundation
import UIKit

struct FavoriteStorage {
    
   private func getDocumentsDirectory() -> URL {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {fatalError()}
        return dir
    }
    
    func saveData(_ data: StorageModel){
        let jsonEncoder = JSONEncoder()
        if let data = try?  jsonEncoder.encode(data) {
           try? data.write(to: getDocumentsDirectory().appendingPathComponent("favorites"))
        }else {
            print("problem with save data")
        }
    }
    
    func loadData()->StorageModel? {
        guard let data = try? Data(contentsOf: getDocumentsDirectory().appendingPathComponent("favorites")) else {return nil}
         do
             {
                  let data = try JSONDecoder().decode(StorageModel.self, from: data)
                 return data
             }
         catch {
             print("problem with load data")
        }
        return nil
    }
    
    func saveImage(_ image: UIImage, with id: String?){
        guard let id = id else {
            return
        }

        let imagePath = getDocumentsDirectory().appendingPathComponent(id)
        try! image.jpegData(compressionQuality: 0.7)?.write(to: imagePath)
    }
    
    func loadImage(with id: String)-> UIImage? {
        UIImage(contentsOfFile: getDocumentsDirectory().appendingPathComponent(id).path)
    }
    
    func deleteImage(with id: String)-> Bool {
        do {
            try FileManager.default.removeItem(at:  getDocumentsDirectory().appendingPathComponent(id))
            return true
        } catch let error as NSError {
            print("Error: \(error.domain)")
        }
        return false
    }
    
}
