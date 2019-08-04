/**
 *  Copyright (C) 2010-2019 The Catrobat Team
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

@objc class CatrobatSetup: NSObject {

    @objc public static func registeredBricks() -> [BrickProtocol] {
        var bricks: [BrickProtocol] = [
            StartScript(),
            WhenScript(),
            WhenTouchDownScript(),
            BroadcastScript(),
            WaitBrick(),
            BroadcastBrick(),
            BroadcastWaitBrick(),
            NoteBrick(),
            ForeverBrick(),
            IfLogicBeginBrick(),
            IfLogicElseBrick(),
            IfLogicEndBrick(),
            IfThenLogicBeginBrick(),
            IfThenLogicEndBrick(),
            WaitUntilBrick(),
            RepeatBrick(),
            RepeatUntilBrick(),
            LoopEndBrick(),
            PlaceAtBrick(),
            SetXBrick(),
            SetYBrick(),
            ChangeXByNBrick(),
            ChangeYByNBrick(),
            IfOnEdgeBounceBrick(),
            MoveNStepsBrick(),
            TurnLeftBrick(),
            TurnRightBrick(),
            PointInDirectionBrick(),
            PointToBrick(),
            GlideToBrick(),
            GoNStepsBackBrick(),
            ComeToFrontBrick(),
            VibrationBrick(),
            SetLookBrick(),
            SetBackgroundBrick(),
            NextLookBrick(),
            PreviousLookBrick(),
            SetSizeToBrick(),
            ChangeSizeByNBrick(),
            HideBrick(),
            ShowBrick(),
            SetTransparencyBrick(),
            ChangeTransparencyByNBrick(),
            SetBrightnessBrick(),
            ChangeBrightnessByNBrick(),
            SetColorBrick(),
            ChangeColorByNBrick(),
            ClearGraphicEffectBrick(),
            FlashBrick(),
            CameraBrick(),
            ChooseCameraBrick(),
            SayBubbleBrick(),
            SayForBubbleBrick(),
            ThinkBubbleBrick(),
            ThinkForBubbleBrick(),
            PlaySoundBrick(),
            StopAllSoundsBrick(),
            SetVolumeToBrick(),
            ChangeVolumeByNBrick(),
            SpeakBrick(),
            SpeakAndWaitBrick(),
            SetVariableBrick(),
            ChangeVariableBrick(),
            ShowTextBrick(),
            HideTextBrick(),
            AddItemToUserListBrick(),
            DeleteItemOfUserListBrick(),
            InsertItemIntoUserListBrick(),
            ReplaceItemInUserListBrick(),
            ArduinoSendDigitalValueBrick(),
            ArduinoSendPWMValueBrick()
        ]

        if isPhiroEnabled() {
            bricks.append(PhiroMotorStopBrick())
            bricks.append(PhiroMotorMoveForwardBrick())
            bricks.append(PhiroMotorMoveBackwardBrick())
            bricks.append(PhiroPlayToneBrick())
            bricks.append(PhiroRGBLightBrick())
            bricks.append(PhiroIfLogicBeginBrick())
        }

        return bricks
    }

    @objc public static func registeredBrickCategories() -> [BrickCategory] {
        var categories = [
            BrickCategory(type: kBrickCategoryType.controlBrick, name: kLocalizedControl, color: UIColor.controlBrickOrange(), strokeColor: UIColor.controlBrickStroke()),
            BrickCategory(type: kBrickCategoryType.motionBrick, name: kLocalizedMotion, color: UIColor.motionBrickBlue(), strokeColor: UIColor.motionBrickStroke()),
            BrickCategory(type: kBrickCategoryType.lookBrick, name: kLocalizedLooks, color: UIColor.lookBrickGreen(), strokeColor: UIColor.lookBrickStroke()),
            BrickCategory(type: kBrickCategoryType.soundBrick, name: kLocalizedSound, color: UIColor.soundBrickViolet(), strokeColor: UIColor.soundBrickStroke()),
            BrickCategory(type: kBrickCategoryType.variableBrick, name: kLocalizedVariables, color: UIColor.varibaleBrickRed(), strokeColor: UIColor.variableBrickStroke())
        ]

        let favouritesAvailable = Util.getBrickInsertionDictionaryFromUserDefaults()?.count ?? 0 >= kMinFavouriteBrickSize

        if favouritesAvailable {
            categories.prepend(BrickCategory(type: kBrickCategoryType.favouriteBricks, name: kLocalizedFrequentlyUsed, color: UIColor.controlBrickOrange(), strokeColor: UIColor.controlBrickStroke()))
        }

        if isArduinoEnabled() {
            categories.append(BrickCategory(type: kBrickCategoryType.arduinoBrick, name: kLocalizedArduino, color: UIColor.arduinoBrick(), strokeColor: UIColor.arduinoBrickStroke()))
        }

        if isPhiroEnabled() {
            categories.append(BrickCategory(type: kBrickCategoryType.phiroBrick, name: kLocalizedPhiro, color: UIColor.phiroBrick(), strokeColor: UIColor.phiroBrickStroke()))
        }

        return categories
    }

    public static func registeredSensors(sceneSize: CGSize,
                                         motionManager: MotionManager,
                                         locationManager: LocationManager,
                                         faceDetectionManager: FaceDetectionManager,
                                         audioManager: AudioManagerProtocol,
                                         touchManager: TouchManagerProtocol,
                                         bluetoothService: BluetoothService) -> [Sensor] {
        return [
            LoudnessSensor(audioManagerGetter: { audioManager }),
            InclinationXSensor(motionManagerGetter: { motionManager }),
            InclinationYSensor(motionManagerGetter: { motionManager }),
            AccelerationXSensor(motionManagerGetter: { motionManager }),
            AccelerationYSensor(motionManagerGetter: { motionManager }),
            AccelerationZSensor(motionManagerGetter: { motionManager }),
            CompassDirectionSensor(locationManagerGetter: { locationManager }),
            LatitudeSensor(locationManagerGetter: { locationManager }),
            LongitudeSensor(locationManagerGetter: { locationManager }),
            LocationAccuracySensor(locationManagerGetter: { locationManager }),
            AltitudeSensor(locationManagerGetter: { locationManager }),
            FingerTouchedSensor(touchManagerGetter: { touchManager }),
            FingerXSensor(touchManagerGetter: { touchManager }),
            FingerYSensor(touchManagerGetter: { touchManager }),
            LastFingerIndexSensor(touchManagerGetter: { touchManager }),

            DateYearSensor(),
            DateMonthSensor(),
            DateDaySensor(),
            DateWeekdaySensor(),
            TimeHourSensor(),
            TimeMinuteSensor(),
            TimeSecondSensor(),

            FaceDetectedSensor(faceDetectionManagerGetter: { faceDetectionManager }),
            FaceSizeSensor(sceneSize: sceneSize, faceDetectionManagerGetter: { faceDetectionManager }),
            FacePositionXSensor(sceneSize: sceneSize, faceDetectionManagerGetter: { faceDetectionManager }),
            FacePositionYSensor(sceneSize: sceneSize, faceDetectionManagerGetter: { faceDetectionManager }),

            PhiroFrontLeftSensor(bluetoothServiceGetter: { bluetoothService }),
            PhiroFrontRightSensor(bluetoothServiceGetter: { bluetoothService }),
            PhiroBottomLeftSensor(bluetoothServiceGetter: { bluetoothService }),
            PhiroBottomRightSensor(bluetoothServiceGetter: { bluetoothService }),
            PhiroSideLeftSensor(bluetoothServiceGetter: { bluetoothService }),
            PhiroSideRightSensor(bluetoothServiceGetter: { bluetoothService }),

            PositionXSensor(),
            PositionYSensor(),
            TransparencySensor(),
            BrightnessSensor(),
            ColorSensor(),
            SizeSensor(),
            RotationSensor(),
            LayerSensor(),
            BackgroundNumberSensor(),
            BackgroundNameSensor(),
            LookNumberSensor(),
            LookNameSensor()
        ]
    }

    public static func registeredFunctions(touchManager: TouchManagerProtocol, bluetoothService: BluetoothService) -> [Function] {
        return [
            SinFunction(),
            CosFunction(),
            TanFunction(),
            LnFunction(),
            LogFunction(),
            PiFunction(),
            SqrtFunction(),
            RandFunction(),
            AbsFunction(),
            RoundFunction(),
            ModFunction(),
            AsinFunction(),
            AcosFunction(),
            AtanFunction(),
            ExpFunction(),
            PowFunction(),
            FloorFunction(),
            CeilFunction(),
            MaxFunction(),
            MinFunction(),
            TrueFunction(),
            FalseFunction(),
            JoinFunction(),
            LetterFunction(),
            LengthFunction(),
            ElementFunction(),
            NumberOfItemsFunction(),
            ContainsFunction(),
            MultiFingerXFunction(touchManagerGetter: { touchManager }),
            MultiFingerYFunction(touchManagerGetter: { touchManager }),
            MultiFingerTouchedFunction(touchManagerGetter: { touchManager }),
            ArduinoAnalogPinFunction(bluetoothServiceGetter: { bluetoothService }),
            ArduinoDigitalPinFunction(bluetoothServiceGetter: { bluetoothService })
        ]
    }

    public static func registeredOperators() -> [Operator] {
        return [
            AndOperator(),
            DivideOperator(),
            EqualOperator(),
            GreaterOrEqualOperator(),
            GreaterThanOperator(),
            MinusOperator(),
            MultOperator(),
            NotEqualOperator(),
            OrOperator(),
            PlusOperator(),
            SmallerOrEqualOperator(),
            SmallerThanOperator(),
            NotOperator()
        ]
    }

    private static func isArduinoEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: kUseArduinoBricks)
    }

    private static func isPhiroEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: kUsePhiroBricks)
    }
}
