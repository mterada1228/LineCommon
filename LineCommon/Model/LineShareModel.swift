//
//  LineShareModel.swift
//  LineCommon
//
//  Created by 寺田優 on 2019/12/08.
//  Copyright © 2019 寺田優. All rights reserved.
//

import Foundation
import UIKit

enum Result<T,Error> {
    case success(T)
    case failure(Error)
}

protocol LineShareModelInput {
    // Lineにテキストメッセージをシェアする
    func sendMessage(message: String,
                     completion: @escaping (Result<URL, String>) -> ())
    // Lineに画像をシェアする
    func sendImage(image: UIImage,
                   completion: @escaping (Result<URL, String>) -> ())
}

final class LineShareModel: LineShareModelInput {
    
    // テキスト送信用URLを作成する
    func sendMessage(message: String,
                     completion: @escaping (Result<URL, String>) -> ()) {
        
        let urlscheme: String = "line://msg/text"
        
        // line:/msg/text/(メッセージ)
        let urlstring = urlscheme + "/" + message
        
        // URLエンコード
        guard let  encodedURL = urlstring.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return completion(.failure("メッセージの送信に失敗しました。"))
        }
        
        // URL作成
        guard let url = URL(string: encodedURL) else {
            return completion(.failure("メッセージの送信に失敗しました。"))
        }
        
        completion(.success(url))
    }
    
    // 画像送信用URLを作成する
    func sendImage(image: UIImage,
                   completion: @escaping (Result<URL, String>) -> ()) {
        
        let pasteBoard = UIPasteboard.general
        pasteBoard.image = image
        
        let lineSchemeImage: String = "line://msg/image/%@"
        let scheme = String(format: lineSchemeImage, pasteBoard.name as CVarArg)
        let messageURL: URL! = URL(string: scheme)
        
        completion(.success(messageURL))
    }
}
