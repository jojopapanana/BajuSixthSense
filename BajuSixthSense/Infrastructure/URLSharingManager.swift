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
        let contactNumber = formatPhoneNumber(phoneNumber: phoneNumber)
        let urlString = urlHeader + contactNumber + "?text=" + textMessage
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
    
    func generateShareClothLink(clothID: String?) -> URL {
        let appLinkHeader = "https://"
        let domain = "kelothing.web.app"
        let host = "/clothDetail"
        
        guard let id = clothID else {
            return URL(string: appLinkHeader)!
        }
        
        let appLink = URL(string: appLinkHeader + domain + host + "?id=" + id)
        return appLink ?? URL(string: appLinkHeader + domain)!
    }
    
    func generateShareProfileLink(userID: String?) -> URL {
        let appLinkHeader = "https://"
        let domain = "kelothing.web.app"
        let host = "/profile"
        
        guard let id = userID else {
            return URL(string: appLinkHeader)!
        }
        
        let appLink = URL(string: appLinkHeader + domain + host + "?id=" + id)
        return appLink ?? URL(string: appLinkHeader + domain)!
    }
    
    func retreiveID(from link: URL) -> String {
        guard
            let components = URLComponents(url: link, resolvingAgainstBaseURL: true)
        else { return "" }
        
        var retrieveID: String = ""
        
        for queryItem in components.queryItems ?? [] {
            if queryItem.name == "id" {
                retrieveID = queryItem.value ?? ""
            }
        }
        
        return retrieveID
    }
    
    func formatPhoneNumber(phoneNumber: String) -> String {
        var initNumber = phoneNumber
        var formatedNumber = "62"
        
        if initNumber.first == "0" {
            initNumber.removeFirst()
            formatedNumber += initNumber
        } else if initNumber.hasPrefix("62") {
            formatedNumber = initNumber
        }
        
        return formatedNumber
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
