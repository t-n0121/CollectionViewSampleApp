//
//  IllustContentsView.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/09/03.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit

@IBDesignable
class IllustContentsView: UIView {

	
	@IBOutlet weak var imageView: IllustImageView!
	@IBOutlet weak var descriptionView: IllustDescriptionView!
	@IBOutlet weak var tagContainerView: IllustrationTagContainerView!
	@IBOutlet weak var relatedIllustsView: RelatedIllustrationView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		loadNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		loadNib()
	}

	private func loadNib() {
		let bundle = Bundle(for: type(of: self))
		guard let view = UINib(nibName: "IllustContentsView", bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
			return
		}
		self.addSubview(view)

		view.translatesAutoresizingMaskIntoConstraints = false
		view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

	}
	
}