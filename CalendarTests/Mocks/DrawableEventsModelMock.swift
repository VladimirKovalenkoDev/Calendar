//
//  DrawableEventsModelMock.swift
//  CalendarTests
//
//  Created by vladimir_kovalenko on 5/25/22.
//

import Foundation
@testable import Calendar

enum DrawableEventsModelMock {
    static func obtainDrawableEvents() -> [DrawableEventModel] {
        [
            DrawableEventModel(
                name: "Talk",
                start: 8.0,
                duration: 1.0,
                master: EventViewModel(event: Events())
            ),
            DrawableEventModel(
                name: "Meetup",
                start: 11.0,
                duration: 8.0,
                master: EventViewModel(event: Events())
            ),
            DrawableEventModel(
                name: "Sleep",
                start: 16.0,
                duration: 3.0,
                master: EventViewModel(event: Events())
            )
        ]
    }
    
    static func obtaintSortedDrawableEvents() -> [[DrawableEventModel]] {
        [
            [
                DrawableEventModel(
                    name: "Talk",
                    start: 8.0,
                    duration: 1.0,
                    master: EventViewModel(event: Events())
                ),
                DrawableEventModel(
                    name: "Meetup",
                    start: 11.0,
                    duration: 8.0,
                    master: EventViewModel(event: Events())
                )
            ],
            [
                DrawableEventModel(
                    name: "Sleep",
                    start: 16.0,
                    duration: 3.0,
                    master: EventViewModel(event: Events())
                )
            ]
        ]
    }
}
