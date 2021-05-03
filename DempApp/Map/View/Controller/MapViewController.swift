//
//  MapViewController.swift
//  DempApp
//
//  Created by Hamza Almass on 5/3/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    enum ShowMap {
        case showAllShop
        case showSingleShop
    }
    
    // For show only single shop on the map
    var shopMapOption: ShowMap = .showSingleShop
    var didReceivedShopData: ShopData? {
        didSet {
            guard let shopData = didReceivedShopData else { return }
            mapViewModel = MapViewModel(shopData: shopData, shopsData: nil)
        }
    }
    
    // For show all shops on the map
    var didRecivedShopsData: [ShopData]? {
        didSet {
            guard let shopsData = didRecivedShopsData else {return}
            mapViewModel = MapViewModel(shopData: nil, shopsData: shopsData)
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    private var mapViewModel: MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if shopMapOption == .showSingleShop {
            setAnnotationPoint()
        }else{
            setAnnotationsForAllMaps()
        }
    }
    fileprivate func setAnnotationPoint(){
        let annotation = MKPointAnnotation()
        annotation.title = mapViewModel.shopName
        annotation.subtitle = mapViewModel.shopNearsetPoint
        annotation.coordinate = CLLocationCoordinate2D(latitude: mapViewModel.shopLatitude, longitude: mapViewModel.shopLongtiude)
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 70000, longitudinalMeters: 70000)
        mapView.setRegion(region, animated: true)
    }
    fileprivate func setAnnotationsForAllMaps(){
        mapViewModel.getMapViewModels().forEach({
            let annotation = MKPointAnnotation()
            annotation.title = $0.shopName
            annotation.subtitle = $0.shopNearsetPoint
            annotation.coordinate = CLLocationCoordinate2D(latitude: $0.shopLatitude, longitude: $0.shopLongtiude)
            mapView.addAnnotation(annotation)
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 70000, longitudinalMeters: 70000)
            mapView.setRegion(region, animated: true)
        })

    }
    
}
