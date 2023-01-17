//
//  IAPManger.swift
//  ConsumableIAPs
//
//  Created by 侯懿玲 on 2023/1/17.
//

import Foundation
import StoreKit

final class IAPManger: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    static let shared = IAPManger()
    
    var products = [SKProduct]()
    
    private var completion: ((Int) -> Void)?
    
    enum Product: String, CaseIterable {
        case coin_50
        case coin_100
        case coin_500
        case coin_1000
        
        var count: Int {
            switch self {
            case .coin_50:
                return 50
            case .coin_100:
                return 100
            case .coin_500:
                return 500
            case .coin_1000:
                return 1000
            }
        }
    }
    
    
    public func fetchProducts() {
        let request = SKProductsRequest(
            productIdentifiers: Set(Product.allCases.compactMap({ $0.rawValue}))
        )
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("內購產品總數： ", response.products.count)
        self.products = response.products
    }
    
    public func purchase(product: Product, completion: @escaping ((Int)-> Void)) {
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        
        guard let storeKitProduct = products.first(where: { $0.productIdentifier == product.rawValue }) else {
            return
        }
        self.completion = completion
        
        let paymentRequest = SKPayment(product: storeKitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    // 更新交易
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach ({
            switch $0.transactionState {
            case .purchasing:
                break
            case .purchased:
                if let product = Product(rawValue: $0.payment.productIdentifier) {
                    completion?(product.count)
                }
                SKPaymentQueue.default().finishTransaction($0)
                SKPaymentQueue.default().remove(self)
            case .failed:
                break
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        })
    }
}
