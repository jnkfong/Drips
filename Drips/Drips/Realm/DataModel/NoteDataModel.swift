//
//  NoteDataModel.swift
//  Drips
//
//  Created by James Fong on 2018-01-07.
//  Copyright © 2018 James Fong. All rights reserved.
//

import Foundation
import RealmSwift

class NoteDataModel: Object {
    @objc dynamic var title = ""
    @objc dynamic var message = ""
}
