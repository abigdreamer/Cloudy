import QtQuick 2.8
import QtLocation 5.9
import QtPositioning 5.8
import Application 1.0
import Application.Resources 1.0
import QtQuick.Dialogs 1.1

Item {
    id: map
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: weeksWeather.bottom
    anchors.bottom: parent.bottom
    
    Plugin {
        id: mapPlugin
        name: "mapboxgl"
    }
    
    MessageDialog {
        id: errorDialog
        title: "Oops"
    }
    PositionSource{
        id: positionSource
        active: false
        updateInterval: 2000
        onPositionChanged: {
            if (position && position.coordinate && valid
                    && typeof position !== "undefined"
                    && typeof position.coordinate !== "undefined"
                    && position.latitudeValid && position.longitudeValid) {
                stop()
                var coord = position.coordinate
                setMarkerCoord(coord)
                scrollToMarker()
                d.gpsPositionChangeCallback(coord)
            }
        }
        
        onSourceErrorChanged: {
            weatherPane.enabled = true
            if (active)
                stop()
            error = ""
            if (sourceError !== PositionSource.NoError)
                error = d.getGpsErrorString(sourceError)
        }
    }

    Map {
        id: mapView
        plugin: mapPlugin
        anchors.fill: parent
        activeMapType: Settings.dark ? supportedMapTypes[7] : supportedMapTypes[6]
        copyrightsVisible: false
        zoomLevel: 14
        gesture.flickDeceleration: 3000
        gesture.enabled: true
        gesture.acceptedGestures: MapGestureArea.PanGesture
                                  | MapGestureArea.FlickGesture
                                  | MapGestureArea.PinchGesture
                                  | MapGestureArea.RotationGesture
                                  | MapGestureArea.TiltGesture
        
        MapQuickItem {
            id: marker
            anchorPoint.x: image.width/2
            anchorPoint.y: image.height
            sourceItem: Image {
                id: image
                source: Resource.images.other.marker
            }
        }
    }
    
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        preventStealing: false
        cursorShape: pressed ? Qt.ClosedHandCursor : Qt.PointingHandCursor
        onPressed: {
            lastPressX = mouse.x
            lastPressY = mouse.y
            lastX = mouse.x
            lastY = mouse.y
        }
        onMouseXChanged: {
            var xDiff = mouse.x - lastX
            var yDiff = mouse.y - lastY
            var c = mapView.fromCoordinate(mapView.center)
            var newCenter = Qt.point(c.x - xDiff, c.y - yDiff)
            mapView.center = mapView.toCoordinate(newCenter)
            lastX = mouse.x
            lastY = mouse.y
        }
        onClicked: {
            if (Math.floor(mouse.x) !== Math.floor(lastPressX)
                    || Math.floor(mouse.y) !== Math.floor(lastPressY)) {
                return
            }
            var coord = mapView.toCoordinate(Qt.point(mouse.x, mouse.y))
            setMarkerCoord(coord)
            markerCoordinateActivated(coord)
        }
        property real lastCenterX: 0
        property real lastCenterY: 0
        property real lastPressX: 0
        property real lastPressY: 0
        property real lastX: 0
        property real lastY: 0
    }
    
    function scrollToMarker() {
        mapView.center = marker.coordinate
        mapView.zoomLevel = 14
    }

    function setMarkerCoord(coord) {
        marker.coordinate = coord
        markerCoordinateChanged(coord)
    }

    function setMarkerCoordFromGps(callback) {
        positionSource.start()
        d.gpsPositionChangeCallback = callback
    }

    function getMarkerCoordinate() {
        return marker.coordinate
    }

    QtObject {
        id: d
        function getGpsErrorString(error) {
            return (function (err) {
                switch(err) {
                case PositionSource.AccessError:
                    return "The connection setup to the remote positioning \
                            backend failed because the application lacked \
                            the required privileges."
                case PositionSource.ClosedError:
                    return "The positioning backend closed the connection, \
                            which happens for example in case the user is \
                            switching location services to off. As soon as \
                            the location service is re-enabled regular \
                            updates will resume."
                case PositionSource.UnknownSourceError:
                    return "An unidentified error occurred."
                case PositionSource.SocketError:
                    return "An error occurred while connecting to an nmea \
                            source using a socket."
                }
            })(error).trim().replace(/\s+/g, ' ')
        }
        
        property var gpsPositionChangeCallback: null
    }

    signal markerCoordinateChanged(var coord)
    signal markerCoordinateActivated(var coord)

    property string error: ""
    property bool valid: error === ""
    property alias pS: positionSource
    property alias map: mapView
}
