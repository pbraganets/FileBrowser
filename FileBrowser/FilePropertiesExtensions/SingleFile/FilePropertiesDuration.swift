//
//  FilePropertiesDuration.swift
//  FileBrowser
//
//  Created by Pavel B on 10.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class FilePropertiesAudioDuration: FilePropertiesDurationExtension {
    
    // MARK: - Private properties
    
    private let filePath: String?
    
    // MARK: - Duration extension
    
    var duration: TimeInterval? {
        if let filePath = filePath {
            return Double(((filePath as NSString).lastPathComponent as NSString).deletingPathExtension)
        } else {
            return nil
        }
    }
    
    // MARK: - Lifecycle
    
    init(_ filePath: String? = nil) {
        self.filePath = filePath
    }
    
}


class FilePropertiesVideoDuration: FilePropertiesDurationExtension {
    
    // MARK: - Private properties
    
    private let filePath: String?
    
    // MARK: - Duration extension
    
    var duration: TimeInterval? {
        if let filePath = filePath {
            return Double(((filePath as NSString).lastPathComponent as NSString).deletingPathExtension)
        } else {
            return nil
        }
    }
    
    // MARK: - Lifecycle
    
    init(_ filePath: String? = nil) {
        self.filePath = filePath
    }
    
}
