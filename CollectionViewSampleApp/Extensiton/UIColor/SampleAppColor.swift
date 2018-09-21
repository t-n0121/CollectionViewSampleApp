//
//  SampleAppColor.swift
//  CollectionViewSampleApp
//
//  Created by Teruki Nakano on 2018/09/21.
//  Copyright © 2018年 Teruki Nakano. All rights reserved.
//

import UIKit

extension UIColor {
    struct SampleApp {
        private init() {}
        /** #DFE3E5 ボーダー */
        static let silver = #colorLiteral(red: 0.8745098039, green: 0.8901960784, blue: 0.8980392157, alpha: 1)
        /** #282537 ナビゲーション */
        static let navigation = #colorLiteral(red: 0.1568627451, green: 0.1450980392, blue: 0.2156862745, alpha: 1)
        /** #282537 黒のテキスト*/
        static let blackText = UIColor(red: 40/255, green: 37/255, blue: 55/255, alpha: 1.0)
        /** #b0bdc6 薄いグレーのテキスト*/
        static let lightGrayText = UIColor(red: 176/255, green: 189/255, blue: 198/255, alpha: 1.0)
        /** #505066 薄い黒のテキスト*/
        static let lightBlackText = UIColor(red: 80/255, green: 80/255, blue: 102/255, alpha: 1.0)
        /** # 検索フィールドの背景色*/
        static let serachTextFieldBackground = UIColor(red: 56/255, green: 54/255, blue: 70/255, alpha: 1.0)
        /** #b0bdc6 より薄いグレー*/
        static let superLightGray = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
    }
}
