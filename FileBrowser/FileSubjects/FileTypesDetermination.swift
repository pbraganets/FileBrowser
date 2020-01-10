//
//  FileTypesDetermination.swift
//  FileBrowser
//
//  Created by Pavel B on 10.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation
import MobileCoreServices


protocol FileTypesDetermination {
    func fileType(_ filePath: String) -> Unmanaged<CFString>?
}


class FileTypes: FileTypesDetermination {
    func fileType(_ filePath: String) -> Unmanaged<CFString>? {
        let ext = NSURL(fileURLWithPath: filePath).pathExtension
        return UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, ext! as CFString, nil)
    }
}
