//
//  ArtistsListDataSource.swift
//  HearThis
//
//  Created by Manuel Meyer on 17.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit
import OFAPopulator

class DataProvider:NSObject, OFASectionDataProvider {
    init(artistsResource: ArtistsResourceType, reload: @escaping ()-> Void) {
        self.reload = reload
        self.artistsResource = artistsResource
        super.init()
        fetch()
    }
    
    var sectionObjects: [Any]! = []
    let reload: () -> Void
    private let artistsResource: ArtistsResourceType
    
    private func fetch(){
        artistsResource.topArtists { (result) in
            switch result {
            case .success(let artists):
                self.sectionObjects = artists
            case .error(let error):
                print(error)
            }
            self.reload()
        }
    }

}


@objc
protocol ArtistSelectionObserver: class {
    func selected(_ artist: Artist, on: IndexPath)
}

class ArtistsListDatasource {

    init(tableView: UITableView, artistsResource: ArtistsResourceType) {
        self.tableView = tableView
        self.artistsResource = artistsResource
        configure()
    }
    
    private let artistsResource: ArtistsResourceType
    private let tableView: UITableView
    private var populator: OFAViewPopulator?
    
    private var selectionObservers = NSHashTable<ArtistSelectionObserver>()
    func registerSelectionObserver(observer: ArtistSelectionObserver) {
        selectionObservers.add(observer)
    }
    
    private func configure(){
        let dataProvider = DataProvider(artistsResource: artistsResource, reload: { self.tableView.reloadData()})
        if let section1Populator = OFASectionPopulator(parentView: tableView, dataProvider: dataProvider, cellIdentifier: {
            _ in
            return "Cell1"
        }, cellConfigurator: {
            obj, cellView, indexPath in
            if let cell = cellView as? UITableViewCell, let obj = obj as? Artist {
                cell.textLabel?.text = "\(obj.username)"
            }
        }){
            section1Populator.objectOnCellSelected = {
                (obj, cell, indexPath) -> Void in
                if let artist = obj as? Artist, let indexPath = indexPath {
                    for observer:ArtistSelectionObserver in self.selectionObservers.allObjects {
                        observer.selected(artist, on: indexPath)
                    }
                }
            }
            self.populator = OFAViewPopulator(sectionPopulators: [section1Populator])
        }
    }
}
