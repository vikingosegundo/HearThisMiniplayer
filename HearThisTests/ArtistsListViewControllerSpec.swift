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
        beforeEach {
            self.sut = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArtistsListViewController") as! ArtistsListViewController
            self.sut.hearThisAPI = HearThisAPIMock()
            _ = self.sut.view
        }
        
        context("Artists list") {
            
            it("contains 2 artists"){
                self.sut.tableView.reloadData()
                let number = self.sut.tableView.numberOfRows(inSection: 0)
                expect(number).to(equal(2))
            }
            
            context("artists selection") {
                it("tapping row selects artist"){
    
                }
            }
        }
    }
}
