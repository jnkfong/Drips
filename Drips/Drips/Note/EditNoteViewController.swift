//
//  EditNoteViewController.swift
//  Drips
//
//  Created by James Fong on 2018-01-07.
//  Copyright © 2018 James Fong. All rights reserved.
//

import UIKit

class EditNoteViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    var note: NoteDataModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = note?.title
        messageTextView.text = note?.message
    }
    
    @IBAction func updateNotePressed(_ sender: Any) {
        guard let titleText = titleTextField.text,
            let messageText = messageTextView.text,
            let note = note else {
                return
        }
        RealmManager.shared.editNote(note: note, title: titleText, message: messageText) {
            [weak self] (_, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                print(error.localizedDescription)
            }
            strongSelf.dismiss(animated: true, completion: nil)
        }
    }
    
}
