
import UIKit
import RxSwift

class SearchViewController: UIViewController {

	@IBOutlet weak var navigationTitleLabel: UILabel!
	@IBOutlet weak var searchBar: SearchBar!
	@IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!

	@IBAction func searchButtonTapped(_ sender: UIButton) {
		hide()
	}

	let viewModel = SearchViewModel()

	private var keyWord: String? = nil
	private var placeholder: String? = nil
	private let disposeBag = DisposeBag()

	init(title: String, placeholder: String, keyWord: String? = nil) {
		super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
		modalPresentationStyle = .overCurrentContext
		self.title = title
		self.keyWord = keyWord
		self.placeholder = placeholder
	}

	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		navigationTitleLabel.text = title
		searchBar.text = keyWord
		searchBar.placeholder = placeholder
		searchBar.delegate = self
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		show()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension SearchViewController: UISearchBarDelegate {
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		searchBar.showsCancelButton = true
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		searchBar.showsCancelButton = false
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		hide()
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

		guard let keyWord = searchBar.text else {
			return
		}

		if keyWord.count > 0 {
			hideSearchBar(completion: {
				self.dismiss(animated: false) {
					// キーワードを呼び出し元のViewControllerに渡す
					self.viewModel.execute(keyWord: keyWord)
				}
			})
		}
	}

	private func hide() {
		hideSearchBar(completion: {
			self.dismiss(animated: false, completion: nil)
		})
	}

	private func show() {
		showSearchBar(completion: nil)
	}

	private func showSearchBar(completion block: (() -> Void)?) {
		if let textField = self.searchBar.value(forKey: "_searchField") as? UITextField {
			textField.becomeFirstResponder()
		}

		DispatchQueue.main.asyncAfter(deadline:.now() + 0.3){
			self.updateSearchBarConstraint(constant: 0)
			block?()
		}
	}

	private func hideSearchBar(completion block: (() -> Void)?) {
		updateSearchBarConstraint(constant: -searchBar.frame.height)
		DispatchQueue.main.asyncAfter(deadline:.now() + 0.3){
			self.view.endEditing(true)
			block?()
		}
	}

	private func updateSearchBarConstraint(constant: CGFloat) {
		searchBarTopConstraint.constant = constant

		UIView.animate(withDuration: 0.2, animations: {
			self.view.layoutIfNeeded()
		})
	}
}
