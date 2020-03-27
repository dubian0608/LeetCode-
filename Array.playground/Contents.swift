import Foundation
//三数之和
//给你一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请你找出所有满足条件且不重复的三元组。
//
//注意：答案中不可以包含重复的三元组。

//给定数组 nums = [-1, 0, 1, 2, -1, -4]，
//
//满足要求的三元组集合为：
//[
//  [-1, 0, 1],
//  [-1, -1, 2]
//]

func threeSum(_ nums: [Int]) -> [[Int]] {
    var ret = [[Int]]()
    if nums.count<=2 {
        return ret
    }
    
    let sortNums = nums.sorted(by: <)
    for i in 0 ..< sortNums.count - 2 {
        if i != 0, sortNums[i] == sortNums[i-1] { continue }
        var leftIndex = i+1
        var rightIndex = sortNums.count - 1
        let midValue = sortNums[i]
        
        while leftIndex < rightIndex {
            let leftValue = sortNums[leftIndex]
            let rightValue = sortNums[rightIndex]
            let sum = leftValue + midValue + rightValue
            if sum == 0 {
                ret.append([leftValue, midValue, rightValue])
                while leftIndex < rightIndex, sortNums[leftIndex] == sortNums[leftIndex + 1]  {
                    leftIndex += 1
                }
                while rightIndex > leftIndex, sortNums[rightIndex] == sortNums[rightIndex - 1] {
                    rightIndex -= 1
                }
                leftIndex += 1
                rightIndex -= 1
            } else if sum > 0 {
                while rightIndex > leftIndex, sortNums[rightIndex] == sortNums[rightIndex - 1] {
                    rightIndex -= 1
                }
                rightIndex -= 1
            } else {
                while leftIndex < rightIndex, sortNums[leftIndex] == sortNums[leftIndex + 1]  {
                    leftIndex += 1
                }
                leftIndex += 1
            }
        }
    }
    return ret
}

let nums = [-1, 0, 1, 2, -1, -4]

threeSum(nums)

//岛屿的最大面积
//给定一个包含了一些 0 和 1的非空二维数组 grid , 一个 岛屿 是由四个方向 (水平或垂直) 的 1 (代表土地) 构成的组合。你可以假设二维矩阵的四个边缘都被水包围着。
//
//找到给定的二维数组中最大的岛屿面积。(如果没有岛屿，则返回面积为0。)
//
//示例 1:
//
//[[0,0,1,0,0,0,0,1,0,0,0,0,0],
// [0,0,0,0,0,0,0,1,1,1,0,0,0],
// [0,1,1,0,1,0,0,0,0,0,0,0,0],
// [0,1,0,0,1,1,0,0,1,0,1,0,0],
// [0,1,0,0,1,1,0,0,1,1,1,0,0],
// [0,0,0,0,0,0,0,0,0,0,1,0,0],
// [0,0,0,0,0,0,0,1,1,1,0,0,0],
// [0,0,0,0,0,0,0,1,1,0,0,0,0]]
//对于上面这个给定矩阵应返回 6。注意答案不应该是11，因为岛屿只能包含水平或垂直的四个方向的‘1’。

func maxAreaOfIsland(_ grid: [[Int]]) -> Int {
    let rows = grid.count
    let cols = grid[0].count
    var resault = 0
    
    var visted = Array(repeating: Array(repeating: false, count: cols), count: rows)
    
    func maxAreaOfSubIsland(row: Int, col: Int) -> Int {
        
        var count = 0
        if row < 0 || row >= rows || col < 0 || col >= cols {
            return count
        } else if grid[row][col] == 0 || visted[row][col] {
            return count
        } else {
            count += 1
            visted[row][col] = true
        }
        
        count += maxAreaOfSubIsland(row: row - 1, col: col)
        count += maxAreaOfSubIsland(row: row+1, col: col)
        count += maxAreaOfSubIsland(row: row, col: col-1)
        count += maxAreaOfSubIsland(row: row, col: col+1)

        return count
    }
    
    for i in 0..<rows {
        for j in 0..<cols {
            if grid[i][j] == 0 || visted[i][j] {
                continue
            }

            let count = maxAreaOfSubIsland(row: i, col: j)
            
            resault = max(resault, count)
        }
    }
    
    return resault
}

let gard = [[1,0,1],
            [1,1,1]]
maxAreaOfIsland(gard)

