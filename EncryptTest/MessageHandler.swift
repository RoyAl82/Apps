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
                var temp = binC + randCode()
                print(temp)
                msgEncrypt.append( String(temp))
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
            var temp = binC + randCode()
            print(temp)
            msgEncrypt.append( String(temp))
            print(msgEncrypt)
            binC = 0b0
            bin = 0b0
            count = 0
        }
        //return Message
        return msgEncrypt
    }

}
