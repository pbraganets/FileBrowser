//
//  FilePropertiesTextLength.swift
//  FileBrowser
//
//  Created by Pavel B on 05.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class FilePropertiesTextLength: FilePropertiesTextLengthExtension {
    
    // MARK: - Private properties
    
    private let filePath: String?
    
    // MARK: - Text length extension
    
    var textLenght: Int? {
        if let filePath = filePath {
            let contents = try! String(contentsOfFile: filePath)
            return contents.count
        } else {
            return nil
        }
    }
    
    // MARK: - Lifecycle
    
    init(_ filePath: String? = nil) {
        self.filePath = filePath
    }
    
}
