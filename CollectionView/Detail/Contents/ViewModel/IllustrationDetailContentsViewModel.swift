//
//  IllustrationDetailContentsViewModel.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/09/07.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import Foundation
import RxSwift

struct IllustrationDetailContentsViewModel {
	private let selectedRelatedIllustEventSubject = PublishSubject<Int>()
	private let selectedHashTagEventSubject = PublishSubject<String>()

	var selectedRelatedIllustEvent: Observable<Int> {
		return selectedRelatedIllustEventSubject
	}

	var selectedHashTagEvent: Observable<String> {
		return selectedHashTagEventSubject
	}

	func selectedRelatedIllust(illustID: Int) {
		selectedRelatedIllustEventSubject.onNext(illustID)
	}

	func selectedHashTag(tag: String) {
		selectedHashTagEventSubject.onNext(tag)
	}
}
