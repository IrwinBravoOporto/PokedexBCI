//
//  PokedexBCIUITests.swift
//  PokedexBCIUITests
//
//  Created by Irwin Bravo Oporto on 2/04/25.
//

import XCTest

class PokedexBCIUITests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchEnvironment = [
            "XCUIApplicationBundleIdentifier": "nishi.PokedexBCI",
            "UITEST_MODE": "1"
        ]
        app.launchArguments = ["-UITesting"]
    }
    
    override func tearDownWithError() throws {
        // 1. Terminación segura
        try terminateAppIfNeeded()
        
        // 2. Limpieza
        app = nil
        try super.tearDownWithError()
    }
    
    private func terminateAppIfNeeded() throws {
        guard let strongApp = app else { return }
        
        // Verificar estado en el hilo principal
        var isRunning = false
        if Thread.isMainThread {
            isRunning = strongApp.state == .runningForeground
        } else {
            DispatchQueue.main.sync {
                isRunning = strongApp.state == .runningForeground
            }
        }
        
        if isRunning {
            strongApp.terminate()
            
            // Esperar confirmación
            let expectation = XCTNSPredicateExpectation(
                predicate: NSPredicate(format: "state != %d",
                                     XCUIApplication.State.runningForeground.rawValue),
                object: strongApp
            )
            
            let result = XCTWaiter().wait(for: [expectation], timeout: 2.0)
            if result != .completed {
                throw NSError(domain: "UITests", code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Failed to terminate app"])
            }
        }
    }
    
    func testAppLaunch() throws {
        app.launch()
        
        // Aumentar timeout para entornos lentos
        let runningExpectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "state == %d",
                                 XCUIApplication.State.runningForeground.rawValue),
            object: app
        )
        
        let result = XCTWaiter().wait(for: [runningExpectation], timeout: 15)
        XCTAssertEqual(result, .completed, "La aplicación no alcanzó estado runningForeground")
    }
}
