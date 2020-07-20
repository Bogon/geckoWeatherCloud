//
//  ViewController.swift
//  geckoWeatherCloud
//
//  Created by 张奇 on 2020/6/23.
//  Copyright © 2020 张奇. All rights reserved.
//

import UIKit
import paper_onboarding
import Hue
import RxSwift
import RxCocoa

class OnBoardingController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let items = [
        OnboardingItemInfo(informationImage: Asset.hotels.image,
                           title: "实时天气",
                           description: "\n出行、旅游、约会、出席会议随时随地查看\n当地天气，你的贴心出行助手",
                           pageIcon: Asset.key.image,
                           color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.banks.image,
                           title: "精准预报",
                           description: "\n无论是出行还是旅游，ta替你看到天气变化，\n为你感知温度差异，给你温馨提醒",
                           pageIcon: Asset.wallet.image,
                           color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.stores.image,
                           title: "未来7天",
                           description: "\n为你提供未来七天的天气预报，为你未来的\n出行和规划提供参考，出行决策必备",
                           pageIcon: Asset.shoppingCart.image,
                           color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                           titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
    
    ]
    
    /// 跳过按钮
    lazy var skipButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("跳过", for: .normal)
        button.setTitleColor(UIColor.init(hex: "#666666"), for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.setBackgroundImage(UIImage.getImage(WithColor: UIColor.init(hex: "#ffffff").alpha(0.6), size: CGSize(width: 80, height: 40)), for: .normal)
        button.setBackgroundImage(UIImage.getImage(WithColor: UIColor.init(hex: "#ffffff").alpha(0.4), size: CGSize(width: 80, height: 40)), for: .highlighted)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        skipButton.rx.tap.subscribe(onNext: {
            /// 切换到跟控制器
            SwitchRootController.switchto()
        }).disposed(by: disposeBag)
        
    }
}

// MARK: PaperOnboardingDelegate
extension OnBoardingController: PaperOnboardingDelegate {

    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 2 ? false : true
    }

    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
        //item.titleCenterConstraint?.constant = 100
        //item.descriptionCenterConstraint?.constant = 100
        
        // configure item
        
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource
extension OnBoardingController: PaperOnboardingDataSource {

    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }

    func onboardingItemsCount() -> Int {
        return 3
    }
    
    //    func onboardinPageItemRadius() -> CGFloat {
    //        return 2
    //    }
    //
    //    func onboardingPageItemSelectedRadius() -> CGFloat {
    //        return 10
    //    }
    //    func onboardingPageItemColor(at index: Int) -> UIColor {
    //        return [UIColor.white, UIColor.red, UIColor.green][index]
    //    }
}


//MARK: Constants
private extension OnBoardingController {
    
    static let titleFont = UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont.systemFont(ofSize: 14.0)
}

