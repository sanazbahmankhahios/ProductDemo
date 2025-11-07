//
//  ProductListViewModel.swift
//  ProductModule
//
//  Created by sanaz on 11/5/25.
//

import Foundation
import Combine
import ProductKit

@MainActor
public class ProductViewModel: ObservableObject {
    @Published public var products: [Product] = []
    @Published public var filteredProducts: [Product] = []
    @Published public var searchText: String = ""
    @Published public var loading: Bool = false
    @Published public var isRequestFailed: Bool = false
    
    private var cancellable = Set<AnyCancellable>()
    private var currentPage: Int = 0
    private var limit: Int = 20
    private var totalItems: Int = 0
    
    let domain: ProductDomain
    let cache: CacheLayer
    
    public init(domain: ProductDomain, cache: CacheLayer) {
        self.domain = domain
        self.cache = cache
        setupSearch()
        getProducts()
    }
 
    private func getProductsIfNeeded() {
        guard products.isEmpty else { return }
        getProducts()
    }
    
    public var shouldShowLoading: Bool {
        products.count < totalItems
    }
    
    public func getProducts() {
        guard !loading else { return }
        loading = true
        isRequestFailed = false
        
        fetchProducts()
    }
    
    private func fetchProducts() {
        let request = ProductRequest(limit: limit, skip: currentPage)
        domain.products(request: request)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.handleCompletion(completion)
            } receiveValue: { [weak self] response in
                self?.handleResponse(response)
            }
            .store(in: &cancellable)
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        loading = false
        if case .failure = completion {
            isRequestFailed = true
        }
    }
    
    private func handleResponse(_ response: ProductsPagination) {
        let uniqueProducts = response.products.filter { newProduct in
            !products.contains(where: { $0.id == newProduct.id })
        }
        products.append(contentsOf: uniqueProducts)
        
        totalItems = response.total
        if products.count < totalItems {
            currentPage += limit
        }
        
        domain.searchProduct(key: searchText)
            .replaceError(with: [])
            .sink {[weak self] in
                self?.filteredProducts = $0
            }.store(in: &cancellable)
        
        cache.save(value: products)
    }
    
    public func getMoreProducts() {
        guard !loading else { return }
        guard let lastItem = products.last else { return }
        guard shouldLoadNextPage(after: lastItem) else { return }
        
        getProducts()
    }
    
    private func shouldLoadNextPage(after item: Product) -> Bool {
        guard
            let index = products.firstIndex(where: { $0.id == item.id }),
            index == products.count - 1,
            products.count < totalItems
        else {
            return false
        }
        return true
    }
    
    private func setupSearch() {
        //Note: Debounce is not for local search but added to demonstrate Combine operation usage as required by the challenge.
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .flatMap { text -> AnyPublisher<[Product], Never> in
                self.domain.searchProduct(key: text)
                    .replaceError(with: []) // ensures output type is `[Product]`, not `[Product], Error`
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$filteredProducts)
    }
    
}
