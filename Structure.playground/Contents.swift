//最小栈
//设计一个支持 push，pop，top 操作，并能在常数时间内检索到最小元素的栈。
//
//push(x) -- 将元素 x 推入栈中。
//pop() -- 删除栈顶的元素。
//top() -- 获取栈顶元素。
//getMin() -- 检索栈中的最小元素。
//示例:
//
//MinStack minStack = new MinStack();
//minStack.push(-2);
//minStack.push(0);
//minStack.push(-3);
//minStack.getMin();   --> 返回 -3.
//minStack.pop();
//minStack.top();      --> 返回 0.
//minStack.getMin();   --> 返回 -2.
class MinStack {
    private var memberList: Array<Int>!
    private var  minValue: Int?

    /** initialize your data structure here. */
    init() {
        memberList = Array<Int>()
    }
    
    func push(_ x: Int) {
        if let minValue = minValue {
            self.minValue = min(x, minValue)
        }
        self.memberList.append(x)
    }
    
    func pop() {
        if memberList.count > 0 {
            let last = memberList.removeLast()
            guard let minValue = minValue else {return}
            if minValue == last {
                self.minValue = nil
            }
        }
    }
    
    func top() -> Int {
        guard let top = memberList.last else {
            fatalError("No value")
        }
        
        return top
    }
    
    func getMin() -> Int {
        if memberList.isEmpty {
            fatalError("No value")
        }
        if let minValue = minValue {
            return minValue
        }
        var value = memberList[0]
        for i in memberList {
            value = min(value, i)
        }
        self.minValue = value
        return value
    }
}

//LRU缓存机制
//运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制。它应该支持以下操作： 获取数据 get 和 写入数据 put 。
//
//获取数据 get(key) - 如果密钥 (key) 存在于缓存中，则获取密钥的值（总是正数），否则返回 -1。
//写入数据 put(key, value) - 如果密钥不存在，则写入其数据值。当缓存容量达到上限时，它应该在写入新数据之前删除最久未使用的数据值，从而为新的数据值留出空间。
//
//进阶:
//
//你是否可以在 O(1) 时间复杂度内完成这两种操作？
//
//示例:
//
//LRUCache cache = new LRUCache( 2 /* 缓存容量 */ );
//
//cache.put(1, 1);
//cache.put(2, 2);
//cache.get(1);       // 返回  1
//cache.put(3, 3);    // 该操作会使得密钥 2 作废
//cache.get(2);       // 返回 -1 (未找到)
//cache.put(4, 4);    // 该操作会使得密钥 1 作废
//cache.get(1);       // 返回 -1 (未找到)
//cache.get(3);       // 返回  3
//cache.get(4);       // 返回  4
public class Node<T, N> {
    required init() {}

    var next: Node?
    var prev: Node?

    public var key: T?
    public var value: N?

    init(_ key: T, _ value: N) {
        self.key = key
        self.value = value
    }
}

class DoubeList<T, N> {
    var head, tail: Node<T, N>?
    var size: Int!

    init() {
        head = Node()
        tail = Node()
        head?.next = tail
        tail?.prev = head
        size = 0
    }

    public func addFirst(_ x: Node<T, N>) {
        x.next = head?.next
        x.prev = head
        head?.next?.prev = x
        head?.next = x
        size += 1
    }
    
    public func addLast(_ x: Node<T, N>) {
        addNode(x, before: tail!)
    }
    
    public func addNode(_ x: Node<T,N>, before y: Node<T,N>) {
        y.prev?.next = x
        x.prev = y.prev
        x.next = y
        y.prev = x
    }
    
    public func addNode(_ x: Node<T,N>, after y: Node<T,N>) {
        x.next = y.next
        y.next?.prev = x
        x.prev = y
        y.next = x
    }
    
    public func remove(_ x: Node<T,N>) {
        x.prev?.next = x.next
        x.next?.prev = x.prev
        size -= 1
    }
    
    public func removeLast() -> Node<T,N>? {
        if size == 0 {
            return nil
        }
        let last = tail?.prev
        tail?.prev = last?.prev
        last?.prev?.next = tail
        size -= 1
        return last
    }
    
