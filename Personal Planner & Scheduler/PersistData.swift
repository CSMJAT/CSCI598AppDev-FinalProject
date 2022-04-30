//
//  PersistData.swift
//  Personal Planner & Scheduler
//
//  Created by Mines Student on 4/30/22.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

extension UTType {
    static var persistType: UTType {
        UTType(importedAs: "csm.PPaS.persist")
    }
}

final class PersistData: ReferenceFileDocument {
    typealias Snapshot = UserInformation
    
    @Published var userInfo: UserInformation
    
    static var readableContentTypes: [UTType] {[.persistType]}
    
    func snapshot(contentType: UTType) throws -> UserInformation {
        userInfo
    }
    
    init() {
        userInfo = UserInformation() //TODO: change this?
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.userInfo = try JSONDecoder().decode(UserInformation.self, from: data)
    }
    
    func fileWrapper(snapshot: UserInformation, configuration: WriteConfiguration) throws -> FileWrapper{
        let data = try JSONEncoder().encode(snapshot)
        let filewrapper = FileWrapper(regularFileWithContents: data)
        return filewrapper
    }
}

