//
//  FilePropertiesExtension.swift
//  FileBrowser
//
//  Created by Pavel B on 05.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


protocol FilePropertiesExtension {
    
    /*
    * due to Swift limitations per protocol inheritance
    * extension name determination is a bit weird
    *
    */
    var extensionName: String { get }
    static var extensionName: String { get }
}
