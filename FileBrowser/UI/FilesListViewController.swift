//
//  FilesListViewController.swift
//  FileBrowser
//
//  Created by Pavel B on 23.12.2019.
//  Copyright © 2019 Pavel B. All rights reserved.
//

import UIKit
import MobileCoreServices
import Combine


class FilesListViewController: UITableViewController, UIDocumentPickerDelegate {
    
    // MARK: - Private properties
    
    private var cancellables = Set<AnyCancellable>()
    private var selectedURLs = Set<URL>()
    
    // fileURLs as URL is legacy :(, filePaths ([String]) may be used instead or even files ([File])
    private var fileURLs: [URL]? {
        didSet {
            selectedURLs.removeAll()
            processSelected()
            
            tableView.reloadData()
        }
    }
    
    private var currentFilter: FilePropertiesBaseFilter? {
        var filter: FilePropertiesBaseFilter?
        let multiselect = navigationItem.leftBarButtonItem?.customView as! MultiSelectSegmentedControl
        if multiselect.selectedSegmentIndexes.contains(IndexSet.Element(0)) {
            let durationFilter = FilePropertiesDurationFilter(filter)
            durationFilter.validator = { (duration) -> Bool in
                guard let duration = duration else {
                    return false
                }
                
                return duration < 60.0
            }
            filter = durationFilter
        }
        
        if multiselect.selectedSegmentIndexes.contains(IndexSet.Element(1)) {
            let typeFilter = FilePropertiesTypeFilter(filter)
            typeFilter.validator = { (type) -> Bool in
                return (type == AudioFile.self)
            }
            filter = typeFilter
        }
        return filter
    }
    
    private var fileFactory: FileFactory = {
        let fileFactory = FileFactory()
        
        /*
        * here custom setup and file types can be injected
        * in case of adding new file types and extensions
        * or chaning the approach of determining file types
        */
        //fileFactory.setup = FileTypesSetup()
        //fileFactory.fileTypes = FileTypes()
        
        return fileFactory
    }()
    
    private lazy var filesPresentation: FilesPresentation = {
        let filesPresentation = FilesPresentation()
        filesPresentation.$presentation
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (files) in
                self.fileURLs = files?.map( { URL(fileURLWithPath: $0.filePath) } ).sorted(by: { (f, s) -> Bool in
                    return f.path < s.path
                })
            })
            .store(in: &cancellables)
        
        filesPresentation.$isProcessing
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: { (isProcessing) in
            self.updateUI()
        })
        .store(in: &cancellables)
        
        return filesPresentation
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let multiSelect = MultiSelectSegmentedControl()
        multiSelect.items = ["< 1m", "♫"]
        multiSelect.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: multiSelect)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Scan...", style: .plain, target: self, action: #selector(selectTapped))
        
        // TODO: allowsMultipleSelection does not work in Mac Catalyst apps for unknown reason
        tableView?.allowsMultipleSelection = true
    }
    
    // MARK: - Document picker delegate
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let fileURLs = try? FileManager.default.contentsOfDirectory(at: urls.first!, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)
        
        if let fileURLs = fileURLs?.filter({ (url) -> Bool in
            var isDir : ObjCBool = false
            FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir)
            return (isDir.boolValue == false)
        }) {
            var files = [File]()
            for url in fileURLs {
                if let file = fileFactory.makeFile(url.path) {
                    files.append(file)
                }
            }
            filesPresentation.files = files
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // a dirty hack to implement custom multiple selection on Mac Catalyst
        #if targetEnvironment(macCatalyst)
        if let cell = tableView.cellForRow(at: indexPath) {
            
            if cell.accessoryType == .checkmark {
                self._tableView(tableView, didDeselectRowAt: indexPath)
                return
            }
            cell.accessoryType = .checkmark
        }
        #endif
        
        if let fileURL = fileURLs?[indexPath.row] {
            selectedURLs.insert(fileURL)
            
            processSelected()
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // a dirty hack to implement custom multiple selection on Mac Catalyst
        #if targetEnvironment(macCatalyst)
        return
        #else
        if (fileURLs?[indexPath.row].path) != nil {
            selectedURLs.remove(fileURLs![indexPath.row])
        }
        
        processSelected()
        #endif
    }
    
    #if targetEnvironment(macCatalyst)
    func _tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
        if (fileURLs?[indexPath.row].path) != nil {
           selectedURLs.remove(fileURLs![indexPath.row])
        }
        
        processSelected()
    }
    #endif

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileURLs?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        if let anURL = fileURLs?[indexPath.row] {
            let item = ListCellViewModelItem(title: anURL.lastPathComponent)
            cell.item = item
            #if targetEnvironment(macCatalyst)
            cell.accessoryType = selectedURLs.contains(anURL) ? .checkmark : .none
            #endif
        }

        return cell
    }
    
    // MARK: - Private implementation
    
    @objc private func selectTapped() {
        if filesPresentation.isProcessing {
            let multiselect = navigationItem.leftBarButtonItem?.customView as! MultiSelectSegmentedControl
            multiselect.selectAllSegments(false)
            selectionChanged(sender: multiselect)
        } else {
            let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeFolder)], in: .open)
            documentPicker.delegate = self
            documentPicker.allowsMultipleSelection = false
            present(documentPicker, animated: true, completion:nil)
        }
    }
    
    @objc private func selectionChanged(sender: MultiSelectSegmentedControl) {
        filesPresentation.filter = currentFilter
    }
    
    private func processSelected() {
        var fp: FileBaseSubject? = nil
        if selectedURLs.count == 1 {
            fp = fileFactory.makeFile(selectedURLs.first!.path)
        } else if selectedURLs.count > 1 {
            fp = fileFactory.makeFileGroup(filePaths: selectedURLs.map { $0.path })
        }
        
        if splitViewController?.viewControllers.count ?? 0 > 1 {
            (splitViewController?.viewControllers[1] as? FilePropertiesViewController)?.fileProperties = fp
        }
    }
    
    private func updateUI() {
        if filesPresentation.isProcessing {
            self.navigationItem.rightBarButtonItem?.title = "Stop"
        } else {
            self.navigationItem.rightBarButtonItem?.title = "Scan..."
        }
    }
    
}
