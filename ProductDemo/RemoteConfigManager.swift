//
//  RemoteConfigManager.swift
//  ProductDemo
//
//  Created by sanaz on 11/5/25.
//

import FirebaseRemoteConfig
import SwiftUI
import Combine

@MainActor
final class RemoteConfigManager: ObservableObject {
    @Published var appMode: String = "product"
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    init() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // for debug
        remoteConfig.configSettings = settings
        fetchConfig()
    }
    
    func fetchConfig() {
        Task { @MainActor in
            do {
                let _ = try await remoteConfig.fetchAndActivate()
                let mode = remoteConfig["app_mode"].stringValue
                self.appMode = mode
                print("RemoteConfig appMode =", mode)
            } catch {
                print("RemoteConfig fetch error:", error)
            }
        }
    }
}

