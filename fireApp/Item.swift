//
//  Item.swift
//  fireApp
//
//  Created by David Svensson on 2021-02-02.
//

import Foundation
import FirebaseFirestoreSwift

struct Item : Codable, Identifiable {
    @DocumentID var id : String?
    var name : String
    var done : Bool = false
}
