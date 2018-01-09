//
//  MainViewController.swift
//  Drips
//
//  Created by James Fong on 2018-01-07.
//  Copyright © 2018 James Fong. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: BaseViewController {

    @IBOutlet weak var noteTableView: UITableView!
    @IBOutlet weak var bckgrdImageView: UIImageView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    
    var refresh: UIRefreshControl!
    var notes:Results<NoteDataModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let notesResult = RealmManager.shared.getNotes() else { return }
        notes = notesResult
        self.configureBackground()
        self.configureNagivationView()
        self.configureNoteTableView()
    }
   
    func configureBackground(){
        self.bckgrdImageView.addSubview(self.getBlurEffectView(style: .dark, frame: self.view.bounds, alpha: 1))
    }
    
    func configureNagivationView(){
        let bounds = CGRect(x: 0, y: 0, width: self.navigationView.frame.width, height: self.navigationView.frame.height)
        let blurredView = self.getBlurEffectView(style: .light, frame: bounds, alpha: 1)
        blurredView.layer.cornerRadius = 5
        blurredView.layer.masksToBounds = true
        self.navigationView.insertSubview(blurredView, at: 0)
        self.navigationTitleLabel.text = "Notes"
    }
    
    func configureNoteTableView(){
        refresh = UIRefreshControl()
        noteTableView.addSubview(refresh)
        refresh.addTarget(self, action: #selector(refreshNotes), for: .valueChanged)
        noteTableView.delegate = self
        noteTableView.dataSource = self
        noteTableView.rowHeight = 70
        noteTableView.separatorStyle = .none
        noteTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteTableViewCell")
        noteTableView.register(UINib.init(nibName: "NoteTableViewCell", bundle:nil), forCellReuseIdentifier: "NoteTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshNotes()
    }
    
    @objc func refreshNotes(){
        guard let notesResult = RealmManager.shared.getNotes() else {
            refresh.endRefreshing()
            return
        }
        notes = notesResult
        noteTableView.reloadData()
        refresh.endRefreshing()
    }
}

extension MainViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
        cell.titleLabel.text = notes[indexPath.row].title
        let frame = CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height - 10)
        let blurredView = self.getBlurEffectView(style: .light, frame: frame, alpha: 1)
        blurredView.layer.cornerRadius = 5
        blurredView.layer.masksToBounds = true
        let backgroundContainer = UIView(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height))
        backgroundContainer.addSubview(blurredView)
        cell.backgroundView = backgroundContainer
        
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
