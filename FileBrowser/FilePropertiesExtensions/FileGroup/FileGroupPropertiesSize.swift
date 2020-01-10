//
//  FileGroupPropertiesSize.swift
//  FileBrowser
//
//  Created by Pavel B on 07.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class FileGroupPropertiesSize: FilePropertiesSizeExtension {
    
    // MARK: - Private implementation
    
    private let filePath: [String]?
    
    // MARK: - Size extension
    
    var bytes: UInt64? {
        return filePath?.reduce(0, { result, filePath in
            result + (FilePropertiesSize(filePath).bytes ?? 0)
        })
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
