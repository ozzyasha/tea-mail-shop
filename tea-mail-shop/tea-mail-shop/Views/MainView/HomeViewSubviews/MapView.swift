//
//  MapView.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 22.06.24.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    let teamailLocation = CLLocationCoordinate2D(
        latitude: 53.91109927437244,
        longitude: 27.579245682647045)
    
    var body: some View {
        Map(initialPosition: .camera(MapCamera(centerCoordinate: teamailLocation, distance: 1000))) {
            Marker("Чайная Почта", coordinate: teamailLocation)
                .tint(Color.accent)
        }
    }
}

#Preview {
    MapView()
}
