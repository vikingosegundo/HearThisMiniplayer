//
//  ArtistsListDatasourceSpec.swift
//  ArtistsListDatasourceSpec
//
//  Created by Manuel Meyer on 17.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Quick
import Nimble
@testable import HearThis
import HearThisAPI


class ArtistsListDatasourceSpec: QuickSpec {
    var sut: ArtistsListDatasource!

    override func spec() {
        
        var tableView: UITableView!
        var artistsResource: ArtistsResourceType!
        beforeEach {
            tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: 320, height: 480))
            artistsResource = ArtistsResourceMock(artists:
                [
                    Artist(fromAPIModel: ArtistAPIModel(id: 42, name: "Groby", avatarURL: "https://www.groby.com", permalink: "groby")),
                    Artist(fromAPIModel: ArtistAPIModel(id: 45, name: "Bert", avatarURL: "https://www.bert.com", permalink: "bert"))
                ]
            )
            self.sut = try! ArtistsListDatasource(tableView: tableView, artistsResource: artistsResource)
        }
        
        context("Artists list") {
            
            it("contains 2 artists"){
                tableView.reloadData()
                let number = tableView.numberOfRows(inSection: 0)
                expect(number).to(equal(2))
                
            }
        }
    }
}
