//
//  RelatedIllustrationView.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/09/07.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit

protocol RelatedIllustrationViewDelegate {
	func thumbnailTapped(tag: Int)
}

@IBDesignable
class RelatedIllustrationView: UIView {

	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!

	@IBOutlet weak var thumbnailView: RelatedIllustThumbnailView!
	@IBOutlet weak var thumbnailView2: RelatedIllustThumbnailView!
	@IBOutlet weak var thumbnailView3: RelatedIllustThumbnailView!

	@IBInspectable
	var iconImage: UIImage! {
		didSet {
			guard let image = iconImage else { return }
			iconImageView.image = image
		}
	}

	var delegate: RelatedIllustrationViewDelegate? = nil

	public override init(frame: CGRect) {
		super.init(frame: frame)
		loadNib()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		loadNib()
	}

	public override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()

		let attributes: [NSAttributedStringKey: Any] = [
			NSAttributedStringKey(kCTLanguageAttributeName as String): "ja",
			]

		nameLabel.attributedText = NSAttributedString(string: "坂野克紀", attributes: attributes)
	}

	private func loadNib() {
		let bundle = Bundle(for: type(of: self))
		guard let view = UINib(nibName: "RelatedIllustrationView", bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
			return
		}
		self.addSubview(view)

		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

		configure()
	}

	private func configure() {
		thumbnailView.delegate = self
		thumbnailView2.delegate = self
		thumbnailView3.delegate = self

		nameLabel.textColor = UIColor.Mangahack.blackText
	}

}

extension RelatedIllustrationView: RelatedIllustThumbnailViewDelegate {
	func buttonTapped(tag: Int) {
		delegate?.thumbnailTapped(tag: tag)
	}
}
