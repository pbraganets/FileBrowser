//
//  FileFactory.swift
//  FileBrowser
//
//  Created by Pavel B on 05.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation
import MobileCoreServices


class FileFactory {
    
    // MARK: - Public properties
    
    var setup: FileVisitor = FileTypesSetup()
    var fileTypes: FileTypesDetermination = FileTypes()

    // MARK: - Public implementation
    
    func makeFile(_ filePath: String) -> File? {
        var file: File? = nil
        if let fileType = fileTypes.fileType(filePath)?.takeRetainedValue() {
            if UTTypeConformsTo(fileType, kUTTypeText) {
                file = makeTextFile(filePath)
            } else if UTTypeConformsTo(fileType, kUTTypeAudio) {
                file = makeAudioFile(filePath)
            } else if UTTypeConformsTo(fileType, kUTTypeVideo) ||
                UTTypeConformsTo(fileType, kUTTypeMPEG4) ||
                UTTypeConformsTo(fileType, kUTTypeMovie)
            {
                file = makeVideoFile(filePath)
            }
        }
        return file
    }
    
    func makeFileGroup(filePaths: [String]) -> FileGroup? {
        var files = [File]()
        for path in filePaths {
            if let file = makeFile(path) {
                files.append(file)
            }
        }
        return (files.count > 0) ? makeFileGroup(files: files) : nil
    }
    
    func makeTextFile(_ filePath: String) -> TextFile {
        let file = TextFile(filePath)
        file.visit(setup)
        return file
    }
    
    func makeAudioFile(_ filePath: String) -> AudioFile {
        let file = AudioFile(filePath)
        file.visit(setup)
        return file
    }
    
    func makeVideoFile(_ filePath: String) -> VideoFile {
        let file = VideoFile(filePath)
        file.visit(setup)
        return file
    }
    
    func makeFileGroup(files: [File]) -> FileGroup {
        let file = FileGroup(files)
        file.visit(setup)
        return file
    }
    
}
