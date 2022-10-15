//
//  Bindable.swift
//  UpcomingMovies
//
//  Created by Alonso on 1/10/22.
//  Copyright © 2022 Alonso. All rights reserved.
//

import Dispatch

protocol Bindable {

    associatedtype Model

    func bind(_ listener: @escaping ((Model) -> Void), on dispatchQueue: DispatchQueue?)
    func bindAndFire(_ listener: @escaping ((Model) -> Void), on dispatchQueue: DispatchQueue?)

}

extension Bindable {

    func asAnyBindable() -> AnyBindable<Model> {
        return AnyBindable(self)
    }

}