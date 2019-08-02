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

    @objc public static func registeredScripts() -> [ScriptProtocol] {
        return [
            WhenScript(),
            WhenTouchDownScript()
        ]
    }

    @objc public static func registeredBricks() -> [BrickProtocol] {
        return [
            WaitBrick()
        ]
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
}
