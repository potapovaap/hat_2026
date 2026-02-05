//
//  IAPManager.swift
//  testUIKit2
//
//  Created by Alisa Potapova on 25.08.2025.
//


import UIKit
import StoreKit

protocol IAPManagerDelegate: AnyObject {
    func restoreSections()
    func purchaseSection()
    func trySectionForFree()
}

extension downloadVC : SKProductsRequestDelegate, SKPaymentTransactionObserver {

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach {
            switch $0.transactionState {
            case .purchasing:
                break
            case .purchased:
                onPurchased(productIdentifier: $0.payment.productIdentifier)
                //покупка совершена успешно - finishTransaction - и открываем контент
                SKPaymentQueue.default().finishTransaction($0)
                break
            case .failed:
                onFailed()
                SKPaymentQueue.default().finishTransaction($0)
                break
            case .restored:
                //сообщение покупки восстановлны - и восстановить все
                SKPaymentQueue.default().finishTransaction($0)
                break
            case .deferred:
               break
            @unknown default:
                break
            }
        }
    }
    
    func onPurchased(productIdentifier: String) {
        if let purchasedId = productIds.firstIndex(of: productIdentifier) {
            purchased.append(productIds[purchasedId])
            UserDefaults.standard.set(purchased, forKey: "purchasedIds")
            UserDefaults.standard.set(productIds[purchasedId], forKey: "purchasedId")
            paymentFinished()
        } else {
            raiseStoreError()
        }
    }
    
    func onFailed() {
        raiseStoreError()
    }
    
    func onRestored(productIdentifier : String) {
        if let restoredIndex = productIds.firstIndex(of: productIdentifier) {
            restored.append(productIds[restoredIndex])
            UserDefaults.standard.set(restored, forKey: "restoredIds")
        } else {
            raiseStoreError()
        }
    }
    
    func fetchProducts() {
        let productIdentifiers = Set(productIds)
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.skProducts = response.products
        }
    }
    
    func purchaseSection() {
        
    }
    
    func restorePurchase() {
        SKPaymentQueue.default().add(self)
        if (SKPaymentQueue.canMakePayments()) {
            SKPaymentQueue.default().restoreCompletedTransactions()
        } else {
            raiseStoreError()
        }
    }
    
    func addPayment(productId: String) {
        SKPaymentQueue.default().add(self)
        guard let currentProduct = skProducts.first(where: {$0.productIdentifier == productId}) else {
            raiseStoreError()
            return
        }
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: currentProduct)
            SKPaymentQueue.default().add(payment)
        }
        else {
            raiseStoreError()
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        restored.removeAll()
        for transaction in queue.transactions {
            let prodID = transaction.payment.productIdentifier as String
            restored.append(prodID)
        }
        UserDefaults.standard.set(restored, forKey: "restoredIds")
        restorePurchaseFinished()
    }

    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        raiseStoreError()
    }
    
    func restorePurchaseFinished() {
        waitingView.isHidden = true
        waitingLabel.isHidden = true
        self.dismiss(animated: true, completion: nil)
        iapDelegate?.restoreSections()
    }
    
    func paymentFinished() {
        waitingView.isHidden = true
        waitingLabel.isHidden = true
        self.dismiss(animated: true, completion: nil)
        iapDelegate?.purchaseSection()
        
    }
    
    func raiseStoreError() {
        waitingView.isHidden = true
        waitingLabel.isHidden = true
        showAlertOk(title: errorTitle, message: errorMessage)
    }
    

    


}
