import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        
        var result = message, isChangedKey = false
        while true{
            
            var currentCount = "", level = 0, newString = "", currentString = "", globalKey = 0, i = 0
            for character in result{
                if character >= "0" && character <= "9" && level == 0{ currentCount += String(character)}
                else if character >= "0" && character <= "9" && level == 1{
                    currentCount = String(character)
                    currentString = ""
                    level = 0
                }
                else if character == "[" && level == 1{
                    currentCount = ""
                    currentString = ""
                }
                else if character == "[" && level == 0 {level = 1}
                else if character == "]"{
                    newString = String(result.prefix(i - currentCount.count - 1 - currentString.count))
                    var cicleCount:Int? = Int(currentCount)
                    if currentCount.count == 0 {cicleCount = 1}
                    if cicleCount ?? 0 > 0{
                        for i in 1...(cicleCount ?? 0){
                            newString += currentString
                        }
                    }
                    newString += String(result.suffix(result.count - i - 1))
                    globalKey = 1
                    isChangedKey = true
                    break
                }
                else if level == 1 { currentString += String(character)}
                i += 1
            }
            if globalKey == 0 { break }
            result = newString
        }
        
        if (isChangedKey){return result}
        else {return message}
        
    }
}

