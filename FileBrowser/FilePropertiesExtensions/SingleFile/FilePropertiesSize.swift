//
//  FilePropertiesSize.swift
//  FileBrowser
//
//  Created by Pavel B on 05.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class FilePropertiesSize: FilePropertiesSizeExtension {

    // MARK: - Private properties
    
    private let filePath: String?
    
    // MARK: - Size extension
    
    var bytes: UInt64? {
        if let filePath = filePath {
            return fileSize(filePath)
        } else {
            return nil
        }
    }
    
    // MARK: - Lifecycle
    
    init(_ filePath: String? = nil) {
        self.filePath = filePath
    }
    
}
