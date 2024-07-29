//
//  PurchaseButton.swift
//  Cproject
//
//  Created by 서정원 on 7/29/24.
//

import UIKit

final class PurchaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {        //Storyboard 를 사용할 때 fatalError("init(coder:) has not been implemented") 이 코드도 수정해줘야 한다.
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = CPColors.keyColorBlue.cgColor
        setTitleColor(CPColors.keyColorBlue, for: .normal)
        setTitle("구매하기", for: .normal)
    }
}