    public func getFirst() -> Node<T,N>? {
        guard let node = head?.next else {
            return nil
        }
        
        return node
    }
    
    public func getLast() -> Node<T,N>? {
        guard let node = tail?.prev else {
            return nil
        }
        
        return node
    }
    
    public func printList() {
        var node = head?.next
        while node != nil {
            print(node?.key, node?.value)
            node = node?.next
        }
    }
}

class LRUCache {
    private var capacity: Int!
    private var list: DoubeList<Int, Int>!
    private var hashMap: Dictionary<Int, Node<Int, Int>>!
    
    init(_ capacity: Int) {
        self.list = DoubeList()
        self.capacity = capacity
        self.hashMap = [Int: Node<Int,Int>]()
    }
    
    func get(_ key: Int) -> Int {
        guard let node = hashMap[key], let value = node.value else {
            return -1
        }
        
        list.remove(node)
        list.addFirst(node)
        
        return value
    }
    
    func put(_ key: Int, _ value: Int) {
        let node = Node(key, value)
        
        if let n = hashMap[key] {
            list.remove(n)
            list.addFirst(node)
            hashMap[key] = node
        } else {
            if list.size >= capacity {
                let last = list.removeLast()
                if let lastKey = last?.key {
                    hashMap.removeValue(forKey: lastKey)
                }
            }
            list.addFirst(node)
            hashMap[key] = node
        }
        
    }
}

let lru = LRUCache(2)
lru.put(2, 1)
lru.put(1, 1)
lru.put(2, 3)
lru.put(4, 1)
lru.get(1)
lru.get(2)


//全 O(1) 的数据结构
//实现一个数据结构支持以下操作：
//
//Inc(key) - 插入一个新的值为 1 的 key。或者使一个存在的 key 增加一，保证 key 不为空字符串。
//Dec(key) - 如果这个 key 的值是 1，那么把他从数据结构中移除掉。否者使一个存在的 key 值减一。如果这个 key 不存在，这个函数不做任何事情。key 保证不为空字符串。
//GetMaxKey() - 返回 key 中值最大的任意一个。如果没有元素存在，返回一个空字符串""。
//GetMinKey() - 返回 key 中值最小的任意一个。如果没有元素存在，返回一个空字符串""。
//挑战：以 O(1) 的时间复杂度实现所有操作。

class AllOne {
    private var list: DoubeList<Int, Set<String>>!
    private var map: Dictionary<String, Node<Int, Set<String>>>!
    
    /** Initialize your data structure here. */
    init() {
        list = DoubeList<Int, Set<String>>()
        map = Dictionary<String, Node<Int, Set<String>>>()
    }

    /** Inserts a new key <Key> with value 1. Or increments an existing key by 1. */
    func inc(_ key: String) {
        if let node = map[key] {
            guard let nodekey = node.key else {
                return
            }
            if let prevKey = node.prev?.key, prevKey - 1 == nodekey {
                node.prev?.value?.insert(key)
                map[key] = node.prev
            } else {
                let newSet: Set<String> = [key]
                let newNode = Node(nodekey+1, newSet)
                list.addNode(newNode, before: node)
                map[key] = newNode
            }
            node.value?.remove(key)
            
            if node.value!.isEmpty {
                list.remove(node)
            }
        } else {
            if let last = list.getLast() {
                if let lastKey = last.key, lastKey == 1 {
                    last.value?.insert(key)
                    map[key] = last
                } else {
                    let newSet: Set<String> = [key]
                    let newNode = Node(1, newSet)
                    list.addLast(newNode)
                    map[key] = newNode
                }
            }
        }
    }

    /** Decrements an existing key by 1. If Key's value is 1, remove it from the data structure. */
    func dec(_ key: String) {
        guard let node = map[key] else {
            return
        }
        
        guard let nodekey = node.key else {
            return
        }
        
        if nodekey == 1 {
            map.removeValue(forKey: key)
        } else if let nextKey = node.next?.key, nodekey - 1 == nextKey {
            node.next?.value?.insert(key)
            map[key] = node.next
        } else {
            let newSet: Set<String> = [key]
            let newNode = Node(nodekey-1, newSet)
            list.addNode(newNode, after: node)
            map[key] = newNode
        }

        node.value?.remove(key)
        if node.value!.isEmpty {
            list.remove(node)
        }
    }

