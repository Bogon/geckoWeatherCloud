//
//  OnBoardingController+Layout.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/24.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import SnapKit
import paper_onboarding

extension OnBoardingController {
    
    override func loadView() {
        super.loadView()
        initSubView()
    }
    
    private func initSubView() {
        view.addSubview(self.skipButton)
        skipButton.isHidden = true
        
        setupPaperOnboardingView()
        view.bringSubviewToFront(self.skipButton)
    }
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)

        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.skipButton.snp.remakeConstraints { (make) in
            make.right.equalTo(view.snp.right).offset(-15)
            make.top.equalTo(view.snp.top).offset(50)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
    }
}
