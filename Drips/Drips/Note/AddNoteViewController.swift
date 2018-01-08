//
//  AddNoteViewController.swift
//  Drips
//
//  Created by James Fong on 2018-01-07.
//  Copyright © 2018 James Fong. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNotePressed(_ sender: Any) {
        guard let titleText = titleTextField.text,
            let messageText = messageTextView.text else {
                return
        }
        let note = NoteDataModel()
        note.title = titleText
        note.message = messageText
        RealmManager.shared.addNote(note: note) {[weak self] (_, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            strongSelf.dismiss(animated: true, completion: nil)
        }
    }
}
