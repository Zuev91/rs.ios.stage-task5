import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        let result1 = findMaxKilometres(array: foods, target: maxWeight)
        let result4 = findMaxKilometres(array: drinks, target: maxWeight)
        var result2: [(Int,Int)] = []
        var result3: [(Int)] = []
        
        var i = 0
        var bufferWeight = 0
        var bufferSumValues = 0
        
        while(i < result1.count) {
            for j in stride(from: i, to: result4.count, by: 1) {
                bufferWeight = result1[i].1
                bufferSumValues = 0
                if result4[j].1 < bufferWeight {
                    bufferWeight -= result4[j].1
                    bufferSumValues += result4[j].0
                    if (j == result4.count) {
                        result2.append((bufferSumValues, bufferWeight))
                        bufferWeight = result1[i].1
                        bufferSumValues = 0
                    }
                } else {
                    result2.append((bufferSumValues, bufferWeight))
                    continue
                }
            }
            result2.append((bufferSumValues, bufferWeight))
            i += 1
        }
        
        
        for i in stride(from: 0, to: result1.count, by: 1) {
            result3.append(min(result1[i].0, result2[i].0))
        }
        
        return result3.max()!
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres(array: [Supply], target: Int) -> [(Int, Int)] {
        var tmp: [Int] = []

        for i in array {
            tmp.append(i.weight)
        }
        
        var resultArray: [(Int, Int)] = []
        let count = tmp.count
        var bufferWeight = target
        var bufferSumValues = 0
        var i = 0
        
        while(i < count) {
            for j in stride(from: i, to: count, by: 1) {
                bufferWeight = target
                bufferSumValues = 0
                if tmp[j] < bufferWeight {
                    bufferWeight -= tmp[j]
                    bufferSumValues += array[j].value
                    if (j == count) {
                        resultArray.append((bufferSumValues, bufferWeight))
                        bufferWeight = target
                        bufferSumValues = 0
                    }
                } else {
                    resultArray.append((bufferSumValues, bufferWeight))
                    continue
                }
            }
            resultArray.append((bufferSumValues, bufferWeight))
            i += 1
        }
        
        return resultArray
    }
}
