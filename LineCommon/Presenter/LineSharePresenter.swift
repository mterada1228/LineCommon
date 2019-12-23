//
//  LineShareProvider.swift
//  LineCommon
//
//  Created by 寺田優 on 2019/12/08.
//  Copyright © 2019 寺田優. All rights reserved.
//

import Foundation
import UIKit

protocol LineSharePresenterInput {
    func didTapLineTextShareBtn()
    func didTapLineImageShareBtn(image: UIImage)
    func didTapLineImageAndTextShareBtn(image: UIImage)
}

protocol LineSharePresenterOutput: AnyObject {
    func showAlert(_ alertController: UIAlertController)
}

final class LineSharePresenter : LineSharePresenterInput {
    
    private weak var view : LineSharePresenterOutput!
    private var lineShareModel: LineShareModelInput!
    
    // initialize
    init(view: LineSharePresenterOutput,
         lineShareModel: LineShareModelInput!) {
        self.view = view
        self.lineShareModel = lineShareModel
    }
    
    // テキストをLineにShareする
    func didTapLineTextShareBtn() {
        
        // 投稿するテキスト
        let message = "test"
        
        // Lineにテキストを送付する
        lineShareModel.sendMessage(message: message) { [weak self] result in
            switch result {
            case .success(let url) :
                if UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { (succes) in
                            //  LINEアプリ表示成功
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }else {
                    // LINEアプリが無い場合
                    let alertController = UIAlertController(title: "エラー",
                                                            message: "LINEがインストールされていません",
                                                            preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                    self?.view.showAlert(alertController)
                }
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    // 画像をLineにShareする
    func didTapLineImageShareBtn(image: UIImage) {
    
        let message  = "iPhone"
        
        // Lineに画像をシェアする
        lineShareModel.sendImage(image: image) { [weak self] result in
            switch result {
            case .success(let url) :
                if UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { (succes) in
                            //  LINEアプリ表示成功
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }else {
                    // LINEアプリが無い場合
                    let alertController = UIAlertController(title: "エラー",
                                                            message: "LINEがインストールされていません",
                                                            preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                    self?.view.showAlert(alertController)
                }
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    // 画像をLineにShareする
    func didTapLineImageAndTextShareBtn(image: UIImage) {
        
        let message = "testMessage"
        
        // Lineに画像をシェアする
        lineShareModel.sendImageAndText(message: message, image: image){ [weak self] result in
            switch result {
            case .success(let url) :
                if UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { (succes) in
                            //  LINEアプリ表示成功
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }else {
                    // LINEアプリが無い場合
                    let alertController = UIAlertController(title: "エラー",
                                                            message: "LINEがインストールされていません",
                                                            preferredStyle: UIAlertController.Style.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                    self?.view.showAlert(alertController)
                }
            case .failure(let error) :
                print(error)
            }
        }
    }
    
}



