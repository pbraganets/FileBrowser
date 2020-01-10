//
//  FileTypesSetup.swift
//  FileBrowser
//
//  Created by Pavel B on 05.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class FileTypesSetup: FileVisitor {
    func visitTextFile(_ fp: File) {
        fp.addExtension(FilePropertiesSize(fp.filePath))
        fp.addExtension(FilePropertiesTextLength(fp.filePath))
    }
    
    func visitAudioFile(_ fp: File) {
        fp.addExtension(FilePropertiesSize(fp.filePath))
        fp.addExtension(FilePropertiesAudioDuration(fp.filePath))
    }
    
    func visitVideoFile(_ fp: File) {
        fp.addExtension(FilePropertiesSize(fp.filePath))
        fp.addExtension(FilePropertiesVideoDuration(fp.filePath))
    }
    
    func visitFileGroup(_ fp: FileGroup) {
        fp.addExtension(FileGroupPropertiesSize(fp))
        fp.addExtension(FileGroupPropertiesCountExtension(fp))
    }
    
}
