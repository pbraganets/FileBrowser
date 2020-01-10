//
//  FilePropertiesTypeFilter.swift
//  FileBrowser
//
//  Created by Pavel B on 10.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class FilePropertiesTypeFilter: FilePropertiesBaseFilter {
    
    // MARK: - Public properties
    
    var validator: ((File.Type) -> Bool)?
    
    // MARK: - File properties filter
    
    override func filter(_ files: [File],
                         completion: @escaping ([File]?) -> Void)
    {
        var filteredFiles = [File]()
        if let validator = validator {
            for file in files {
                if validator(type(of: file)) {
                    filteredFiles.append(file)
                }
            }
        }
        
        if filteredFiles.count > 0 {
            super.filter(filteredFiles, completion: completion)
        } else {
            completion(nil)
        }
    }
    
}
