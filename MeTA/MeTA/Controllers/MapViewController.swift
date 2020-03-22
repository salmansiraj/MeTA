//
//  MapViewController.swift
//  MeTA
//
//  Created by Kevin J. Zheng on 2/28/20.
//  Copyright © 2020 senior design. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet private weak var mapCenterPinImage: UIImageView!
    @IBOutlet private weak var pinImageVerticalConstraint: NSLayoutConstraint!
    private let locationManager = CLLocationManager()
    private var searchedTypes = ["subway_station", "train_station", "transit_station", "point_of_interest", "establishment"]
    private let dataProvider = GoogleDataProvider()
    private let searchRadius: Double = 1000
  
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {

      let geocoder = GMSGeocoder()

      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        self.addressLabel.unlock()

        guard let address = response?.firstResult(), let lines = address.lines else {
          return
        }

        self.addressLabel.text = lines.joined(separator: "\n")

        let labelHeight = self.addressLabel.intrinsicContentSize.height
        self.mapView.padding = UIEdgeInsets(top: self.view.safeAreaInsets.top, left: 0,
                                            bottom: labelHeight, right: 0)
//        UIView.animate(withDuration: 0.25) {
//          self.pinImageVerticalConstraint.constant = ((labelHeight - self.view.safeAreaInsets.top) * 0.5)
//          self.view.layoutIfNeeded()
//        }
      }
    }

    private func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
      mapView.clear()
      dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedTypes) { places in
        places.forEach {
          let marker = PlaceMarker(place: $0)
          marker.map = self.mapView
        }
      }
    }
    
    @IBAction func refreshPlaces(_ sender: Any) {
        fetchNearbyPlaces(coordinate: mapView.camera.target)
    }
    
}

extension MapViewController: TypesTableViewControllerDelegate {
  func typesController(_ controller: TypesTableViewController, didSelectTypes types: [String]) {
    searchedTypes = controller.selectedTypes.sorted()
    dismiss(animated: true)
    fetchNearbyPlaces(coordinate: mapView.camera.target)
  }
}

extension MapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    guard status == .authorizedWhenInUse else {
      return
    }
    locationManager.startUpdatingLocation()

    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }

    mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    locationManager.stopUpdatingLocation()
    fetchNearbyPlaces(coordinate: location.coordinate)
  }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }

    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
      addressLabel.lock()

    }

    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
       guard let placeMarker = marker as? PlaceMarker else {
         return nil
       }
       guard let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView else {
         return nil
       }

       infoView.nameLabel.text = placeMarker.place.name
       if let photo = placeMarker.place.photo {
         infoView.placePhoto.image = photo
       } else {
         infoView.placePhoto.image = UIImage(named: "generic")
       }

       return infoView
     }

}