//搜索旋转排序数组
//假设按照升序排序的数组在预先未知的某个点上进行了旋转。
//
//( 例如，数组 [0,1,2,4,5,6,7] 可能变为 [4,5,6,7,0,1,2] )。
//
//搜索一个给定的目标值，如果数组中存在这个目标值，则返回它的索引，否则返回 -1 。
//
//你可以假设数组中不存在重复的元素。
//
//你的算法时间复杂度必须是 O(log n) 级别。
//
//示例 1:
//
//输入: nums = [4,5,6,7,0,1,2], target = 0
//输出: 4

func search(_ nums: [Int], _ target: Int) -> Int {
    
    func searchInSub(start: Int, end: Int) -> Int {
        if end < start {
            return -1
        }
        if end == start, nums[start] != target {
            return -1
        }
        if nums[start] < nums[end] && (target < nums[start] || target > nums[end]) {
            return -1
        }
        let mid = (end - start) / 2 + start
       
        if nums[mid] == target {
            return mid
        }
        
        var index = -1
        index = searchInSub(start: start, end: mid)
        if index != -1 {
            return index
        }
        return searchInSub(start: mid + 1, end: end)
    }
    
    return searchInSub(start: 0, end: nums.count - 1)
}

let nums1 = [1]

search(nums1, 0)


//最长连续递增序列
//给定一个未经排序的整数数组，找到最长且连续的的递增序列。
//
//示例 1:
//
//输入: [1,3,5,4,7]
//输出: 3
//解释: 最长连续递增序列是 [1,3,5], 长度为3。
//尽管 [1,3,5,7] 也是升序的子序列, 但它不是连续的，因为5和7在原数组里被4隔开。

func findLengthOfLCIS(_ nums: [Int]) -> Int {
    var resault = 0
    var count = 1
    
    if nums.isEmpty {
        return 0
    }
    
    for i in 1 ..< nums.count {
        if count == 0, nums.count - i < resault {
            break
        }
        if nums[i] > nums[i-1] {
            count += 1
        } else {
            resault = max(resault, count)
            count = 1
        }
    }
    
    resault = max(resault, count)
    
    return resault
}

var test = [1,3,5,4,2,3,4,5]
findLengthOfLCIS(test)

//在未排序的数组中找到第 k 个最大的元素。请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。
//
//示例 1:
//
//输入: [3,2,1,5,6,4] 和 k = 2
//输出: 5
func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    var resault = 0
    
    let sortedNums = nums.sorted(by: >)
    resault = sortedNums[k-1]
    
    
    return resault
}

let nums2 = [3,2,1,5,6,4]
findKthLargest(nums2, 2)


//给定一个未排序的整数数组，找出最长连续序列的长度。
//
//要求算法的时间复杂度为 O(n)。
//
//示例:
//
//输入: [100, 4, 200, 1, 3, 2]
//输出: 4
//解释: 最长连续序列是 [1, 2, 3, 4]。它的长度为 4。

func longestConsecutive(_ nums: [Int]) -> Int {
    var resault = 0
    var dic = Dictionary<Int, Int>()
    
    for (index, num) in nums.enumerated() {
        dic[num] = index
    }
    
    func longestConsecutiveFor(_ num: Int) -> Int {
        var count = 1
        dic.removeValue(forKey: num)
        if dic[num - 1] != nil {
            count += longestConsecutiveFor(num - 1)
        }
        if dic[num + 1] != nil {
            count += longestConsecutiveFor(num + 1)
        }
        return count
    }
    
    for num in nums {
        if dic[num] == nil {
            continue
        }
        let count = longestConsecutiveFor(num)
        
        resault = max(resault, count)
    }
    
    return resault
}

longestConsecutive([-4,-4,2,-6,9,6,8,-6,-9,-1,9,5,2,-6,0])

//给出集合 [1,2,3,…,n]，其所有元素共有 n! 种排列。
//
//按大小顺序列出所有排列情况，并一一标记，当 n = 3 时, 所有排列如下：
//
//"123"
//"132"
//"213"
//"231"
//"312"
//"321"
//给定 n 和 k，返回第 k 个排列。
//
//说明：
//
//给定 n 的范围是 [1, 9]。
//给定 k 的范围是[1,  n!]。
//示例 1:
//
//输入: n = 3, k = 3
//输出: "213"

func getPermutation(_ n: Int, _ k: Int) -> String {
    func factorial(_ num: Int) -> Int {
        if num == 0 {
            return 0
        }
        var res = 1
        var n = num
        while n > 0 {
            res *= n
            n -= 1
        }
        return res
    }
    var resault = ""
    var helper = k
    var arr = Array(repeating: 0, count: n)
    var arrHelp = [Int]()
    for i in 0 ..< n {
        arrHelp.append(i + 1)
    }
    
    var index = 0
    for i in 0 ..< n {
        if i != 0 {
            helper -= index * factorial(n - i)
        }
        
        if i != n - 1 {
            index = Int(ceil(Double(helper) / Double(factorial(n - i - 1)))) - 1
        } else {
            index = 0
        }
        
        arr[i] = arrHelp[index]
        arrHelp.remove(at: index)
        
    }
    
    resault = arr.reduce("", { (total, num) -> String in
        return "\(total)\(num)"
    })
    
    return resault
}

