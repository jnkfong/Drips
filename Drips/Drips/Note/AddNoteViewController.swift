//
//  AddNoteViewController.swift
//  Drips
//
//  Created by James Fong on 2018-01-07.
//  Copyright © 2018 James Fong. All rights reserved.
//

import UIKit

class AddNoteViewController: BaseViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var bckgrdImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBackground()
        self.configureTextFields()
        // Do any additional setup after loading the view.
    }
    
    func configureBackground(){
        self.bckgrdImageView.addSubview(self.getBlurEffectView(style: .dark, frame: self.view.bounds, alpha: 1))
    }
    
    func configureTextFields(){
        let paddingView = UIView(frame: CGRect(x: 0,y: 0,width: 5,height: self.titleTextField.frame.height))
        self.titleTextField.leftView = paddingView
        self.titleTextField.leftViewMode = .always
        self.titleTextField.layer.cornerRadius = 5
        self.titleTextField.layer.masksToBounds = true
        self.titleTextField.background = imageWithView(view: self.getBlurEffectView(style: .light, frame: self.titleTextField.bounds, alpha: 1))
        self.messageTextView.layer.cornerRadius = 5
        self.messageTextView.layer.masksToBounds = true
        self.messageTextView.insertSubview(self.getBlurEffectView(style: .light, frame: self.messageTextView.bounds, alpha: 1), at: 0)
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
