//
//  FilePropertiesDurationFilter.swift
//  FileBrowser
//
//  Created by Pavel B on 10.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import Foundation


class FilePropertiesDurationFilter: FilePropertiesBaseFilter {
    
    // MARK: - Private properties
    
    private let operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        /*
         * in order to slowdown the filtering
         * and try the canceling out
         * next statement can be used:
         * operationQueue.maxConcurrentOperationCount = 1
         *
        */
        return operationQueue
    }()
    
    // MARK: - Public properties
    
    var validator: ((TimeInterval?) -> Bool)?
    
    // MARK: - Lifecycle
    
    deinit {
        operationQueue.cancelAllOperations()
    }
    
    // MARK: - File filter
    
    override func filter(_ files: [File],
                         completion: @escaping ([File]?) -> Void)
    {
        DispatchQueue.global(qos: .utility).async {
            var filteredFiles = [File]()
            
            // called after all files are filtered
            let completionOperation = BlockOperation {
                if filteredFiles.count > 0 {
                    super.filter(filteredFiles, completion: completion)
                } else {
                    completion(nil)
                }
            }
            
            if let validator = self.validator {
                var lock: os_unfair_lock = os_unfair_lock_s()
                
                for file in files {
                    let extensionName = String(describing:FilePropertiesDurationExtension.self)
                    if let durationExt = file.extension(extensionName) as? FilePropertiesDurationExtension {
                        let operation = BlockOperation {
                            var duration: Double?
                            
                            /*
                             * Swift still does not support async/wait
                             * semaphore is used in order to simulate it
                            */
                            let semaphore = DispatchSemaphore(value: 0)
                            durationExt.calculateDuration({ (calcDuration) in
                                duration = calcDuration
                                semaphore.signal()
                            })
                            _ = semaphore.wait(timeout: .distantFuture)
                            
                            // once duration is calculated it can be validated
                            if validator(duration) {
                                // preventing race condition
                                os_unfair_lock_lock(&lock);
                                filteredFiles.append(file)
                                os_unfair_lock_unlock(&lock);
                            }
                        }
                        completionOperation.addDependency(operation)
                        
                        self.operationQueue.addOperation(operation)
                    }
                }
            }
            
            self.operationQueue.addOperation(completionOperation)
        }
    }
    
    override func cancel() {
        operationQueue.cancelAllOperations()
    }
    
}
