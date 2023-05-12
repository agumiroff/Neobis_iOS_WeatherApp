//
//  StorageManagerImpl.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 12.05.2023.
//

import Foundation
import CoreData

class StorageManagerImpl: StorageManager {
    
    func saveData(model: WeatherModelAPI) {
        let managedContext = AppDelegate.sharedAppDelegate.weatherCoreData.managedContext
        let weatherData = WeatherModelCD(context: managedContext)
        
        weatherData.setValue(model.list, forKey: #keyPath(WeatherModelCD.list))
        
        AppDelegate.sharedAppDelegate.weatherCoreData.saveContext()
    }
    
    func getData(completion: @escaping(WeatherModelCD?, Error?) -> Void) {
        let fetchData: NSFetchRequest<WeatherModelCD> = WeatherModelCD.fetchRequest()
        
        do {
            let managedContext = AppDelegate.sharedAppDelegate.weatherCoreData.managedContext
            let results = try managedContext.fetch(fetchData)
            completion(results.last, nil)
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            completion(nil, error)
        }
    }
}
