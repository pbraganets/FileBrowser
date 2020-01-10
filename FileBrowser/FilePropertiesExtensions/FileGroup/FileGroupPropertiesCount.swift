//
//  FileGroupPropertiesCount.swift
//  FileBrowser
//
//  Created by Pavel B on 07.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class FileGroupPropertiesCountExtension: FilePropertiesCountExtension {
    
    // MARK: - Private implementation
    
    private let filePath: [String]?
    
    // MARK: - Count extension
    
    var count: Int? {
        return filePath?.count
    }
    
    // MARK: - Lifecycle
    
    init(_ dataSource: FileGroupDataSource) {
        if let filePropertiesDataSources: [FileDataSource] = dataSource.fileProperties {
            filePath = filePropertiesDataSources.map { $0.filePath }
        } else {
            filePath = nil
        }
    }
    
}
