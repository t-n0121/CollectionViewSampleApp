
import Foundation
import RxSwift

struct SearchViewModel {
	private let searchExecuteSubject = PublishSubject<String>()

	var searchExecute: Observable<String> {
		return searchExecuteSubject
	}

	func execute(keyWord: String) {
		searchExecuteSubject.onNext(keyWord)
	}
}
