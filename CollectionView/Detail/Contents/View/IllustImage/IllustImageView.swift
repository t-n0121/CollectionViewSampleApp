//
//  IllustImageView.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/23.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit

@IBDesignable
class IllustImageView: UIView {
	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet weak var imageViewAspectConstraint: NSLayoutConstraint!

	override init(frame: CGRect) {
		super.init(frame: frame)
		loadNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		loadNib()
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		if let image = imageView.image {
			imageAspectRatio(w: image.size.width, h: image.size.height)
		}
	}

	private func loadNib() {
		let bundle = Bundle(for: type(of: self))
		guard let view = UINib(nibName: "IllustImageView", bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
			return
		}
		self.addSubview(view)

		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
	}

	private func imageAspectRatio(w: CGFloat, h: CGFloat) {
		imageView.removeConstraint(imageViewAspectConstraint)
		imageViewAspectConstraint = imageAspectConstriant(width: CGFloat(w), height: CGFloat(h))
		NSLayoutConstraint.activate([imageViewAspectConstraint])
	}

	private func imageAspectRatio(w: Float, h: Float) {
		imageAspectRatio(w: CGFloat(w), h: CGFloat(h))
	}

	private func imageAspectConstriant(width: CGFloat, height: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(
			item: imageView,
			attribute: NSLayoutAttribute.height,
			relatedBy: NSLayoutRelation.equal,
			toItem: imageView,
			attribute: NSLayoutAttribute.width,
			multiplier: height / width,
			constant: 0
		)
	}
}
