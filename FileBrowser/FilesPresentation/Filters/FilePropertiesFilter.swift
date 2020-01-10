//
//  FilePropertiesFilter.swift
//  FileBrowser
//
//  Created by Pavel B on 08.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation

protocol FilePropertiesFilter {
    func filter(_ fileProperties: [File], completion: @escaping ([File]?) -> Void)
    func cancel()
}
