//
//  ViewController.swift
//  LineCommon
//
//  Created by 寺田優 on 2019/12/08.
//  Copyright © 2019 寺田優. All rights reserved.
//

import UIKit
import LINEActivity

// presenter output
extension LineShareViewController: LineSharePresenterOutput {
    func showAlert(_ alertController: UIAlertController) {
        present(alertController, animated: true)
    }
}

class LineShareViewController: UIViewController {
    
    // Injecting presenterInput
    private var presenter: LineSharePresenterInput!
    func inject(presenter: LineSharePresenterInput){
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lineShareModel = LineShareModel()
        let lineSharePresenter = LineSharePresenter(view: self, lineShareModel: lineShareModel)
        self.inject(presenter: lineSharePresenter)
    }
    
    @IBOutlet weak var ImageView: UIImageView!
    
    // TextのShare
    @IBAction func lineTextShareBtn(_ sender: Any) {
        presenter.didTapLineTextShareBtn()
    }
    
    // ImageのShare
    @IBAction func lineImageShareBtn(_ sender: Any) {
        presenter.didTapLineImageShareBtn(image: ImageView.image!)
    }

}

