//
//  BehaviorBindableProtocol.swift
//  UpcomingMovies
//
//  Created by Alonso on 27/11/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Dispatch

protocol BehaviorBindableProtocol {

    associatedtype Model

    var value: Model { get set }

    func bind(_ listener: @escaping ((Model) -> Void), on dispatchQueue: DispatchQueue?)
    func bindAndFire(_ listener: @escaping ((Model) -> Void), on dispatchQueue: DispatchQueue)

}
