//
//  ProductDemoApp.swift
//  ProductDemo
//
//  Created by sanaz on 11/4/25.
//

import SwiftUI
import Firebase
import ProductListModule
import ProductKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ProductDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

final class AppDIContainer: DIContainer {
    
    static let shared = AppDIContainer()
    
    lazy var cache: CacheLayer = {
        DefaultCacheManager(filename: "product.dat")
    }()
    
    lazy var domain: ProductDomain = {
        
        let domain = DefaultProductDomain(cache: cache)
        return domain
    }()
    
    func makeDomain() -> any ProductDomain {
        domain
    }
    
    func makeCache() -> any CacheLayer {
        cache
    }

}
