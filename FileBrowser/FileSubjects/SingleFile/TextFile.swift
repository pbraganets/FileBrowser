//
//  TextFile.swift
//  FileBrowser
//
//  Created by Pavel B on 05.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class TextFile: File {
    
    // MARK: - File visitor
    
    override func visit(_ fv: FileVisitor) {
        fv.visitTextFile(self)
    }
    
}
