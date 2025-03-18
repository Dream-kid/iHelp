//
//  ViewState.swift
//  IHelp
//
//  Created by Md Mehedi Hasan on 3/6/24.
//

import Combine

enum ViewState {
    case idle
    case loading
    case success
    case failure(Error)
}
