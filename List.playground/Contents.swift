import Foundation
//将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
//
//示例：
//
//输入：1->2->4, 1->3->4
//输出：1->1->2->3->4->4

public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init(_ val: Int) {
         self.val = val
         self.next = nil
     }
}

func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    guard let l1 = l1 else {
        return l2
    }
    
    guard let l2 = l2 else {
        return l1
    }
    
    var node1: ListNode
    var node2: ListNode?
    var header: ListNode
    if l1.val <= l2.val {
        header = l1
        node1 = l1
        node2 = l2
    } else {
        header = l2
        node1 = l2
        node2 = l1
    }
    
    while let next = node1.next {
        while let node = node2, node.val <= next.val {
            node1.next = node
            node2 = node2?.next
            node.next = next
            node1 = node
        }
        
        node1 = next
    }
    
    if node2 != nil {
        node1.next = node2
    }
    
    return header
}

//反转链表
//反转一个单链表。
//
//示例:
//
//输入: 1->2->3->4->5->NULL
//输出: 5->4->3->2->1->NULL

func reverseList(_ head: ListNode?) -> ListNode? {
    var header: ListNode? = nil
    var node = head
    while node != nil {
        let nodeHelp = node
        node = node?.next
        nodeHelp?.next = header
        header = nodeHelp
    }
    
    return header
}

//两数相加
//给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。
//
//如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。
//
//您可以假设除了数字 0 之外，这两个数都不会以 0 开头。
//
//示例：
//
//输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)
//输出：7 -> 0 -> 8
//原因：342 + 465 = 807

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var num1 = l1
    var num2 = l2
    var carry = 0
    
    while let a = num1, let b = num2 {
        let sum = a.val + b.val + carry
        carry = sum / 10
        a.val = sum % 10
        num1 = num1?.next
        num2 = num2?.next
    }
    
    if num2 != nil {
        num1 = num2
        var help = l1
        while let next = help?.next {
            help = next
        }
        help?.next = num1
        num2 = nil
    }
    
    if num1 != nil {
        while carry != 0, let a = num1 {
            let sum = a.val + carry
            carry = sum / 10
            a.val = sum % 10
            num1 = num1?.next
        }
    }
    
    if num1 == nil, num2 == nil, carry != 0 {
        let node = ListNode(carry)
        var help = l1
        while let next = help?.next {
            help = next
        }
        help?.next = node
    }
    
    return l1
}

//排序链表
//在 O(n log n) 时间复杂度和常数级空间复杂度下，对链表进行排序。
//
//示例 1:
//
//输入: 4->2->1->3
//输出: 1->2->3->4

func printList(_ head: ListNode?) {
    var node = head
    while node != nil {
        print(node!.val)
        node = node?.next
    }
}
func sortList(_ head: ListNode?) -> ListNode? {
    guard let listMid = head else {
        return head
    }

    var listLeft: ListNode? = nil
    var listRight: ListNode? = nil
    
    var node = head?.next
    listMid.next = nil
    
    while let n = node {
        node = node?.next
        if n.val < listMid.val {
            n.next = listLeft?.next
            if listLeft != nil {
                listLeft?.next = n
            } else {
                listLeft = n
            }
        } else if n.val > listMid.val {
            n.next = listRight?.next
            if listRight != nil {
                listRight?.next = n
            } else {
                listRight = n
            }
        } else {
            n.next = listMid.next
            listMid.next = n
        }
    }
    
    var left = sortList(listLeft)
    let right = sortList(listRight)
    
    node = listMid
    while let next = node?.next {
        node = next
    }
    node?.next = right

    if left != nil {
        node = left
        while let next = node?.next {
            node = next
        }
        node?.next = listMid
    } else {
        left = listMid
    }
    
    return left
}

func creatList(_ nums:[Int]) -> ListNode? {
    let  head = ListNode(0)
    head.next = nil
    var nodePr: ListNode? = head
    for num in nums {
        let node = ListNode(num)
        nodePr?.next = node
        nodePr = node
    }
    return head.next
}

