//
//  FilePropertiesTextLengthExtension.swift
//  FileBrowser
//
//  Created by Pavel B on 10.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


protocol FilePropertiesTextLengthExtension: FilePropertiesExtension {
    var textLenght: Int? { get }
}

extension FilePropertiesTextLengthExtension {
    var extensionName: String {
        return Self.extensionName
    }
    
    static var extensionName: String {
        return String(describing:FilePropertiesTextLengthExtension.self)
    }
    
}
