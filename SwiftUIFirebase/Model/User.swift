//
//  User.swift
//  SwiftUIFirebase
//
//  Created by kingpin on 5/31/25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let commponents = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: commponents)
        }
        return ""
    }
    
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "App Developer", email: "kingpinfx1@gmail.com")
}
