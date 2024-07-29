//
//  Numeric+Extensions.swift
//  Cproject
//
//  Created by 서정원 on 7/27/24.
//

import Foundation

extension Numeric {     //기존에 extension 은, 클래스의 상속 혹은 프로토콜의 채택만을 분리해서 사용하는 줄 알았는데, 아니였다.
    var moneyString: String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        return (formatter.string(for: self) ?? "") + "원"
    }
}
