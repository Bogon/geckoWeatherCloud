//
//  UpdateController.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/13.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

class UpdateController: UIViewController {

    var webView: WebView!
    
    var update_url: String?
    
    init(url value: String) {
        super.init(nibName: nil, bundle: nil)
        self.update_url = value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
