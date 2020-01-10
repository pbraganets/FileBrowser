//
//  FileSubject.swift
//  FileBrowser
//
//  Created by Pavel B on 05.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


protocol FileDataSource {
    var filePath: String { get }
}


protocol FileGroupDataSource {
    var fileProperties: [FileDataSource]? { get }
}


class FileBaseSubject: FileVisitorAcceptor {
    
    // MARK: - Private properties
    
    private var extensions: [String: FilePropertiesExtension] = [:]
    
    // MARK: - Public implementation
    
    func addExtension(_ filePropertiesExtension: FilePropertiesExtension) {
        extensions[filePropertiesExtension.extensionName] = filePropertiesExtension
    }
    
    /*
     *    func `extension`<T: FilePropertiesExtension>(_ filePropExtensionType: T.Type) -> T? {
     *        return extensions[filePropExtensionType.extentionName]
     *    }
     *
     * unfortunatelly such signature cannot be used
     * due to `... only concrete types can conform to protocols`
     *
     * it also brings some troubles in determining extension name
     * by clients: f.e. String(describing:FilePropertiesBytesExtension.self)) instead of FilePropertiesBytesExtension.self
     *
     *
     */
    func `extension`(_ extensionName: String) -> FilePropertiesExtension? {
        return extensions[extensionName]
    }
    
    // MARK: - File visitor
    
    func visit(_ fv: FileVisitor) {
    }
    
}
