//
//  ListCell.swift
//  FileBrowser
//
//  Created by Pavel B on 07.01.2020.
//  Copyright © 2020 Pavel B. All rights reserved.
//

import UIKit


struct ListCellViewModelItem {
    var title: String?
}


class ListCell: UITableViewCell {
    
    // MARK: - Public properties
    
    var item: ListCellViewModelItem? {
        didSet {
            textLabel?.text = item?.title
        }
    }
    
    // MARK: - Lifecycle
    
#if !targetEnvironment(macCatalyst)
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
       accessoryType = selected ? .checkmark : .none
    }

    override func awakeFromNib() {
       super.awakeFromNib()
       selectionStyle = .none
    }
#endif
}
