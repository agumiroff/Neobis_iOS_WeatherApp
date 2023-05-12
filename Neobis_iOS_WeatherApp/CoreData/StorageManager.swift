//
//  StorageManager.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 12.05.2023.
//

import Foundation

protocol StorageManager {
    func saveData(model: WeatherModelAPI)
    func getData(completion: @escaping(WeatherModelCD?, Error?) -> Void)
}
