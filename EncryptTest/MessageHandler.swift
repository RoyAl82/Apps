//
//  MessageHandler.swift
//  EncryptTest
//
//  Created by Roicxy Alonso on 12/15/17.
//  Copyright © 2017 Roicxy Alonso. All rights reserved.
//

import Cocoa

class MessageHandler: NSObject {
    
    private var seed: Int
    
    override init()
    {
        self.seed = Int(NSDate.timeIntervalSinceReferenceDate)
    }
    
    
    private func randCode() -> UInt32 {
        
        var randValue = arc4random()
        return UInt32(randValue)
    }
    
    func encry(Message: String) -> String {
        var msgEncrypt: String = ""
        seed = Int(NSDate.timeIntervalSinceReferenceDate)
        srand48(seed)
        
        print(seed)
        print(String(seed).count)
        
        var binC: UInt32 = 0b0
        var bin: UInt8 = 0b0
        var count = 0
        
        for i in Message.utf8{
            
            if count == 4
            {
                print(msgEncrypt)
                //msgEncrypt = msgEncrypt << 32
                print(msgEncrypt)
                print(UINT32_MAX)
                //var temp = binC + randCode()
                //print(temp)
                msgEncrypt.append( String(binC + randCode()))
                print(msgEncrypt)
                binC = 0b0
                bin = 0b0
                count = 0
            }
            
            bin = UInt8(i)
            print(bin)
            binC = binC << 8
            print(binC)
            binC = binC + UInt32(bin)
            print(binC)
            count += 1
            
            //msgEncrypt
            
            print(msgEncrypt)
        }
        
        if binC.nonzeroBitCount > 1
        {
            //var temp = binC + randCode()
            //print(temp)
            msgEncrypt.append( String(binC + randCode()))
            print(msgEncrypt)
            binC = 0b0
            bin = 0b0
            count = 0
        }
        let index = Int(sqrt(Double(msgEncrypt.count)))
        
        let index2 = msgEncrypt.index(msgEncrypt.startIndex, offsetBy: index)
        msgEncrypt.insert(contentsOf: String(seed), at: msgEncrypt.index(before: index2))
        //msgEncrypt.index(after: String.Index(index)).append(String(seed))
        
        print(msgEncrypt)
        //return Message
        return msgEncrypt
    }

    func decry(Message: String) -> String {
        var message = Message
        let num = String(seed).count
        let lenght = Message.count - num
        let index = Int(sqrt(Double(lenght)))
        let num1 = Message.index(Message.startIndex, offsetBy: num)
        let index2 = Message.index(Message.startIndex, offsetBy: (index - 1))
        let seed1S = String(Message[index2...])
        let seedS = String(seed1S[..<num1])
        
        
        seed = Int(seedS)!
        message.removeSubrange(index2..<num1)
        print(seed)
        
        return " "
    }
}
