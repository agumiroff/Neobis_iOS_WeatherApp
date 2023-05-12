//
//  AppDelegate.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var flowFactory: FlowFactory!
    private var networkService: NetworkService!
    private var storageManager: StorageManager!
    lazy var weatherCoreData: WeatherCoreData = .init(modelName: "Weather")
    
    static let sharedAppDelegate: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate
        else { fatalError("Unexpected app delegate type, did it change? \(String(describing: UIApplication.shared.delegate))") }
        return delegate
    }()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            
            flowFactory = FlowFactoryImplementation()
            networkService = NetworkServiceImpl()
            storageManager = StorageManagerImpl()
            
            DIContainer.standart.register(flowFactory!)
            DIContainer.standart.register(networkService!)
            DIContainer.standart.register(storageManager!)
            
            return true
    }

    // MARK: UISceneSession Lifecycle
    
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func applicationWillResignActive(_ application: UIApplication) { // didEnterBackground?
        AppDelegate.sharedAppDelegate.weatherCoreData.saveContext()
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}
