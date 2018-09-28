
import UIKit

/*
カスタムサーチバー
見た目の確認用にMHSearchBarView.Xibを用意してある。
*/

@IBDesignable
class SearchBar: UISearchBar {

	@IBInspectable
	var placeholderText: String? {
		didSet {
			placeholder = placeholderText
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configure()
	}

	public override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		configure()

		self.placeholder = (placeholderText != nil) ? placeholderText! : "キーワードで探す"
	}

	public override var intrinsicContentSize: CGSize {
		var size = super.intrinsicContentSize
		size.height = 52
		return size
	}

	private func configure() {

		barTintColor = UIColor.SampleApp.navigation
		backgroundColor = UIColor.SampleApp.navigation

		if let background = self.value(forKey: "_background") as? UIImageView {
			background.image = UIImage()
		}

		if let shadow = self.value(forKey: "_shadowView") as? UIView {
			shadow.removeFromSuperview()
		}

		if let textField = self.value(forKey: "_searchField") as? UITextField {
			textField.backgroundColor = UIColor.SampleApp.serachTextFieldBackground
			textField.textColor = .white
			textField.font = UIFont.systemFont(ofSize: 14)
			if let backgroundview = textField.subviews.first {
				backgroundview.layer.cornerRadius = 4
				backgroundview.clipsToBounds = true
			}

		}

		// キャンセルボタンの設定
		let font = UIFont.systemFont(ofSize: 14)
		let textColor = UIColor.white
        let attr: [NSAttributedString.Key : Any] = [.font : font, .foregroundColor: textColor]
		UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attr, for: .normal)
		UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attr, for: .highlighted)

		showsCancelButton = true
	}
}


/*
extension MHSearchBarView: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.showsCancelButton = true
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		searchBar.showsCancelButton = false
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		//		isSearching = false
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

		guard let keyWord = searchBar.text else {
			return
		}

		if keyWord.count > 0 {
			//			hideSearchBar(completion: {
			//				if self.isSearching {
			//					self.isSearching = false
			//					self.showSearchResult(keyWord: keyWord)
			//				}
			//			})
		}
	}
}

*/
