// 
//  ChatViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

internal final class ChatViewModel {

}

extension ChatViewModel {
    enum ChatResultData {
        case initial
        case success(ChatModel)
        case failure(Error)
    }
}