getPermutation(2, 2)


//朋友圈
//班上有 N 名学生。其中有些人是朋友，有些则不是。他们的友谊具有是传递性。如果已知 A 是 B 的朋友，B 是 C 的朋友，那么我们可以认为 A 也是 C 的朋友。所谓的朋友圈，是指所有朋友的集合。
//
//给定一个 N * N 的矩阵 M，表示班级中学生之间的朋友关系。如果M[i][j] = 1，表示已知第 i 个和 j 个学生互为朋友关系，否则为不知道。你必须输出所有学生中的已知的朋友圈总数。
//
//示例 1:
//
//输入:
//[[1,1,0],
// [1,1,0],
// [0,0,1]]
//输出: 2
//说明：已知学生0和学生1互为朋友，他们在一个朋友圈。
//第2个学生自己在一个朋友圈。所以返回2。
func findCircleNum(_ M: [[Int]]) -> Int {
    var resault = 0
    let rows = M.count
    
    var inCircle = Array(repeating: false, count: rows)
    
    func findFriendsFor(_ menber: Int) {
        for i in 0 ..< rows {
            if M[menber][i] == 1, !inCircle[i] {
                inCircle[i] = true
                findFriendsFor(i)
            }
        }
    }
    
    for i in 0 ..< rows {
        var hasCircle = false
        for j in 0 ..< rows {
            if M[i][j] == 1, !inCircle[i], !inCircle[j] {
                inCircle[i] = true
                inCircle[j] = true
                findFriendsFor(j)
                hasCircle = true
            }
        }
        if hasCircle {
            resault += 1
        }
    }
    
    return resault
}

let circle = [[1,0,0,1],
              [0,1,1,0],
              [0,1,1,1],
              [1,0,1,1]]

findCircleNum(circle)


//合并区间
//给出一个区间的集合，请合并所有重叠的区间。
//
//示例 1:
//
//输入: [[1,3],[2,6],[8,10],[15,18]]
//输出: [[1,6],[8,10],[15,18]]
//解释: 区间 [1,3] 和 [2,6] 重叠, 将它们合并为 [1,6].

func merge(_ intervals: [[Int]]) -> [[Int]] {
    if intervals.isEmpty {
        return []
    }
    var souredArr = intervals.sorted { (x, y) -> Bool in
        guard let a = x.first, let b = y.first else {
            fatalError("")
        }
        return a < b
    }
    
    for i in 0 ..< souredArr.count - 1 {
        while souredArr[i][1] >= souredArr[i+1][0] {
            if souredArr[i][1] < souredArr[i+1][1] {
                let newValue: [Int] = [souredArr[i][0], souredArr[i+1][1]]
                souredArr.remove(at: i)
                souredArr.remove(at: i)
                souredArr.insert(newValue, at: i)
            
            } else {
                souredArr.remove(at: i+1)
            }
            
            if i >= souredArr.count - 1 {
                break
            }
        }
        
        if i >= souredArr.count - 2 {
            break
        }
    }
    
    return souredArr
}

//给定 n 个非负整数表示每个宽度为 1 的柱子的高度图，计算按此排列的柱子，下雨之后能接多少雨水。

//
//示例:
//
//输入: [0,1,0,2,1,0,1,3,2,1,2,1]
//输出: 6

func trap(_ height: [Int]) -> Int {
    if height.count <= 2 {
        return 0
    }
    
    var resault = 0

    var highPointArr = [Int]()
    
    func ifKeepIndex(_ index: Int, in arr: [Int]) -> Bool {
        if arr.count <= 2 {
            return true
        }
        var hasHigherLeft = false
        var hasHigherRight = false
        
        for i in 0..<index {
            if height[arr[i]] > height[arr[index]] {
                hasHigherLeft = true
                break
            }
        }
        for i in index+1 ..< arr.count {
            if height[arr[i]] > height[arr[index]] {
                hasHigherRight = true
                break
            }
        }
        
        return !(hasHigherLeft&&hasHigherRight)
    }
    
    highPointArr.append(0)
    for i in 1..<height.count - 1 {
        if height[i] >= height[i+1], height[i] >= height[i-1] {
            highPointArr.append(i)
        }
    }
    highPointArr.append(height.count - 1)
    
    var i = 1
    var highPointRes = [Int]()
    highPointRes.append(highPointArr[0])
    while i < highPointArr.count - 1 {
        if ifKeepIndex(i, in: highPointArr) {
            highPointRes.append(highPointArr[i])
        }
        i += 1
    }
    highPointRes.append(highPointArr[i])
    
    print(highPointRes)
        
    for i in 1 ..< highPointRes.count {
        let endIndex = highPointRes[i]
        let startIndex = highPointRes[i-1]
        let high = min(height[endIndex], height[startIndex])
        resault += (endIndex - startIndex - 1) * high
        for j in startIndex + 1 ..< endIndex {
            resault -= min(high, height[j])
        }
    }
    
    return resault
}

