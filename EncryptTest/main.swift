//
//  main.swift
//  EncryptTest
//
//  Created by Roicxy Alonso on 12/15/17.
//  Copyright © 2017 Roicxy Alonso. All rights reserved.
//

import Foundation

//print("Hello, World!")

var ele = MessageHandler()

var newMsg = ele.encry(Message: "Hello You")
var ReMsg = ele.decry(Message: newMsg)


print (newMsg)


