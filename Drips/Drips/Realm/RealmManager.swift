//
//  RealmManager.swift
//  Drips
//
//  Created by James Fong on 2018-01-07.
//  Copyright © 2018 James Fong. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {
        
    }
    
    func addNote(note: NoteDataModel, completion:((NoteDataModel?,Error?)->())?){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(note)
            }
        }
        catch let error as NSError {
            completion?(note, error)
        }
        completion?(note, nil)
    }
    
    func editNote(note: NoteDataModel,title:String, message:String, completion:((NoteDataModel?,Error?)->())?){
        do {
            let realm = try Realm()
            try realm.write {
                note.title = title
                note.message = message
            }
        }
        catch let error as NSError {
            completion?(note, error)
        }
        completion?(note, nil)
    }
    
    func deleteNote(note: NoteDataModel,completion:((NoteDataModel?,Error?)->())?) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(note)
            }
        }
        catch let error as NSError {
            completion?(note, error)
        }
        completion?(note, nil)
    }
    
    func getNotes() -> Results<NoteDataModel>? {
        do {
            let realm = try Realm()
            return realm.objects(NoteDataModel.self)
        }
        catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}
