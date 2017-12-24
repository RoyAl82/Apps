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
    
    
    private func randCode() -> Int {
        
        var randValue = arc4random()
        return Int(randValue)
    }
    
    func encry(Message: String) -> String.UTF16View {
        var msgEncrypt: String.UTF16View = ""
        seed = Int(NSDate.timeIntervalSinceReferenceDate)
        srand48(seed)
        
        print(seed)
        for i in Message.utf16{
            
            //msgEncrypt.append(String( Int(i) + randCode()))
            //msgEncrypt
            
            print(msgEncrypt)
        }
        
        //return Message
        return msgEncrypt
    }

}