let head = creatList([4,19,14,5,-3,1,8,5,11,15])

sortList(head)


//环形链表 II
//给定一个链表，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。
//
//为了表示给定链表中的环，我们使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。 如果 pos 是 -1，则在该链表中没有环。
//
//说明：不允许修改给定的链表。
//
//
//
//示例 1：
//
//输入：head = [3,2,0,-4], pos = 1
//输出：tail connects to node index 1
//解释：链表中有一个环，其尾部连接到第二个节点。

func detectCycle(_ head: ListNode?) -> ListNode? {
    if head == nil  {
        return nil
    }
    var dic = Dictionary<Int, ListNode>()
    
    var node = head
    while node != nil {
        guard let next = node?.next else {
            return nil
        }
        
        let nextPoint = Unmanaged<AnyObject>.passUnretained(next as AnyObject).toOpaque()
        let nextHashValue = nextPoint.hashValue
        
        if let _ = dic[nextHashValue] {
            return next
        }
        
        let point = Unmanaged<AnyObject>.passUnretained(node as AnyObject).toOpaque()
        let hashValue = point.hashValue
        dic[hashValue] = next
        
        node = next
    }
    return nil
}

//编写一个程序，找到两个单链表相交的起始节点。
//
//如下面的两个链表：
//输入：intersectVal = 8, listA = [4,1,8,4,5], listB = [5,0,1,8,4,5], skipA = 2, skipB = 3
//输出：Reference of the node with value = 8
//输入解释：相交节点的值为 8 （注意，如果两个列表相交则不能为 0）。从各自的表头开始算起，链表 A 为 [4,1,8,4,5]，链表 B 为 [5,0,1,8,4,5]。在 A 中，相交节点前有 2 个节点；在 B 中，相交节点前有 3 个节点。
func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
    guard let headA = headA, let headB = headB else {
        return nil
    }
    
    var set = Set<Int>()
    
    var node: ListNode? = headA
    while node != nil {
        let point = Unmanaged<AnyObject>.passUnretained(node as AnyObject).toOpaque()
        let hashValue = point.hashValue
        
        set.insert(hashValue)
        node = node?.next
    }
    
    node = headB
    while node != nil {
        let point = Unmanaged<AnyObject>.passUnretained(node as AnyObject).toOpaque()
        let hashValue = point.hashValue
        
        if set.contains(hashValue) {
            return node
        }
        node = node?.next
    }
    
    return nil
}

//合并 k 个排序链表，返回合并后的排序链表。请分析和描述算法的复杂度。
//
//示例:
//
//输入:
//[
//  1->4->5,
//  1->3->4,
//  2->6
//]
//输出: 1->1->2->3->4->4->5->6
func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
    if lists.isEmpty {
        return nil
    }
    
    var helpList = [ListNode]()
    for list in lists {
        if let list = list {
            helpList.append(list)
        }
    }
    
    var resalut: ListNode? = ListNode(0)
    
    func findTheMin(_ listArray: [ListNode]) -> Int {
        var minValue = listArray.first!.val
        var minIndex = 0
        for (index, node) in listArray.enumerated() {
            if node.val < minValue {
                minValue = node.val
                minIndex = index
            }
        }
        
        return minIndex
    }
    
    var node = resalut
    while helpList.count > 1 {
        let index = findTheMin(helpList)
        
        let findNode = helpList[index]
        if let findNodeNext = findNode.next {
            helpList[index] = findNodeNext
        } else {
            helpList.remove(at: index)
        }
        findNode.next = nil
        node?.next = findNode
        node = findNode
    }
    
    if helpList.count == 1 {
        node?.next = helpList[0]
    }
    
    return resalut?.next
}

func creatLists(_ arrs: [[Int]]) -> [ListNode?] {
    var resault = [ListNode?]()
    for arr in arrs {
        let list = creatList(arr)
        resault.append(list)
    }
    
    return resault
}

