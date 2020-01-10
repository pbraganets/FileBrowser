//
//  FilePropertiesSizeExtension.swift
//  FileBrowser
//
//  Created by Pavel B on 07.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation

protocol FilePropertiesSizeExtension: FilePropertiesExtension {
    var bytes: UInt64? { get }
}

extension FilePropertiesSizeExtension {
    var extensionName: String {
        return Self.extensionName
    }
    
    static var extensionName: String {
        return String(describing:FilePropertiesSizeExtension.self)
    }
    
    func fileSize(_ filePath: String) -> UInt64? {
        let fileAttribute: [FileAttributeKey : Any]? = try? FileManager.default.attributesOfItem(atPath: filePath)

        if let fileNumberSize = fileAttribute?[FileAttributeKey.size] as? NSNumber {
             return UInt64(truncating: fileNumberSize)
        }
        
        return nil
    }
    
}
