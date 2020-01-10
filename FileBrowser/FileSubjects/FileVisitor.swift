//
//  FileVisitor.swift
//  FileBrowser
//
//  Created by Pavel B on 10.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


protocol FileVisitor {
    func visitTextFile(_ fp: File)
    func visitAudioFile(_ fp: File)
    func visitVideoFile(_ fp: File)
    func visitFileGroup(_ fp: FileGroup)
}


protocol FileVisitorAcceptor {
    func visit(_ fp: FileVisitor)
}
