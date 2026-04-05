//
//  LocationSimulator.swift
//  RickAndMortyAppPro
//
// Created by Brayan Gutierrez Juarez on 04/04/26.
//

import Foundation
import CoreLocation

struct LocationSimulator {
    static func simulatedCoordinate(for id: Int) -> CLLocationCoordinate2D {
        let baseLat = 20.0
        let baseLon = -100.0
        let offset = Double(id % 10)
        return CLLocationCoordinate2D(latitude: baseLat + offset, longitude: baseLon + offset)
    }
}
