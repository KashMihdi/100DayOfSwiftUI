//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Kasharin Mikhail on 02.10.2023.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    enum AuthError {
        case badAuth, noBio, none
        
        var description: String {
            switch self {
            case .badAuth: return "Login not confirmed. Repeat?"
            case .noBio: return "Biometrics error"
            case .none: return "Success"
            }
        }
    }
    
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
        )
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var authError: AuthError = .none
        @Published var showAlertError = false
        
        let savePath = FileManager.documentDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = .init()
            }
        }
        
        private func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func addLocation() {
            let newLocation = Location(
                id: UUID(),
                name: "New location",
                description: "",
                latitude: mapRegion.center.latitude,
                longitude: mapRegion.center.longitude
            )
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedLocation = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedLocation) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    if success {
                        Task { @MainActor in
                                self.isUnlocked = true
                                self.authError = .none
                            }
                    } else {
                        self.authenticate()
                    }
                }
            } else {
                authError = .noBio
                showAlertError = true
            }
        }
    }
}
