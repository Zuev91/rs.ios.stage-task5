import Foundation

class StockMaximize {
    
    func countProfit (prices: [Int]) -> Int {
        
        var array = prices
        var max = array.max()
        var result = 0

        if array.isEmpty {
            return result
        }
        
        while array.count != 0 {
            if ( array.first == max ) {
                array.removeFirst()
                max = array.max()
                }
            else {
                result += max! - array.first!
                array.removeFirst()
            }
        }
        
        return result
        
    }
        
}
