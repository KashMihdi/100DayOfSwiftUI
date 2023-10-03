//
//  FileManager-DocumentDirectory.swift
//  BucketList
//
//  Created by Kasharin Mikhail on 02.10.2023.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
