//
//  FileGroup.swift
//  FileBrowser
//
//  Created by Pavel B on 07.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation

class FileGroup: FileBaseSubject, FileGroupDataSource {
    
    // MARK: - Private properties
    
    private let file: [File]?
    
    // MARK: - File group data source
    var fileProperties: [FileDataSource]? {
        return file
    }
    
    // MARK: - Lifecycle
    
    init(_ file: [File]) {
        self.file = file
    }
    
    // MARK: - File visitor
    
    override func visit(_ fv: FileVisitor) {
        fv.visitFileGroup(self)
    }
    
}
