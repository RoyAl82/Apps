//
//  MessageHandler.swift
//  EncryptTest
//
//  Created by Roicxy Alonso on 12/15/17.
//  Copyright © 2017 Roicxy Alonso. All rights reserved.
//


//import Cocoa

class MessageHandler: NSObject {
    
    private var seed: UInt
    
    override init()
    {
        self.seed = UInt(NSDate.timeIntervalSinceReferenceDate)
    }
    
    private func randCode() -> UInt64 {
        
        
        var randValue = UInt32(EncryptM.randomN(Double(UINT64_MAX) / 1.8))
        
        var val = UInt64(UInt64(randValue) | (UInt64(randValue) << 32))
        
        while(true)
        {
            if(String(val).count >= 13)
            {
                return val
            }
            else
            {
                randValue = UInt32(EncryptM.randomN(Double(UINT64_MAX) / 1.8))
                
                val = UInt64(UInt64(randValue) | (UInt64(randValue) << 32))
            }
        }
        
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
                msgEncrypt.append( String(UInt64(binC ^ randCode())))
                
                binC = 0b0
                bin = 0b0
                count = 0
            }
            
            bin = UInt32(i.value)
            
            binC = binC << 32
            
            binC = binC | UInt64(bin)
            
            count += 1
            
        }
        
        if binC.nonzeroBitCount > 0
        {
            msgEncrypt.append( String(binC ^ randCode()))
            
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
        
        let index = Int(sqrt(Double(Message.count - num))) - 1
        let indexSE2 = Message.index(Message.startIndex, offsetBy: num)
        let indexSER = Message.index(Message.startIndex, offsetBy: index)
        
        let indexSR2 = Message.index(Message.startIndex, offsetBy: (index + num))
        
        let seed1S = String(Message[indexSER...])
        let seedS = String(seed1S[..<indexSE2])
        seed = UInt(seedS)!
        
        EncryptM.sRandom(UInt32(seed))
        message.removeSubrange(indexSER..<indexSR2)
        
        var ran = randCode()
        var numIndex = String(ran).count
        var indexDM: String.Index = message.startIndex
        
        var strVal: String = ""
        var DM = message
        
        while DM.count > numIndex
        {
            
            let indexPDM = indexDM
            indexDM = DM.index(DM.startIndex, offsetBy: ((numIndex)))
            DM = String(DM[indexPDM...])
            let firstDM = String(DM[..<indexDM])
            
            let secDM = UInt64(firstDM)
            
            let forthDM = secDM! ^ ran
            let firstV = UInt32(forthDM & 0xFFFFFFFF)
            let secondV = UInt32(forthDM >> 32)
            
            strVal.append(String(UnicodeScalar(UInt32(secondV))!))
            strVal.append(String(UnicodeScalar(UInt32(firstV))!))
            
            ran = randCode()
            numIndex = String(ran).count
        
        }
        
        return strVal
    }
}
