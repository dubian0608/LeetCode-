//编写一个函数来查找字符串数组中的最长公共前缀。
//如果不存在公共前缀，返回空字符串 ""
//输入: ["flower","flow","flight"]
//输出: "fl"

func longestCommonPrefix(_ strs: [String]) -> String {
    var commonPrefix = ""
    if strs.count > 0 {
        commonPrefix = strs[0]
    }
    for str in strs {
        while !str.hasPrefix(commonPrefix) {
            commonPrefix = String(commonPrefix.prefix(commonPrefix.count - 1))
            if commonPrefix.isEmpty {
                return commonPrefix
            }
        }
    }
    return commonPrefix
}

let strs: Array<String> = []
longestCommonPrefix(strs)

let str1 = "flower"
let str2 = "fl"
let res = str1.hasPrefix(str2)
let a = str1.prefix(str1.count - 1)

//给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
//输入: "abcabcbb"
//输出: 3
//解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。

func lengthOfLongestSubstring(_ s: String) -> Int {
    var list:[Character] = []
    var count = 0
    
    for ch in s {
        count = max(count, list.count)
        if let index = list.firstIndex(of: ch) {
            list.removeSubrange(0...index)
        }
        list.append(ch)
    }
    return max(count, list.count)
}

//给定两个字符串 s1 和 s2，写一个函数来判断 s2 是否包含 s1 的排列。
//换句话说，第一个字符串的排列之一是第二个字符串的子串。
//输入: s1 = "ab" s2 = "eidbaooo"
//输出: True
//解释: s2 包含 s1 的排列之一 ("ba").

func checkInclusion(_ s1: String, _ s2: String) -> Bool {
    guard s1.count <= s2.count else {
        return false
    }
    
    let len1 = s1.count
    let len2 = s2.count
    let chars1 = Array(s1.unicodeScalars)
    let chars2 = Array(s2.unicodeScalars)
    
    func allZero(_ counts: Array<Int>) -> Bool {
        for i in counts {
            if i != 0 {
                return false
            }
        }
        return true
    }
    var counts = Array<Int>(repeating: 0, count: 26)
    
    for i in 0 ..< len1 {
        counts[Int(chars1[i].value - 97)] += 1
        counts[Int(chars2[i].value - 97)] -= 1
    }
    
    if allZero(counts) {
        return true
    }
    
    for i in len1 ..< len2 {
        counts[Int(chars2[i].value - 97)] -= 1
        counts[Int(chars2[i - len1].value - 97)] += 1
        if allZero(counts) {
            return true
        }
    }
    
    return false
}

//给定两个以字符串形式表示的非负整数 num1 和 num2，返回 num1 和 num2 的乘积，它们的乘积也表示为字符串形式。
//输入: num1 = "2", num2 = "3"
//输出: "6"
func multiply(_ num1: String, _ num2: String) -> String {
    if num1 == "0" || num2 == "0" {
        return "0"
    }
    func StringToArray(_ str: String) -> Array<Int> {
        var arr = Array<Int>()
        let nums = Array(str.unicodeScalars)
        var valueOfZero: Int = 0
        
        for i in "0".unicodeScalars {
            valueOfZero = Int(i.value)
        }
        for i in nums {
            arr.insert(Int(i.value) - valueOfZero, at: 0)
        }
        return arr
    }
    
    let numArr1 = StringToArray(num1)
    let numArr2 = StringToArray(num2)

    
    var resault = Array<Int>(repeating: 0, count: numArr1.count + numArr2.count)
    
    for i in 0 ..< numArr1.count {
        for j in 0 ..< numArr2.count {
            resault[i + j] += numArr1[i] * numArr2[j]
        }
    }
    
    var carry: Int = 0
    
    for i in (0 ..< resault.count) {
        resault [i] += carry
        carry = resault[i] / 10
        resault[i] %= 10
    }
   
    if carry != 0 {
        resault[resault.count - 1] = carry
    }
    
    var resaultStr = ""
    var lastCount = resault.count
    if resault.last == 0 {
        lastCount -= 1
    }
    for i in (0 ..< lastCount).reversed() {
        resaultStr += String(resault[i])
    }
    return resaultStr
}

multiply("123", "456")

//翻转字符串里的单词
//输入: "a good   example"
//输出: "example good a"
//解释: 如果两个单词间有多余的空格，将反转后单词间的空格减少到只含一个。

class Solution {
    func reverseWords(_ s: String) -> String {
        if s == "" { return "" }
        var resault = ""
        let arr = s.split(separator: " ")
        for str in arr.reversed() {
            resault += str
            resault += " "
        }
        if !resault.isEmpty {
            resault.removeLast()
        }
        
        return resault
    }
}

//简化路径

func simplifyPath(_ path: String) -> String {
    var resault = [String]()
    let pathArray = path.split(separator: "/")
    for path in pathArray {
        if path == "." {
            continue
        } else if path == ".." {
            if resault.isEmpty {
                continue
            } else {
                resault.removeLast()
            }
        } else {
            resault.append(String(path))
        }
    }
    
    let resultStr = resault.reduce("") { (total, dir) in
         return "\(total)/\(dir)"
    }
    return resultStr.isEmpty ? "/": resultStr
}

//复原IP地址
//给定一个只包含数字的字符串，复原它并返回所有可能的 IP 地址格式。
//
//示例:
//
//输入: "25525511135"
//输出: ["255.255.11.135", "255.255.111.35"]

func restoreIpAddresses(_ s: String) -> [String] {
    
    func restoreIpAddressesHelper(_ s: String, num: Int) -> [String] {
        if s.count < num || s.count > 3 * num {
            return []
        }
        
        if num == 1 {
            guard let snum = Int(s), snum <= 255 else {
                return []
            }
            if s.count == 1 || s.first != "0"  {
                return [s]
            } else {
                return []
            }
        }
        
        var resault = [String]()
        
        for i in 1 ... min(3, s.count) {
            let index = s.index(s.startIndex, offsetBy: i)
            guard let ad = Int(s[..<index]) else {
                return resault
            }
            if ad > 255 {
                return resault
            } else {
                let lastStr = s[s.index(s.startIndex, offsetBy: i)..<s.endIndex]
                let res = restoreIpAddressesHelper(String(lastStr), num: num - 1)
                
            
                for member in res {
                    resault.append("\(ad).\(member)")
                }
                if ad == 0 {
                    break
                }
            }
        }
        
        return resault
    }
    
    let resault = restoreIpAddressesHelper(s, num: 4)
    return resault
}

restoreIpAddresses("172162541")
