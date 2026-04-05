//
//  NetworkMonitor.swift
//  RickAndMortyAppPro
//
//  Created by Eduardo Geovanni Pérez Munguía on 04/04/26.
//

import Network
import SwiftUI
import Combine

final class NetworkMonitor: ObservableObject {

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    @Published var isConnected = true

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }

        monitor.start(queue: queue)
    }
}
