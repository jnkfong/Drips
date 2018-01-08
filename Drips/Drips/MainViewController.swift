//
//  MainViewController.swift
//  Drips
//
//  Created by James Fong on 2018-01-07.
//  Copyright © 2018 James Fong. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    @IBOutlet weak var noteTableView: UITableView!
    var notes:Results<NoteDataModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let notesResult = RealmManager.shared.getNotes() else { return }
        notes = notesResult
        self.configureNoteTableView()
    }
    
    func configureNoteTableView(){
        noteTableView.delegate = self
        noteTableView.dataSource = self
        noteTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteTableViewCell")
        noteTableView.register(UINib.init(nibName: "NoteTableViewCell", bundle:nil), forCellReuseIdentifier: "NoteTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noteTableView.reloadData()
    }
}

extension MainViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
        cell.titleLabel.text = notes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editNoteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditNoteViewController") as! EditNoteViewController
        editNoteViewController.note = notes[indexPath.row]
        self.present(editNoteViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            RealmManager.shared.deleteNote(note: note, completion: { (_, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                tableView.reloadData()
            })
        }
    }
    
}
