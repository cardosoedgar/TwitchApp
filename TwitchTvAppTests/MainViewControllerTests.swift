//
//  MainViewControllerTests.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 06/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Nimble
import Quick
import KIF

@testable import TwitchTvApp

extension GameManager {
    class func getMockedManager(shouldLoad: Bool) -> GameManager {
        let gameManager = GameManager()
        let coreDataStackMock = CoreDataStackManager()
        let twitchRequest = TwitchRequest()
        
        coreDataStackMock.context = CoreDataStackManager.mockManagedObjectContext()
        
        if shouldLoad {
            let json = Json(json: JsonHelper.readJson(name: "valid"))
            twitchRequest.networkRequest = NetworkRequestMock(json: json)
        } else {
            twitchRequest.networkRequest = NetworkRequestMock(error: true)
        }
        
        gameManager.coreDataStack = coreDataStackMock
        gameManager.twitchRequest = twitchRequest
        
        return gameManager
    }
}

class MainViewControllerTest: QuickSpec {
    override func spec() {
        describe("MainViewController") {
            
            var navController: UINavigationController?
            var mainController: MainViewController?
            
            beforeSuite {
                let window = UIApplication.shared.keyWindow?.rootViewController
                navController = window as? UINavigationController
                mainController = navController?.viewControllers[0] as? MainViewController
                mainController?.gameManager = GameManager.getMockedManager(shouldLoad: true)
                mainController?.loadGames()
            }
            
            it("should have 5 games") {
                let count = mainController?.collectionView.numberOfItems(inSection: 0)
                expect(count) == 5
            }
            
            it("should click first item and go to detail view controller") {
                self.tester().tapItem(at: IndexPath(row: 0, section: 0), in: mainController?.collectionView)
                self.tester().waitForView(withAccessibilityIdentifier: "game_image")
                
                //go back to main
                navController?.popViewController(animated: true)
            }
            
            it("should show an alert for bad connection") {
                mainController?.gameManager = GameManager.getMockedManager(shouldLoad: false)
                mainController?.loadGames()
                
                self.tester().tapView(withAccessibilityLabel: "Ok")
            }
        }
    }
}
