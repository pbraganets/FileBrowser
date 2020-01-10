//
//  FilePropertiesBaseFilter.swift
//  FileBrowser
//
//  Created by Pavel B on 08.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class FilePropertiesBaseFilter: FilePropertiesFilter {
    
    // MARK: - Private properties
    
    private var wrappee: FilePropertiesFilter?
    
    // MARK: - Lifecycle
    
    init(_ wrappee: FilePropertiesFilter? = nil) {
        self.wrappee = wrappee
    }
    
    // MARK: - File properties filter
    
    func filter(_ fileProperties: [File], completion: @escaping ([File]?) -> Void) {
        if let wrappee = wrappee {
            wrappee.filter(fileProperties, completion: completion)
        } else {
            completion(fileProperties)
        }
    }
    
    func cancel() {
    }
    
}
