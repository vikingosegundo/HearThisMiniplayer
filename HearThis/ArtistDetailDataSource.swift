//
//  ArtistDetailDataSource.swift
//  HearThis
//
//  Created by Manuel Meyer on 20.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit
import OFAPopulator

class TracksDataProvider:NSObject, OFASectionDataProvider {
    init(artist: Artist, tracksResource: TrackResourceType, reload: @escaping ()-> Void) {
        self.artist = artist
        self.reload = reload
        self.tracksResource = tracksResource
        super.init()
        fetch()
    }

    
    var sectionObjects: [Any]! = []
    let reload: () -> Void
    private let artist: Artist
    private let tracksResource: TrackResourceType
    
    private func fetch(){
        
        tracksResource.tracksForArtist(self.artist) {
            result in
            switch result {
            case .success(let tracks):
                self.sectionObjects = tracks
            case .error(let error):
                print(error)
            }
            self.reload()
        }
    }
    
}


@objc
protocol TrackSelectionObserver: class {
    func selected(_ track: Track, on: IndexPath)
}

class ArtistDetailDataSource {

    init(tableView: UITableView, artist: Artist, tracksResource: TrackResourceType) {
        self.tableView = tableView
        self.tracksResource = tracksResource
        self.artist = artist
        configure()
    }
    
 
    private let tracksResource: TrackResourceType
    private let tableView: UITableView
    private let artist: Artist
    private var populator: OFAViewPopulator?

    private var selectionObservers = NSHashTable<TrackSelectionObserver>(options: .weakMemory)
    
    func registerSelectionObserver(observer: TrackSelectionObserver) {
        selectionObservers.add(observer)
    }
    private func configure(){
        
        let dataProvider = TracksDataProvider(artist: self.artist, tracksResource: tracksResource, reload: {self.tableView.reloadData()})
        
        if let section1Populator = OFASectionPopulator(parentView: self.tableView, dataProvider: dataProvider, cellIdentifier: {_ in return "Cell1"}, cellConfigurator: {obj, view, indexPath in
            if let cell = view as? UITableViewCell,
                let track = obj as? Track{
                cell.textLabel?.text = track.title
            }
        }) {
            section1Populator.objectOnCellSelected = {
                obj, view, indexPath in
                if let track = obj as? Track, let indexPath = indexPath {
                    for observer:TrackSelectionObserver in self.selectionObservers.allObjects {
                        observer.selected(track, on: indexPath)
                    }
                }
            }
            
            self.populator = OFAViewPopulator(sectionPopulators: [section1Populator])
        }
    
    }
}
