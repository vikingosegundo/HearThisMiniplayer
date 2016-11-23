//
//  ArtistsListViewControllerSpec.swift
//  HearThis
//
//  Created by Manuel Meyer on 22.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import HearThis



class ArtistsListViewControllerSpec: QuickSpec {
    var sut: ArtistsListViewController!
    
    override func spec() {
        
        context("instantiated from Storyboard"){
            beforeEach {
                self.sut = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArtistsListViewController") as! ArtistsListViewController
                self.sut.hearThisAPI = HearThisAPIMock(mockedData:
                    [
                        ArtistAPIModel(id: 23, name: "Tiffy", avatarURL: "https://tiffy.com", permalink: "tiffy"),
                        ArtistAPIModel(id: 13, name: "Herr von Blödefeld", avatarURL: "https://bloedefeld.com", permalink: "bloedefeld")
                    ])
                _ = self.sut.view
            }
            
            context("Artists list") {
                
                it("contains 2 artists"){
                    self.sut.tableView.reloadData()
                    let number = self.sut.tableView.numberOfRows(inSection: 0)
                    expect(number).to(equal(2))
                }
            }
        }
        
        context("manually setup"){
        
            beforeEach {
                self.sut = TestArtistsListViewController()
                
                self.sut.hearThisAPI = HearThisAPIMock(mockedData:
                    [
                        ArtistAPIModel(id: 23, name: "Tiffy", avatarURL: "https://tiffy.com", permalink: "tiffy"),
                        ArtistAPIModel(id: 13, name: "Herr von Blödefeld", avatarURL: "https://bloedefeld.com", permalink: "bloedefeld")
                    ]
                )
                self.sut.view = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
                self.sut.tableView = UITableView(frame: self.sut.view.bounds)
                self.sut.view.addSubview(self.sut.tableView)
                self.sut.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell1")
                _ = self.sut.view
                self.sut.tableView.reloadData()
            }
            
            context("Artists list") {
                
                context("artists selection") {
                    it("tapping row selects artist"){
                        self.sut.tableView.delegate?.tableView!(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        expect((self.sut as! TestArtistsListViewController).artist!.username).to(equal("Tiffy"))
                        
                        self.sut.tableView.delegate?.tableView!(self.sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        expect((self.sut as! TestArtistsListViewController).artist!.username).to(equal("Herr von Blödefeld"))
                    }
                }
            }
        }
        
        
    }
}
