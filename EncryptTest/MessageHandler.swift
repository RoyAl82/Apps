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
    
    
    private func randCode() -> UInt64 {
        
        var randValue = arc4random()
        return UInt64(randValue)
    }
    
    func encry(Message: String) -> UInt64 {
        let msgEncrypt: UInt64
        seed = Int(NSDate.timeIntervalSinceReferenceDate)
        srand48(seed)
        
        print(seed)
        var binC: UInt16
        var bin: UInt16
        var count = 0
        
        for i in Message.utf16{
            
            if count == 3
            {
                print(msgEncrypt)
                msgEncrypt = msgEncrypt << 32
                print(msgEncrypt)
                temp = binC + randCode()
                print(temp)
                msgEncrypt + temp
                print(msgEncrypt)
                binC = 0b0
                bin = 0b0
                count = 0
                
                
            }
            
            bin = i.byteSwapped
            print(bin)
            binC << 16
            print(binC)
            binC = binC + bin
            print(binC)
            count += 1
            
            //msgEncrypt
            
            print(msgEncrypt)
        }
        
        //return Message
        return msgEncrypt
    }

}
