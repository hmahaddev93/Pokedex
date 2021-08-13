//
//  Date+Formatted.swift
//  MusicTracks
//
//  Created by Khatib Mahad H. on 8/4/21.
//

import Foundation
extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