trap([9,6,8,8,5,6,3])

//给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
//
//示例:
//
//输入: [-2,1,-3,4,-1,2,1,-5,4],
//输出: 6
//解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。

//动态规划
func maxSubArray(_ nums: [Int]) -> Int {
    if nums.isEmpty {
        return 0
    }
    
    if nums.count == 1 {
        return nums[0]
    }
    
    var resault = nums[0]
    var maxSumI = nums[0]
    
    for i in 1..<nums.count {
        if maxSumI > 0 {
            maxSumI += nums[i]
        } else {
            maxSumI = nums[i]
        }
        
        resault = max(resault, maxSumI)
    }
    
    return resault
}

maxSubArray([-2,1,-3,4,-1,2,1,-5,4])


//三角形最小路径和
//给定一个三角形，找出自顶向下的最小路径和。每一步只能移动到下一行中相邻的结点上。
//
//例如，给定三角形：
//
//[
//     [2],
//    [3,4],
//   [6,5,7],
//  [4,1,8,3]
//]
//自顶向下的最小路径和为 11（即，2 + 3 + 5 + 1 = 11）。
func minimumTotal(_ triangle: [[Int]]) -> Int {
    if triangle.isEmpty {
        return 0
    }
    let high = triangle.count
    
    if high == 1 {
        return triangle[0][0]
    }
    
    var resaults = triangle[high - 1]
    
    for i in (0..<high-1).reversed() {
        for j in 0...i {
            resaults[j] = min(resaults[j], resaults[j+1]) + triangle[i][j]
//            print(resaults)
        }
    }
    
    return resaults[0]
}

minimumTotal([[2],[3,4],[6,5,7],[4,1,8,3]])


//俄罗斯套娃信封问题
//给定一些标记了宽度和高度的信封，宽度和高度以整数对形式 (w, h) 出现。当另一个信封的宽度和高度都比这个信封大的时候，这个信封就可以放进另一个信封里，如同俄罗斯套娃一样。
//
//请计算最多能有多少个信封能组成一组“俄罗斯套娃”信封（即可以把一个信封放到另一个信封里面）。
//
//说明:
//不允许旋转信封。
//
//示例:
//
//输入: envelopes = [[5,4],[6,4],[6,7],[2,3]]
//输出: 3
//解释: 最多信封的个数为 3, 组合为: [2,3] => [5,4] => [6,7]。

func maxEnvelopes(_ envelopes: [[Int]]) -> Int {
    if envelopes.isEmpty {
        return 0
    }
    
    let sortedEnvelops = envelopes.sorted { (a, b) -> Bool in
        return a[0] < b[0]
    }
    
    var resault = 1
    
    let count = envelopes.count
    var resaults = Array(repeating: 1, count: count)
    
    for i in 1 ..< count {
        for j in 0..<i {
            if sortedEnvelops[i][1] > sortedEnvelops[j][1] , sortedEnvelops[i][0] != sortedEnvelops[j][0] {
                resaults[i] = max(resaults[i], resaults[j] + 1)
            }
        }
        resault = max(resaults[i], resault)
    }
    
    return resault
}

maxEnvelopes([[4,5],[4,6],[6,7],[2,3],[1,1]])


func findIsCanCut(_ nums:[Int]) -> Bool {
    if nums.count < 3 {
        return false
    }
    
    var sum = 0
    for num in nums {
        sum += num
    }
    
    if sum % 3 != 0 {
        return false
    }
    
    sum = sum / 3
    
    var subSum = 0
    for i in 0 ..< nums.count - 2 {
        subSum += nums[i]
        if subSum == sum {
            var subSumJ = 0
            for j in i + 1..<nums.count {
                subSumJ += nums[j]
                if subSumJ == sum {
                    var subSumK = 0
                    for k in j + 1..<nums.count {
                        subSumK += nums[k]
                    }
                    if subSumK == sum {
                        return true
                    }
                }
            }
        }
    }
    
    return false
}

findIsCanCut([3,3,3])
