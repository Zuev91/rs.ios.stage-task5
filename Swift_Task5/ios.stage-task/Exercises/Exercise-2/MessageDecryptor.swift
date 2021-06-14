import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        
        if message.isEmpty {
            return ""
        }
        
        if !(1 ... 60 ~= message.count) {
            return ""
        }
        
        var str = Array(message)

        var countOfComas = 0

        for i in str {
            if i == "]" {
                countOfComas += 1
            }
        }

        while (countOfComas > 0) {
            
            var str2 = Array<Character>()
            var endPosition = 0
            var startPosition = 0
            var count: Int? = 0

            while (str[endPosition] != "]") {
                endPosition += 1
            }

            for i in stride(from: endPosition, to: 0, by: -1) {
                if str[i] == "[" {
                    startPosition = i
                    break
                }
            }
            
            if startPosition == 0 {
                
                str.removeFirst()
                str.removeLast()
                countOfComas -= 1
                
            } else {
                var tmp = 1
            
                if Int(String(str[startPosition - 1])) == nil {
                    str.insert("1", at: startPosition)
                }
                
                for i in stride(from: startPosition - 2, to: 0, by: -1) {
                    if Int(String(str[i])) != nil {
                        tmp += 1
                    } else {
                        break
                    }
                }
                
                switch tmp {
                case 1: count = Int(String(str[startPosition - 1]))
                case 2: count = 10 * Int(String(str[startPosition - 2]))! + Int(String(str[startPosition - 1]))!
                case 3: count = 100 * Int(String(str[startPosition - 3]))! + 10 * Int(String(str[startPosition - 2]))! + Int(String(str[startPosition - 1]))!
                default:
                    fatalError("number is not expected")
                }
            
                while count != 0 {
                
                    for i in stride(from: startPosition + 1, to: endPosition, by: 1) {
                        str2.append(str[i])
                    }
                    count! -= 1
                }

                str.removeSubrange(startPosition - tmp ... endPosition)
                str.insert(contentsOf: str2, at: startPosition - tmp)
                countOfComas -= 1
            }
        }
        return String(str)
    }
}