    /** Returns one of the keys with maximal value. */
    func getMaxKey() -> String {
        guard let first = list.getFirst(), let _ = first.key  else {
            return ""
        }
        
        guard let maxKey = first.value?.first else {
            return ""
        }
        list.printList()
        return maxKey
    }

    /** Returns one of the keys with Minimal value. */
    func getMinKey() -> String {
        guard let last = list.getLast(), let _ = last.key else {
            return ""
        }
        
        guard let minKey = last.value?.first else {
            return ""
        }
        
        return minKey
    }
}

let a = AllOne()
//a.inc("hello")
//a.inc("goodbye")
//a.inc("hello")
//a.inc("hello")
//a.getMaxKey()
//a.inc("leet")
//a.inc("code")
//a.inc("leet")
//a.dec("hello")
//a.inc("leet")
//a.inc("code")
//a.inc("code")
a.inc("a")
a.inc("b")
a.inc("b")
a.inc("b")
a.inc("b")
a.inc("b")
a.dec("b")
//a.dec("b")
a.getMaxKey()


//x 的平方根
//实现 int sqrt(int x) 函数。
//
//计算并返回 x 的平方根，其中 x 是非负整数。
//
//由于返回类型是整数，结果只保留整数的部分，小数部分将被舍去。
//
//示例 1:
//
//输入: 4
//输出: 2
//示例 2:
//
//输入: 8
//输出: 2
//说明: 8 的平方根是 2.82842...,
//     由于返回类型是整数，小数部分将被舍去。
func mySqrt(_ x: Int) -> Int {
    func SqrtFor(_ x: Int, _ start: Int, end: Int) -> Int {
        if end - start == 1 {
            return start
        }
        let mid = start + (end - start) / 2
        let multiply = mid * mid
        if multiply == x {
            return mid
        } else if multiply > x {
            return SqrtFor(x, start, end: mid)
        } else {
            return SqrtFor(x, mid, end: end)
        }
    }
    
    if x == 0 {
        return 0
    }
    if x == 1 {
        return 1
    }
    return SqrtFor(x, 0, end: x)
}

mySqrt(2)


//UTF-8 编码验证
//UTF-8 中的一个字符可能的长度为 1 到 4 字节，遵循以下的规则：
//
//对于 1 字节的字符，字节的第一位设为0，后面7位为这个符号的unicode码。
//对于 n 字节的字符 (n > 1)，第一个字节的前 n 位都设为1，第 n+1 位设为0，后面字节的前两位一律设为10。剩下的没有提及的二进制位，全部为这个符号的unicode码。
//这是 UTF-8 编码的工作方式：
//
//   Char. number range  |        UTF-8 octet sequence
//      (hexadecimal)    |              (binary)
//   --------------------+---------------------------------------------
//   0000 0000-0000 007F | 0xxxxxxx
//   0000 0080-0000 07FF | 110xxxxx 10xxxxxx
//   0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
//   0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
//给定一个表示数据的整数数组，返回它是否为有效的 utf-8 编码。
//
//注意:
//输入是整数数组。只有每个整数的最低 8 个有效位用来存储数据。这意味着每个整数只表示 1 字节的数据。
//
//示例 1:
//
//data = [197, 130, 1], 表示 8 位的序列: 11000101 10000010 00000001.
//
//返回 true 。
//这是有效的 utf-8 编码，为一个2字节字符，跟着一个1字节字符。
func validUtf8(_ data: [Int]) -> Bool {
    var count = 0
    for d in data {
        if count == 0 {
            if (d >> 5) == 0b110 { count = 1 }
            else if (d >> 4) == 0b1110 { count = 2 }
            else if (d >> 3) == 0b11110 { count = 3 }
            else if (d >> 7) == 1 { return false }
        } else {
            if (d >> 6) != 0b10 { return false }
            count -= 1
        }
    }
    
    return count == 0
}
