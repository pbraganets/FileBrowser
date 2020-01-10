//
//  File.swift
//  FileBrowser
//
//  Created by Pavel B on 07.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class File: FileBaseSubject, FileDataSource {
    
    // MARK: = File data source
    
    let filePath: String
    
    // MARK: - Lifecycel
    
    init(_ filePath: String) {
        self.filePath = filePath
    }
    
}
