//
//  IllustrationContentsViewModel.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/08/23.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import Foundation
import RxSwift

struct IllustrationContentsViewModel {
	private let selectedEventSubject = PublishSubject<IllustData>()

	var selectedEvent: Observable<IllustData> {
		return selectedEventSubject
	}

	func selected(illustData: IllustData) {
		selectedEventSubject.onNext(illustData)
	}
}
