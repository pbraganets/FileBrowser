//
//  AudioFile.swift
//  FileBrowser
//
//  Created by Pavel B on 07.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class AudioFile: File {
    
    // MARK: - File visitor
    
    override func visit(_ fv: FileVisitor) {
        fv.visitAudioFile(self)
    }
    
}
