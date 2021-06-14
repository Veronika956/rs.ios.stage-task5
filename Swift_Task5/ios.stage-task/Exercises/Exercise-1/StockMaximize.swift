import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        if (prices.isEmpty || prices == [0]) { return 0}
        
        let last = prices.last!
        var result = 0
        var dif = 0
        for (index, price) in prices.enumerated(){
            if (price >= last) {
                dif = last - price
                if dif >= 0 { result += dif} else { result += 0 }
            }else {
                if prices[index + 1] > last {
                    dif = prices[index + 1] - price
                    result += dif
                } else {
                    dif = last - price
                    result += dif
                }
            }
            
        }
        return result
    }
   
}
