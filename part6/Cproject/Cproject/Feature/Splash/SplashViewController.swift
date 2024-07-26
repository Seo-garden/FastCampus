//
//  SplashViewController.swift
//  Cproject
//
//  Created by 서정원 on 7/23/24.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var lottiAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lottiAnimationView.play { [weak self] _ in
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let viewController = storyboard.instantiateInitialViewController()
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first(where: { $0.isKeyWindow }){
//                window.rootViewController = HomeViewController()      //코드베이스 기반 코드를 작성할 땐 상관없지만, storyboard 인스펙터에서 적용된 설정을 가져올 수 없다. 그래서 아래와 같이 storyboard 값을 가져와서 window.rootViewController 에 할당해야 한다.
                window.rootViewController = viewController
            }
            self?.present(HomeViewController(), animated: true)
        }
        UIImageView().image = CPImages.close
    }
}
//        appIconCenterXConstraint.constant = -(view.frame.width / 2) - (appIcon.frame.width / 2)
//        appIconCenterYConstraint.constant = -(view.frame.height / 2) - (appIcon.frame.height / 2)
//
//        //메모리 누수때문에 weak self 를 추천한다.
//        UIView.animate(withDuration: 1) { [weak self] in
//            self?.view.layoutIfNeeded()
//        }
