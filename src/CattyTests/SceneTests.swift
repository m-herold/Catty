/**
 *  Copyright (C) 2010-2020 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

import XCTest

@testable import Pocket_Code

final class SceneTests: XCTestCase {

    var screenSize: CGSize!

    var pocketCodeCenter: CGPoint!
    var pocketCodeBottomLeft: CGPoint!
    var pocketCodeBottomRight: CGPoint!
    var pocketCodeTopLeft: CGPoint!
    var pocketCodeTopRight: CGPoint!

    var sceneCenter: CGPoint!
    var sceneBottomLeft: CGPoint!
    var sceneBottomRight: CGPoint!
    var sceneTopLeft: CGPoint!
    var sceneTopRight: CGPoint!

    override func setUp() {
        super.setUp()
        self.screenSize = Util.screenSize(false)

        self.pocketCodeCenter = CGPoint(x: 0, y: 0)
        self.pocketCodeBottomLeft = CGPoint(x: -240, y: -400)
        self.pocketCodeBottomRight = CGPoint(x: 240, y: -400)
        self.pocketCodeTopLeft = CGPoint(x: -240, y: 400)
        self.pocketCodeTopRight = CGPoint(x: 240, y: 400)

        self.sceneCenter = CGPoint(x: 240, y: 400)
        self.sceneBottomLeft = CGPoint(x: 0, y: 0)
        self.sceneBottomRight = CGPoint(x: 480, y: 0)
        self.sceneTopLeft = CGPoint(x: 0, y: 800)
        self.sceneTopRight = CGPoint(x: 480, y: 800)
    }

    func testTouchConversionCenter() {
        let scaledScene = SceneBuilder(project: ProjectMock(width: self.screenSize.width * 2, andHeight: self.screenSize.height * 2)).build()
        let scaledSceneCenter = CGPoint(x: self.screenSize.width / 2, y: self.screenSize.height / 2)
        let convertedCenter = CBSceneHelper.convertTouchCoordinateToPoint(coordinate: scaledSceneCenter, sceneSize: scaledScene.size)
        XCTAssertEqual(convertedCenter, self.pocketCodeCenter, "The Scene Center is not correctly calculated")
    }

    func testTouchConversionCenterNoScale() {
        let scaledScene = SceneBuilder(project: ProjectMock(width: self.screenSize.width, andHeight: self.screenSize.height)).build()
        let scaledSceneCenter = CGPoint(x: self.screenSize.width / 2, y: self.screenSize.height / 2)
        let convertedCenter = CBSceneHelper.convertTouchCoordinateToPoint(coordinate: scaledSceneCenter, sceneSize: scaledScene.size)
        XCTAssertEqual(convertedCenter, self.pocketCodeCenter, "The Scene Center is not correctly calculated")
    }

    func testTouchConversionBottomLeft() {
        let scaledScene = SceneBuilder(project: ProjectMock(width: self.screenSize.width * 2, andHeight: self.screenSize.height * 2)).build()
        let scaledSceneBottomLeft = CGPoint(x: 0, y: self.screenSize.height)
        let pocketCodeBottomLeft = CGPoint(x: scaledScene.size.width / 2 * -1, y: scaledScene.size.height / 2 * -1)

        let convertedBottomLeft = CBSceneHelper.convertTouchCoordinateToPoint(coordinate: scaledSceneBottomLeft, sceneSize: scaledScene.size)
        XCTAssertEqual(convertedBottomLeft, pocketCodeBottomLeft, "The Bottom Left is not correctly calculated")
    }

    func testTouchConversionBottomRight() {
        let scaledScene = SceneBuilder(project: ProjectMock(width: self.screenSize.width * 2, andHeight: self.screenSize.height * 2)).build()
        let scaledSceneBottomRight = CGPoint(x: self.screenSize.width, y: self.screenSize.height)
        let pocketCodeBottomRight = CGPoint(x: scaledScene.size.width / 2, y: scaledScene.size.height / 2 * -1)

        let convertedBottomRight = CBSceneHelper.convertTouchCoordinateToPoint(coordinate: scaledSceneBottomRight, sceneSize: scaledScene.size)
        XCTAssertEqual(convertedBottomRight, pocketCodeBottomRight, "The Bottom Right is not correctly calculated")
    }

    func testTouchConversionTopLeft() {
        let scaledScene = SceneBuilder(project: ProjectMock(width: self.screenSize.width * 2, andHeight: self.screenSize.height * 2)).build()
        let scaledSceneTopLeft = CGPoint(x: 0, y: 0)
        let pocketCodeTopLeft = CGPoint(x: scaledScene.size.width / 2 * -1, y: scaledScene.size.height / 2)

        let convertedTopLeft = CBSceneHelper.convertTouchCoordinateToPoint(coordinate: scaledSceneTopLeft, sceneSize: scaledScene.size)
        XCTAssertEqual(convertedTopLeft, pocketCodeTopLeft, "The Top Left is not correctly calculated")
    }

    func testTouchConversionTopRight() {
        let scaledScene = SceneBuilder(project: ProjectMock(width: self.screenSize.width * 2, andHeight: self.screenSize.height * 2)).build()
        let scaledSceneTopRight = CGPoint(x: self.screenSize.width, y: 0)
        let pocketCodeTopRight = CGPoint(x: scaledScene.size.width / 2, y: scaledScene.size.height / 2)

        let convertedTopRight = CBSceneHelper.convertTouchCoordinateToPoint(coordinate: scaledSceneTopRight, sceneSize: scaledScene.size)
        XCTAssertEqual(convertedTopRight, pocketCodeTopRight, "The Top Right is not correctly calculated")
    }

    func testVariableLabel() {
        let project = ProjectMock(width: self.screenSize.width, andHeight: self.screenSize.height)
        let scene = SceneBuilder(project: project).build()

        let userVariable = UserVariable(name: "testName")
        project.variables.programVariableList.add(userVariable)

        XCTAssertNil(userVariable.textLabel)
        XCTAssertTrue(scene.startProject())
        XCTAssertNotNil(userVariable.textLabel)
        XCTAssertTrue(userVariable.textLabel?.isHidden == true)
        XCTAssertEqual(SKLabelHorizontalAlignmentMode.left, userVariable.textLabel?.horizontalAlignmentMode)
        XCTAssertEqual(CGFloat(SpriteKitDefines.defaultLabelFontSize), userVariable.textLabel?.fontSize)
        XCTAssertEqual(0, userVariable.textLabel?.text?.count)
        scene.stopProject()
    }

    func testUpdate() {

        let scene = SceneBuilder(project: ProjectMock()).build()

        let spriteNode1 = CBSpriteNodeMock(spriteObject: SpriteObject())
        spriteNode1.name = "testObject1"
        scene.scheduler.registerSpriteNode(spriteNode1)

        let spriteNode2 = CBSpriteNodeMock(spriteObject: SpriteObject())
        spriteNode2.name = "testObject2"
        scene.scheduler.registerSpriteNode(spriteNode2)

        XCTAssertEqual(spriteNode1.updateMethodCallCount, 0)
        XCTAssertEqual(spriteNode2.updateMethodCallCount, 0)

        scene.update(CACurrentMediaTime())
        XCTAssertEqual(spriteNode1.updateMethodCallCount, 0)
        XCTAssertEqual(spriteNode2.updateMethodCallCount, 0)

        scene.update(CACurrentMediaTime())
        XCTAssertEqual(spriteNode1.updateMethodCallCount, 0)
        XCTAssertEqual(spriteNode2.updateMethodCallCount, 0)

        scene.update(CACurrentMediaTime())
        XCTAssertEqual(spriteNode1.updateMethodCallCount, 1)
        XCTAssertEqual(spriteNode2.updateMethodCallCount, 1)

        scene.update(CACurrentMediaTime())
        XCTAssertEqual(spriteNode1.updateMethodCallCount, 1)
        XCTAssertEqual(spriteNode2.updateMethodCallCount, 1)

        scene.update(CACurrentMediaTime())
        XCTAssertEqual(spriteNode1.updateMethodCallCount, 2)
        XCTAssertEqual(spriteNode2.updateMethodCallCount, 2)
    }
}
