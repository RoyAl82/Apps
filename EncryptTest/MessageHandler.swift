//
//  MessageHandler.swift
//  EncryptTest
//
//  Created by Roicxy Alonso on 12/15/17.
//  Copyright © 2017 Roicxy Alonso. All rights reserved.
//


import Cocoa

class MessageHandler: NSObject {
    
    private var seed: UInt
    
    override init()
    {
        self.seed = UInt(NSDate.timeIntervalSinceReferenceDate)
    }
    
    private func randCode() -> UInt64 {
        
        
        let randValue = EncryptM.random()
        
        let val = UInt64(UInt64(randValue) | (UInt64(randValue) << 32))
        
        return val
    }
    
    func encry(Message: String) -> String {
        var msgEncrypt: String = ""
        seed = UInt(NSDate.timeIntervalSinceReferenceDate)
        
        EncryptM.sRandom(UInt32(seed))
        
        var binC: UInt64 = 0b0
        var bin: UInt32 = 0b0
        var count = 0
        
        for i in Message.unicodeScalars{
            
            if count == 2
            {
                let ran = UInt64(randCode())
                msgEncrypt.append( String(binC + ran))
                
                binC = 0b0
                bin = 0b0
                count = 0
            }
            
            bin = UInt32(i.value)
            
            binC = binC << 32
            
            binC = binC + UInt64(bin)
            
            count += 1
            
        }
        
        if binC.nonzeroBitCount > 1
        {
            msgEncrypt.append( String(binC + randCode()))
            
            binC = 0b0
            bin = 0b0
            count = 0
        }
        let index = Int(sqrt(Double(msgEncrypt.count)))
        
        let index2 = msgEncrypt.index(msgEncrypt.startIndex, offsetBy: index)
        msgEncrypt.insert(contentsOf: String(seed), at: msgEncrypt.index(before: index2))
        
        return msgEncrypt
    }

    func decry(Message: String) -> String {
        var message = Message
        let num = String(seed).count
        let lenght = Message.count - num
        let index = Int(sqrt(Double(lenght))) - 1
        let indexSE2 = Message.index(Message.startIndex, offsetBy: num)
        let indexSER = Message.index(Message.startIndex, offsetBy: index)
        
        let indexSR2 = Message.index(Message.startIndex, offsetBy: (index + num))
        
        let seed1S = String(Message[indexSER...])
        let seedS = String(seed1S[..<indexSE2])
        seed = UInt(seedS)!
        
        EncryptM.sRandom(UInt32(seed))
        message.removeSubrange(indexSER..<indexSR2)
        
        
        let dig = String(UINT64_MAX)
        let numIndex = dig.count
        var indexDM: String.Index = message.startIndex
        
        var strVal: String = ""
        var DM = message
        
        while DM.count > numIndex
        {
            
            let indexPDM = indexDM
            indexDM = DM.index(DM.startIndex, offsetBy: ((numIndex)  - 1))
            DM = String(DM[indexPDM...])
            let firstDM = String(DM[..<indexDM])
            
            let secDM = UInt64(firstDM)
            
            let ran = randCode()
            
            let thirdDM = secDM! - ran
            let forthDM = UInt64(thirdDM)
            let firstV = forthDM & 0xFFFF
            let secondV = forthDM >> 32
            
            strVal.append(String(UnicodeScalar(UInt32(secondV))!))
            strVal.append(String(UnicodeScalar(UInt32(firstV))!))
        
        }
        
        return strVal
    }
}
