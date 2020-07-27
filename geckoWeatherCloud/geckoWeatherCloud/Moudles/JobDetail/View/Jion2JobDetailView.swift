//
//  Jion2JobDetailView.swift
//  geckoWeatherCloud
//
//  Created by Senyas on 2020/7/27.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit

fileprivate let ScreenWidth: CGFloat = UIScreen.main.bounds.width

protocol Jion2JobDetailDelegate: NSObjectProtocol {
    func jion2Job()
}

class Jion2JobDetailView: UIView {

    @IBOutlet weak var join_button: UIButton!

    weak var delegate: Jion2JobDetailDelegate?
    
    var store_job_type: StoreJobType = .none {
        didSet {
            if store_job_type == .none {
                join_button.setTitle("报名参加", for: UIControl.State.normal)
                join_button.isEnabled = true
            } else {
                join_button.setTitle("已报名，请耐心等待雇主与你联系", for: UIControl.State.disabled)
                join_button.isEnabled = false
            }
        }
    }
    
    
    // MARK:- 创建视图
    class func instance() -> Jion2JobDetailView? {
        let nibView = Bundle.main.loadNibNamed("Jion2JobDetailView", owner: nil, options: nil)
        if let view = nibView?.first as? Jion2JobDetailView {
            return view
        }
        return nil
    }
    
    @IBAction func joinAction(_ sender: UIButton) {
        self.store_job_type = .just_join
        delegate?.jion2Job()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        join_button.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.size.equalTo(CGSize(width: ScreenWidth, height: 50))
        }
    }
    
    static var layoutHeight: CGFloat {
       
        let contentHeight: CGFloat = 50 + BottomMarginY.margin
        return contentHeight
    }

}
