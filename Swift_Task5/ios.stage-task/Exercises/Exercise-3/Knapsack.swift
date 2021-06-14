import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func fillSupplies(arr: inout [[Int]], line: [Int], count: Int, i: inout Int) {
        if (i < count){
            arr.append(line)
            i += 1
            fillSupplies(arr: &arr, line: line, count: count, i: &i)
        }
    }
    
    private var result = 0
    
    func fillDistributions(supplies: inout [[Int]], line: (Int, Int), i: inout Int, j: Int) {
        while (i < maxWeight){
            if ((i - line.0 == 0 || (i - line.0 > 0 && supplies[j][i - line.0] > 0))) { supplies[j + 1][i] = max(supplies[j][i - line.0] + line.1, supplies[j][i]) }
            else{ supplies[j + 1][i] = supplies[j][i] }
            i += 1
        }
    }
    
    func fillLines(supplies: inout [[Int]], count: inout Int, limit: Int, flag: Int) {
        if (count < limit){
            var index = 1
            var supply = (0, 0)
            (flag == 0) ? (supply = foods[count]) : (supply = drinks[count])
            fillDistributions(supplies: &supplies, line: supply, i: &index, j: count)
            count += 1
            fillLines(supplies: &supplies, count: &count, limit: limit, flag: flag)
        }
    }
    
    func checkDescendingDistribution(supplies: inout ([[Int]], [[Int]]), value: Int, count: inout Int, x: Int, y: Int) {
        while (count < maxWeight){
            let tmpDrink = supplies.1[y][count]
            let tmp = min(value, tmpDrink)
            if (x + count <= maxWeight){ result = max(result, tmp) }
            count += 1
        }
    }
    
    func checkDistributions(supplies: inout ([[Int]], [[Int]]), count: inout Int, x: Int, y: Int) {
        while (count < maxWeight){
            let tmpFood = supplies.0[x][count]
            var index = 0
            checkDescendingDistribution(supplies: &supplies, value: tmpFood, count: &index, x: count, y: y)
            count += 1
        }
    }
    
    func findMaxKilometres() -> Int {
        if ((drinks.isEmpty && foods.isEmpty) || maxWeight <= 0) { return 0 }
        let line = Array(repeating: 0, count: maxWeight + 1)
        var allFoods: [[Int]] = []
        var allDrinks: [[Int]] = []
        var iFood = 0
        var iDrink = 0
        let foodCount = foods.count
        let drinkCount = drinks.count
        
        fillSupplies(arr: &allFoods, line: line, count: foodCount + 1, i: &iFood)
        fillSupplies(arr: &allDrinks, line: line, count: drinkCount + 1, i: &iDrink)
        iFood = 0
        iDrink = 0
        fillLines(supplies: &allFoods, count: &iFood, limit: foodCount, flag: 0)
        fillLines(supplies: &allDrinks, count: &iDrink, limit: drinkCount, flag: 1)
        var tuple = (allFoods, allDrinks)
        var i = 0
        checkDistributions(supplies: &tuple, count: &i, x: foodCount, y: drinkCount)
        let res = result
        return res
    }
}
