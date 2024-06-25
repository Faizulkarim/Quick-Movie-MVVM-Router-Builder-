//
//  DisposeBag.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation
import Combine

final class DisposeBag {
    fileprivate(set) var subscriptions = Set<AnyCancellable>()
    
    func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    
    func store(in disposeBag: DisposeBag) {
        disposeBag.subscriptions.insert(self)
    }
}
