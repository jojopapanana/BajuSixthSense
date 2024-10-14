//
//  URLSharingManager.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 14/10/24.
//

import Foundation
import SwiftUI

class URLSharingManager {
    static let shared = URLSharingManager()
    
    func chatInWA(phoneNumber: String, textMessage: String) {
        let urlHeader = "https://wa.me/"
        let urlString = urlHeader + phoneNumber + "?text=" + textMessage
        let urlStringEncoded = urlString
            .addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed
            ) ?? urlHeader + phoneNumber
        guard let url = URL(string: urlStringEncoded) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func generateShareLink(clothID: String) -> URL {
        let appLinkHeader = "Kelothing://"
        let host = "clothDetail"
        let appLink = URL(string: appLinkHeader + host + "?id=" + clothID)
        return appLink ?? URL(string: appLinkHeader)!
    }
    
    func retreiveClothID(from link: URL) -> String {
        guard let retrieveID = link.queryParam?["id"] else {
            return ""
        }
        
        return retrieveID
    }
    
}

extension URL {
    var queryParam: [String: String]? {
        guard
            let component = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let items = component.queryItems
        else {
            return nil
        }
        
        return items.reduce(into: [String: String]()) { (result, item) in
            let name = item.name
            let value = item.value
            result[name] = value
        }
    }
}
