//
//  Observable.swift
//  Assignment67_MemberLogin
//
//  Created by 최광호 on 2022/01/03.
//

import Foundation

class Observable<T> {
    
    var valueData: T {
        didSet {
            receive?(valueData)
        }
    }
    
    init(_ valueData: T) {
        self.valueData = valueData
    }
    
    private var receive: ((T) -> Void)?
    
    func receiveData(_ closure: @escaping (T) -> Void) {
        closure(valueData)
        receive = closure
    }
    
}
