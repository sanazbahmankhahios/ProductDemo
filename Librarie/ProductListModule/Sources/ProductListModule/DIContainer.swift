//
//  DIContainer.swift
//  ProductListModule
//
//  Created by sanaz on 11/7/25.
//

import SwiftUI
import ProductKit

public protocol DIContainer: AnyObject {
    
    func makeDomain() -> ProductDomain
    func makeCache() -> CacheLayer
    
    init()
}
