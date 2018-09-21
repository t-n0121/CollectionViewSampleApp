//
//  IllustrationTagLabel.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/09/05.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit

@IBDesignable
class IllustrationTag: UIButton {

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
		size.height = 30

		if let titleLabel = titleLabel {
			size.width = titleLabel.intrinsicContentSize.width + 16
		}

		return size
	}

	private func configure() {
		titleLabel?.font = UIFont.systemFont(ofSize: 13)
		backgroundColor = UIColor.Mangahack.silver
		setTitleColor(UIColor.Mangahack.lightBlackText, for: .normal)
		layer.cornerRadius = 4
	}

}
