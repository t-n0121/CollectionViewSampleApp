//
//  RelatedIllustThumbnailView.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/09/07.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit

protocol RelatedIllustThumbnailViewDelegate {
	func buttonTapped(tag: Int)
}

@IBDesignable
class RelatedIllustThumbnailView: UIView {

	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var label: UILabel!

	@IBAction private func buttonTapped(_ sender: UIButton) {
		delegate?.buttonTapped(tag: tag)
	}

	@IBInspectable
	var image: UIImage! {
		didSet {
			guard let _image = image else { return }
			imageView.image = _image
		}
	}

	var delegate: RelatedIllustThumbnailViewDelegate? = nil


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

		label.attributedText = NSAttributedString(string: "差し入れ", attributes: attributes)

		configure()
	}

	private func loadNib() {
		let bundle = Bundle(for: type(of: self))
		guard let view = UINib(nibName: "RelatedIllustThumbnailView", bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
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
		imageView.layer.borderWidth = 1
		imageView.layer.borderColor = UIColor.Mangahack.silver.cgColor
		imageView.layer.cornerRadius = 4

		configureLabel()
	}

	private func configureLabel() {

		label.clipsToBounds = true
		label.backgroundColor = UIColor.Mangahack.mangahackRed
		label.textColor = .white
		label.layer.cornerRadius = 4
		label.text = "差し入れ"

		let fontSize: CGFloat = UIDevice().userInterfaceIdiom == .pad ? 16 : 8
		label.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)

		// 左上と右下だけ角丸にする
		let rudius: CGFloat = 4
		if #available(iOS 11.0, *) {
			label.layer.cornerRadius = rudius
			label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
		} else {
			let maskPath = UIBezierPath(roundedRect: label.bounds,
											byRoundingCorners: [ .topLeft, .bottomRight ],
											cornerRadii: CGSize(width: rudius, height: rudius))
			let maskLayer = CAShapeLayer()
			maskLayer.frame = label.bounds
			maskLayer.path = maskPath.cgPath
			label.layer.mask = maskLayer
		}
	}
}
