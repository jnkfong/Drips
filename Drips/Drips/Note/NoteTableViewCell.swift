//
//  NoteTableViewCell.swift
//  Drips
//
//  Created by James Fong on 2018-01-04.
//  Copyright © 2018 James Fong. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bckgrdView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCellView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellView(){
        self.selectionStyle = .none
    }
}
