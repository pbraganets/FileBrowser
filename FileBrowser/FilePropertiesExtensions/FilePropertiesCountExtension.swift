//
//  FilePropertiesCountExtension.swift
//  FileBrowser
//
//  Created by Pavel B on 10.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


protocol FilePropertiesCountExtension: FilePropertiesExtension {
    var count: Int? { get }
}

extension FilePropertiesCountExtension {
    var extensionName: String {
        return Self.extensionName
    }
    
    static var extensionName: String {
        return String(describing:FilePropertiesCountExtension.self)
    }
    
}