var arrs = Array(repeating: [0], count: 10000)
for i in 0 ..< arrs.count {
    arrs[i][0] = Int(arc4random() % 101)
}

//mergeKLists(creatLists(arrs))


func mergeKLists2(_ lists: [ListNode?]) -> ListNode? {
    if lists.isEmpty {
        return nil
    }
    var resault = lists[0]
    
    for i in 1 ..< lists.count {
        resault = mergeTwoLists(resault, lists[i])
    }
    
    return resault
}

mergeKLists2(creatLists(arrs))

//给定一个二叉树, 找到该树中两个指定节点的最近公共祖先。
//
//百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”
//
//例如，给定如下二叉树:  root = [3,5,1,6,2,0,8,null,null,7,4]

//输入: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
//输出: 3
//解释: 节点 5 和节点 1 的最近公共祖先是节点 3。
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}
func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
    guard let root = root, let p = p, let q = q else {
        return nil
    }
    
    func isContain(_ root: TreeNode?, _ value: TreeNode) -> Bool {
        guard let root = root else {
            return false
        }
        if root.val == value.val {
            return true
        }
        if isContain(root.left, value) {
            return true
        }
        if isContain(root.right, value) {
            return true
        }
        return false
    }
    
    if root.val == p.val {
        if isContain(root, q) {
            return root
        } else {
            return nil
        }
    } else if root.val == q.val {
        if isContain(root, p) {
            return root
        } else {
            return nil
        }
    } else {
        if let resault = lowestCommonAncestor(root.left, p, q) {
            return resault
        }
        if let resault = lowestCommonAncestor(root.right, p, q) {
            return resault
        }
        if isContain(root, p), isContain(root, q) {
            return root
        } else {
            return nil
        }
    }
}

func creatTree(_ value: [Int?]) -> TreeNode? {
    if value.isEmpty {
        return nil
    }
    guard let firstValue = value.first, let rootValue = firstValue  else {
        return nil
    }
    
    var childValue = value
    childValue.remove(at: 0)
    
    let root = TreeNode(rootValue)
    
    func creatTreeFor(_ index: Int) -> TreeNode? {
        if index > value.count - 1 {
            return nil
        }
        guard let nodeValue = value[index] else {
            return nil
        }
        let node = TreeNode(nodeValue)
        
        node.left = creatTreeFor(index * 2 + 1)
        node.right = creatTreeFor(index * 2 + 2)
        
        return node
    }
    
    root.left = creatTreeFor(1)
    root.right = creatTreeFor(2)
    
    return root
}


//二叉树的锯齿形层次遍历
//给定一个二叉树，返回其节点值的锯齿形层次遍历。（即先从左往右，再从右往左进行下一层遍历，以此类推，层与层之间交替进行）。
//
//例如：
//给定二叉树 [3,9,20,null,null,15,7],
func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else {
        return []
    }
    var resault = [[Int]]()
    var nodes = [TreeNode]()
    nodes.append(root)
    resault.append([root.val])
    
    while !nodes.isEmpty {
        var num = [Int]()
        var childNodes = [TreeNode]()
        if resault.count % 2 == 0 {
            for i in (0..<nodes.count-1).reversed() {
                if let right = nodes[i].right {
                    num.append(right.val)
                    childNodes.append(right)
                }
                if let left = nodes[i].left {
                    num.append(left.val)
                    childNodes.append(left)
                }
            }
        } else {
            for i in (0..<nodes.count-1).reversed() {
                if let left = nodes[i].left {
                    num.append(left.val)
                    childNodes.append(left)
                }
                if let right = nodes[i].right {
                    num.append(right.val)
                    childNodes.append(right)
                }
                print(num)
            }
        }
        if childNodes.isEmpty {
            break
        }
        resault.append(num)
        nodes = childNodes
    }
    
    return resault
}
