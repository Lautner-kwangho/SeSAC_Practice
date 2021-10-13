import UIKit

struct ExchangeRate {

// 정리 : 연산 프로퍼티는 저장이 아니라 그냥 연산만 함!!
// 그냥 전부다 노가다?로 했을 떄
//    var exchangeKRWResult: Double {
//        get {
//            return KRW / currencyRate
//        }
//        set {
//            currencyRate = newValue
//            KRW = newValue
//            USD = newValue
//        }
//    }
//    var exchangeUSDResult: Double {
//        get {
//            return USD * currencyRate
//        }
//        set {
//            currencyRate = newValue
//            KRW = newValue
//            USD = newValue
//        }
//    }

    // 맞는 건가..?
    var ex: (Double, Double) {
        get {
            let exchangeUSD = KRW / currencyRate
            let exchangeKRW = USD * currencyRate
            return (exchangeUSD,exchangeKRW)
            }
        set (Double) {
            currencyRate = (Double.0)
            KRW = (Double.0)
            USD = (Double.0)
        }
    }
    
    var currencyRate: Double {
        willSet {
            print(#function, "willSet - 환율 변동 예정: \(currencyRate) -> \(newValue)")
        }
        didSet {
            print(#function, "didSet - 환율 변동 완료: \(oldValue) -> \(currencyRate)")
        }
    }
    
    var USD: Double {
        willSet {
            print("KRW willSet - 환전 금액 : \(newValue * currencyRate)원으로 환전될 예정")
        }
        didSet {
            print("KRW willSet - KRW: \(USD) -> \(ex.1)달러로 환전되었음")
        }
    }
    
    var KRW: Double {
        willSet {
            print("USD willSet - 환전 금액 : \(newValue / currencyRate)달러로 환전될 예정")
        }
        didSet {
            print("USD didSet - KRW: \(KRW) -> \(ex.0)달러로 환전되었음")
        }
    }
}

var rate = ExchangeRate(currencyRate: 1100, USD: 1, KRW: 1000)
rate.KRW = 500000
rate.currencyRate = 1350
rate.KRW = 500000
rate.USD = 1000
