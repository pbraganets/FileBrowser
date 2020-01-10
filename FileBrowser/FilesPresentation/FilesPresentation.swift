//
//  FilesPresentation.swift
//  FileBrowser
//
//  Created by Pavel B on 10.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation
import Combine


class FilesPresentation {
    
    // MARK: - Public properties
    
    @Published private(set) var presentation: [File]? {
        didSet {
            isProcessing = false
        }
    }
    @Published private(set) var isProcessing: Bool = false
    
    var files: [File]? {
        didSet {
            updatePresentation()
        }
    }
    var filter: FilePropertiesBaseFilter? {
        willSet {
            filter?.cancel()
        }
        didSet {
            updatePresentation()
        }
    }
    
    // MARK: - Private implementation
    
    private func updatePresentation() {
        if filter != nil {
            isProcessing = true
            if let files = files {
                let filterRef = self.filter
                filter?.filter(files, completion: { [weak self] (files) in
                    guard let self = self else {
                        return
                    }
                    if filterRef === self.filter {
                        self.presentation = files
                    }
                })
            }
        } else {
            presentation = files
        }
    }
    
}
