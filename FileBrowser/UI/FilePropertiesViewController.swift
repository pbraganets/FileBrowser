//
//  FilePropertiesViewController.swift
//  FileBrowser
//
//  Created by Pavel B on 23.12.2019.
//  Copyright © 2019 Pavel B. All rights reserved.
//

import UIKit


class FilePropertiesViewController: UIViewController, FileVisitor {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var sizeLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var textLengthLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    // MARK: - Public properties
    
    var fileProperties: FileBaseSubject? {
        didSet {
            setupPlaceholders()
            fileProperties?.visit(self)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // durty hack to access and modify split view controller
        splitViewController?.preferredDisplayMode = .allVisible
    }
    
    // MARK: - File visitor
    
    func visitTextFile(_ file: File) {
        countLabel.text = "1"
        
        let bytesExt: FilePropertiesSizeExtension? = file.extension(String(describing:FilePropertiesSizeExtension.self)) as? FilePropertiesSizeExtension
        if let bytes = bytesExt?.bytes {
            sizeLabel.text = "\(bytes) bytes"
        }
        
        let textLengthExt: FilePropertiesTextLengthExtension? = file.extension(String(describing:FilePropertiesTextLengthExtension.self)) as? FilePropertiesTextLengthExtension
        if let textLength = textLengthExt?.textLenght {
            textLengthLabel.text = "\(textLength) symbol(s)"
        }
    }
    
    func visitAudioFile(_ file: File) {
        countLabel.text = "1"
        
        let bytesExt: FilePropertiesSizeExtension? = file.extension(String(describing:FilePropertiesSizeExtension.self)) as? FilePropertiesSizeExtension
        if let bytes = bytesExt?.bytes {
            sizeLabel.text = "\(bytes) bytes"
        }
        
        let durationExt: FilePropertiesDurationExtension? = file.extension(String(describing:FilePropertiesDurationExtension.self)) as? FilePropertiesDurationExtension
        if let duration = durationExt?.duration {
            durationLabel.text = "\(duration) second(s)"
        }
    }
    
    func visitVideoFile(_ file: File) {
        countLabel.text = "1"
        
        let bytesExt: FilePropertiesSizeExtension? = file.extension(String(describing:FilePropertiesSizeExtension.self)) as? FilePropertiesSizeExtension
        if let bytes = bytesExt?.bytes {
            sizeLabel.text = "\(bytes) bytes"
        }
        
        let durationExt: FilePropertiesDurationExtension? = file.extension(String(describing:FilePropertiesDurationExtension.self)) as? FilePropertiesDurationExtension
        let filePropertiesReference = fileProperties
        durationExt?.calculateDuration({ (duration) in
            if let duration = duration {
                DispatchQueue.main.async {
                    if filePropertiesReference === self.fileProperties {
                        self.durationLabel.text = "\(duration) second(s)"
                    }
                }
            }
        })
    }
    
    func visitFileGroup(_ fileGroup: FileGroup) {
        let textLeghtExt = fileGroup.extension(String(describing:FilePropertiesCountExtension.self)) as? FilePropertiesCountExtension
        if let count = textLeghtExt?.count {
            countLabel.text = "\(count)"
        }
        
        let bytesExt: FilePropertiesSizeExtension? = fileGroup.extension(String(describing:FilePropertiesSizeExtension.self)) as? FilePropertiesSizeExtension
        if let bytes = bytesExt?.bytes {
            sizeLabel.text = "\(bytes) bytes"
        }
    }
    
    // MARK: - Private implementation
    
    private func setupPlaceholders() {
        countLabel.text = ""
        sizeLabel.text = ""
        typeLabel.text = ""
        textLengthLabel.text = ""
        durationLabel.text = ""
    }
    
}
