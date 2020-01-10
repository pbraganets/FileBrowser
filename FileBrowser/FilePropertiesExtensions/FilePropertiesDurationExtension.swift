//
//  FilePropertiesDurationExtension.swift
//  FileBrowser
//
//  Created by Pavel B on 08.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


protocol FilePropertiesDurationExtension: FilePropertiesExtension {
    var duration: TimeInterval? { get }
    func calculateDuration(_ completion: @escaping (TimeInterval?) -> Void)
}

extension FilePropertiesDurationExtension {
    var extensionName: String {
        return Self.extensionName
    }
    
    static var extensionName: String {
        return String(describing:FilePropertiesDurationExtension.self)
    }
    
    func calculateDuration(_ completion: @escaping (TimeInterval?) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            sleep(2)
            completion(self.duration)
        }
    }
    
}
