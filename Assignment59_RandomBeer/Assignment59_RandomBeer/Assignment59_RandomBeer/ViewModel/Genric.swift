//
//  Genric.swift
//  Assignment59_RandomBeer
//
//  Created by 최광호 on 2021/12/29.
//

import Foundation

class Genric<T> {
    var value: T {
        didSet {
            valueData?(value)
        }
    }
    // 외부 내부 매개변수 선언하는 게 깔끔해 보임
    init(_ value: T) {
        self.value = value
    }
    
    var valueData: ((T) -> Void)?
    
    func sendValue(_ closure: @escaping (T) -> Void) {
        closure(value)
        valueData = closure
    }
    
}
