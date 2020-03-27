//买卖股票的最佳时机
//给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。
//
//如果你最多只允许完成一笔交易（即买入和卖出一支股票一次），设计一个算法来计算你所能获取的最大利润。
//
//注意：你不能在买入股票前卖出股票。
//
//
//
//示例 1:
//
//输入: [7,1,5,3,6,4]
//输出: 5
//解释: 在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
//     注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格。
func maxProfit(_ prices: [Int]) -> Int {
    if prices.isEmpty {
        return 0
    }
    
    func findMaxAfter(_ index: Int) -> Int {
        var maxValue = prices[index + 1]
        for i in index+2 ..< prices.count {
            if prices[i] > maxValue {
                maxValue = prices[i]
            }
        }
        return maxValue
    }
    
    var resalut = 0
    for i in 0 ..< prices.count - 1{
        let maxValue = findMaxAfter(i)
        if maxValue > prices[i] {
            resalut = max(resalut, maxValue - prices[i])
        }
    }
    
    return resalut
}

maxProfit([])

//买卖股票的最佳时机 II
//给定一个数组，它的第 i 个元素是一支给定股票第 i 天的价格。
//
//设计一个算法来计算你所能获取的最大利润。你可以尽可能地完成更多的交易（多次买卖一支股票）。
//
//注意：你不能同时参与多笔交易（你必须在再次购买前出售掉之前的股票）。
//
//示例 1:
//
//输入: [7,1,5,3,6,4]
//输出: 7
//解释: 在第 2 天（股票价格 = 1）的时候买入，在第 3 天（股票价格 = 5）的时候卖出, 这笔交易所能获得利润 = 5-1 = 4 。
//     随后，在第 4 天（股票价格 = 3）的时候买入，在第 5 天（股票价格 = 6）的时候卖出, 这笔交易所能获得利润 = 6-3 = 3 。

func maxProfit2(_ prices: [Int]) -> Int {
    if prices.count <= 1 {
        return 0
    }
    var resalut = 0
    
    for i in 1 ..< prices.count {
        if prices[i] > prices[i-1] {
            resalut += prices[i] - prices[i-1]
        }
    }
    
    return resalut
}

//在一个由 0 和 1 组成的二维矩阵内，找到只包含 1 的最大正方形，并返回其面积。
//
//示例:
//
//输入:
//
//1 0 1 0 0
//1 0 1 1 1
//1 1 1 1 1
//1 0 0 1 0
//
//输出: 4

func maximalSquare(_ matrix: [[Character]]) -> Int {
    if matrix.isEmpty {
        return 0
    }
    
    var resault = 0
    var maxRow = matrix.count
    var maxCol = matrix[0].count
    var maxCount = min(maxRow, maxCol)
    
    var countArray = Array(repeating: Array(repeating: -1, count: maxCol), count: maxRow)
    
    func maxCountFor(_ row: Int, col: Int) -> Int {
        if row < 0 || col < 0 || row > matrix.count - 1 || col > matrix[0].count - 1 {
            return 0
        }
        if countArray[row][col] != -1 {
            return countArray[row][col]
        }
        if matrix[row][col] == "0" {
            return 0
        }
        if row == 0 || col == 0 {
            return 1
        }
        var resault = 1
        resault += min(maxCountFor(row - 1, col: col), maxCountFor(row - 1, col: col - 1), maxCountFor(row, col: col - 1))
        countArray[row][col] = resault
        return resault
    }
    
    for i in 0..<maxRow {
        for j in 0..<maxCol {
            resault = max(resault, maxCountFor(i, col: j))
            if resault == maxCount {
                break
            }
        }
    }
    
    return resault * resault
}
