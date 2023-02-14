//
//  IAPManager.swift
//  TekPass Card
//
//  Created by 侯懿玲 on 2023/2/3.
//

import Foundation
import StoreKit

public var isProgress: Bool = false           // 是否有交易正在進行中
public typealias ProductID = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> Void
public typealias ProductPurchaseCompletionHandler = (_ success: Bool, _ productId: ProductID?) -> Void

// MARK: - IAPManager
public class IAPManager: NSObject {
    private let productIDs: Set<ProductID>
    private var purchasedProductIDs: Set<ProductID>
    private var productsRequest: SKProductsRequest? // 來執行對 Apple 服務器的請求
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    private var productPurchaseCompletionHandler: ProductPurchaseCompletionHandler?
    
    
    public init(productIDs: Set<ProductID>) {
        self.productIDs = productIDs
        
        self.purchasedProductIDs = productIDs.filter { productID in
            let purchased = UserDefaults.standard.bool(forKey: productID)
            if purchased {
                print("Previously purchased 先前購買: \(productID)")
            } else {
                print("Not purchased 未購買: \(productID)")
            }
            return purchased
        }
        super.init()
        SKPaymentQueue.default().add(self)
    }
}

// MARK: - StoreKit API
extension IAPManager {
    
    public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
        let identifiers = Set(productIDs)
        
        productsRequest?.cancel()
        productsRequestCompletionHandler = completionHandler
        
        productsRequest = SKProductsRequest(productIdentifiers: identifiers)
        productsRequest!.delegate = self
        productsRequest!.start()
    }
    
    public func buyProduct(_ product: SKProduct, _ completionHandler: @escaping ProductPurchaseCompletionHandler) {
        productPurchaseCompletionHandler = completionHandler
        
        let priceLocale = product.introductoryPrice?.priceLocale.description
        let paymentMode = product.introductoryPrice?.paymentMode.rawValue
        let subscriptionPeriod = product.introductoryPrice?.subscriptionPeriod.numberOfUnits
        let numberOfPeriods = product.introductoryPrice?.numberOfPeriods
        print(" priceLocale: ",priceLocale,"\n paymentMode: ", paymentMode, "\n subscriptionPeriod:", subscriptionPeriod, "\n numberOfPeriods: ", numberOfPeriods)
        
        print("Buying \(product.productIdentifier)...")
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    public func isProductPurchased(_ productID: ProductID) -> Bool {
        return purchasedProductIDs.contains(productID)
    }
    
    public class func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    /// 回覆購買
    public func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

// MARK: - SKProductsRequestDelegate
extension IAPManager: SKProductsRequestDelegate, ObservableObject {
        
    // fetchProducts
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("產品總數： ", response.products.count)
        print("Loaded list of products...")
        let products = response.products
        guard !products.isEmpty else {
            print("Product list is empty...!")
            print("Did you configure the project and set up the IAP?")
            productsRequestCompletionHandler?(false, nil)
            return
        }
        productsRequestCompletionHandler?(true, products)
        clearRequestAndHandler()
        for p in products {
            print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
        }
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load list of products.")
        print("Error: \(error.localizedDescription)")
        productsRequestCompletionHandler?(false, nil)
        clearRequestAndHandler()
    }
    
    private func clearRequestAndHandler() {
        productsRequest = nil
        productsRequestCompletionHandler = nil
    }
}

// MARK: - SKPaymentTransactionObserver
extension IAPManager: SKPaymentTransactionObserver {
    
    // 購買、復原成功與否的 protocol
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                complete(transaction: transaction)
                break
            case .failed:
                fail(transaction: transaction)
                break
            case .restored:
                restore(transaction: transaction)
                break
            case .deferred:
                break
            case .purchasing:
                break
            @unknown default:
                break
            }
        }
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        print("complete...")
        
        productPurchaseCompleted(identifier: transaction.payment.productIdentifier)
        
        // 必要的機制
        SKPaymentQueue.default().finishTransaction(transaction)
        isProgress = false
        
        // 移除觀查者
        SKPaymentQueue.default().remove(self)
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        print("fail...")
        print("asdfghjkl/: ",transaction.payment.productIdentifier, transaction.transactionState.rawValue)
        if let error = transaction.error as? SKError {
            switch error.code {
            case .clientInvalid:        // client is not allowed to issue the request
                print("Transaction clientInvalid: \(error.localizedDescription)")
                
            case .paymentCancelled:     // user cancelled the request
                // 輸入 Apple ID 密碼時取消
                print("Transaction Cancelled: \(error.localizedDescription)")
                
            case .paymentInvalid:       // purchase identifier was invalid
                print("Transaction paymentInvalid: \(error.localizedDescription)")
                
            case .paymentNotAllowed:    // this device is not allowed to make the payment
                print("Transaction paymentNotAllowed: \(error.localizedDescription)")
                
            default:
                print("Transaction: \(error.localizedDescription)")
            }
        }
        
        productPurchaseCompletionHandler?(false, nil)
        SKPaymentQueue.default().finishTransaction(transaction)
        isProgress = false
        clearHandler()
    }
    
    private func restore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        print("restore... \(productIdentifier)")
        productPurchaseCompleted(identifier: productIdentifier)
        // 必要的機制
        SKPaymentQueue.default().finishTransaction(transaction)
        isProgress = false
    }
    
    // 復原購買失敗
    public func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("復原購買失敗...\(error.localizedDescription)")
        
        if #available(iOS 15.0, *) {
            if let navigationController = UIApplication.shared
                .connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow })?.rootViewController as? UINavigationController {
                let alertController = UIAlertController(title: "復原購買失敗",
                                                        message: "\(error.localizedDescription)",
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                navigationController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    // 回復購買成功(若沒實作該 delegate 會有問題產生)
    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("復原購買成功...")
        
        if #available(iOS 15.0, *) {
            if let navigationController = UIApplication.shared
                .connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow })?.rootViewController as? UINavigationController {
                let alertController = UIAlertController(title: "復原購買成功",
                                                        message: "",
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                navigationController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func productPurchaseCompleted(identifier: ProductID?) {
        guard let identifier = identifier else { return }
        purchasedProductIDs.insert(identifier)
        UserDefaults.standard.set(true, forKey: identifier)
        productPurchaseCompletionHandler?(true, identifier)
        clearHandler()
    }
    
    private func clearHandler() {
        productPurchaseCompletionHandler = nil
    }
}

