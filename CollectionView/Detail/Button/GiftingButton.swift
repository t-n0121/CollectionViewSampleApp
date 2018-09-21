//
//  GiftingButton.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/09/06.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit

@IBDesignable
class GiftingButton: UIButton {

	public override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		configure()
	}

	public override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		configure()

		if let title = title(for: state) {
			let attributes: [NSAttributedStringKey: Any] = [
				NSAttributedStringKey(kCTLanguageAttributeName as String): "ja",
				]

			titleLabel?.attributedText = NSAttributedString(string: title, attributes: attributes)
		}
	}

	public override var intrinsicContentSize: CGSize {
		var size = super.intrinsicContentSize
		size.height = 64
		size.width = 64
		return size
	}

	private func configure() {
		setImage(#imageLiteral(resourceName: "icon_gift"), for: .normal)
		backgroundColor = UIColor.Mangahack.newTheme
		setTitleColor(UIColor.Mangahack.lightBlackText, for: .normal)
		layer.cornerRadius = 32

		// シャドウ
		layer.masksToBounds = false
		layer.shadowOffset = CGSize(width: 0, height: 5.0)
		layer.shadowOpacity = 0.3
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowRadius = 4
	}
}
