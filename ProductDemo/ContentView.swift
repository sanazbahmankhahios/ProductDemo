//
//  ContentView.swift
//  ProductDemo
//
//  Created by sanaz on 11/4/25.
//

/*import SwiftUI


struct ContentView: View {
    @StateObject private var remoteConfig = RemoteConfigManager()

    var body: some View {
        Group {
            switch remoteConfig.appMode {
            case "form":
                ValidatedFormView()
            default:
                ProductList()
            }
        }
        .animation(.easeInOut, value: remoteConfig.appMode)
            .onAppear {
                remoteConfig.fetchConfig()

        }
    }
}*/

import SwiftUI
import FormModule

struct ContentView: View {
    @StateObject private var remoteConfig = RemoteConfigManager()

    var body: some View {
        NavigationStack {
            Group {
                switch remoteConfig.appMode {
                case "form":
                    ValidatedFormView()
                default:
                    ProductList()
                }
            }
            .animation(.easeInOut, value: remoteConfig.appMode)
            .toolbar {
                Button("Refresh RC") {
                    remoteConfig.fetchConfig() // now works immediately
                }
            }
        }
    }
}



