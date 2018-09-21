//
//  IllustrationTagContainerView.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/09/05.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit

protocol IllustrationTagContainerViewDelgate {
	func labelTapped(tag: String)
}

@IBDesignable
class IllustrationTagContainerView: UIView {

	@IBOutlet weak var rowStackView: UIStackView!

//	private var columnStackView: UIStackView = {
//		let stackView = UIStackView()
//		stackView.axis = .horizontal
////		stackView.distribution = .equalSpacing
//		stackView.spacing = 8
//		stackView.frame.size.height = 30
//		return stackView
//	}()

	var delegate: IllustrationTagContainerViewDelgate? = nil

	private func columnStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 8
		stackView.frame.size.height = 30
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		loadNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		loadNib()
	}

	public override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		configure(tags: dummyTags)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
	}

	private func loadNib() {
		let bundle = Bundle(for: type(of: self))
		guard let view = UINib(nibName: "IllustrationTagContainerView", bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
			return
		}
		self.addSubview(view)

		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
	}

	func configure(tags: [String] = []) {
		var column = columnStackView()
		var currentMaxX: CGFloat = 0

		for (index, tag) in tags.enumerated() {
			let label = IllustrationTag()
			label.setTitle(tag, for: .normal)
			label.addTarget(self, action: #selector(labelTapped(_:)), for: .touchUpInside)
			label.tag = index

			if currentMaxX + label.intrinsicContentSize.width > rowStackView.bounds.width {
				
				column.addArrangedSubview(UIView())
				rowStackView.addArrangedSubview(column)
				column = columnStackView()
				currentMaxX = 0
			}

			column.addArrangedSubview(label)
			currentMaxX += label.intrinsicContentSize.width + column.spacing

			if index == dummyTags.count - 1 {
				column.addArrangedSubview(UIView())
				rowStackView.addArrangedSubview(column)
			}
		}
	}

	@objc func labelTapped(_ sender: IllustrationTag) {
		delegate?.labelTapped(tag: (sender.titleLabel?.text)!)
	}

	private var dummyTags: [String] {
		return [
			"#ファンタジー",
			"#らくがき",
			"#ファンアート",
			"#魔法少女",
			"#王様ランキング",
			"#マンガハック",
			"#らくがき",
			"#ファンアート",
			"#魔法少女",
			"#王様ランキング",
		]
	}
}
