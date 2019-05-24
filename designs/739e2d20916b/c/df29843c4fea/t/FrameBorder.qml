import QtQuick 2.9
import QtQuick.Window 2.3

Item {
    property point startMousePos
    property point startWindowPos
    property size startWindowSize

    function absoluteMousePos(mouseArea) {
        var windowAbs = mouseArea.mapToItem(null, mouseArea.mouseX, mouseArea.mouseY)
        return Qt.point(windowAbs.x + Window.window.x,
                        windowAbs.y + Window.window.y)
    }
    
    MouseArea {
        id: leftArea
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 3
        cursorShape: Qt.SizeHorCursor
        onPressed: {
            startMousePos = absoluteMousePos(leftArea)
            startWindowPos = Qt.point(Window.window.x, Window.window.y)
            startWindowSize = Qt.size(Window.window.width, Window.window.height)
        }
        onMouseYChanged: {
            var abs = absoluteMousePos(leftArea)
            var newWidth = Math.max(Window.window.minimumWidth, startWindowSize.width - (abs.x - startMousePos.x))
            var newX = startWindowPos.x - (newWidth - startWindowSize.width)
            Window.window.x = newX
            Window.window.width = newWidth
        }
    }

    MouseArea {
        id: rightArea
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 3
        cursorShape: Qt.SizeHorCursor
        onPressed: {
            startMousePos = absoluteMousePos(rightArea)
            startWindowPos = Qt.point(Window.window.x, Window.window.y)
            startWindowSize = Qt.size(Window.window.width, Window.window.height)
        }
        onMouseYChanged: {
            var abs = absoluteMousePos(rightArea)
            var newWidth = Math.max(Window.window.minimumWidth, startWindowSize.width + (abs.x - startMousePos.x))
            Window.window.width = newWidth
        }
    }

    MouseArea {
        id: bottomArea
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        height: 3
        cursorShape: Qt.SizeVerCursor
        onPressed: {
            startMousePos = absoluteMousePos(bottomArea)
            startWindowPos = Qt.point(Window.window.x, Window.window.y)
            startWindowSize = Qt.size(Window.window.width, Window.window.height)
        }
        onMouseYChanged: {
            var abs = absoluteMousePos(bottomArea)
            var newHeight = Math.max(Window.window.minimumHeight, startWindowSize.height + (abs.y - startMousePos.y))
            Window.window.height = newHeight
        }
    }

    MouseArea {
        id: topArea
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        height: 3
        cursorShape: Qt.SizeVerCursor
        onPressed: {
            startMousePos = absoluteMousePos(topArea)
            startWindowPos = Qt.point(Window.window.x, Window.window.y)
            startWindowSize = Qt.size(Window.window.width, Window.window.height)
        }
        onMouseYChanged: {
            var abs = absoluteMousePos(topArea)
            var newHeight = Math.max(Window.window.minimumHeight, startWindowSize.height - (abs.y - startMousePos.y))
            var newY = startWindowPos.y - (newHeight - startWindowSize.height)
            Window.window.y = newY
            Window.window.height = newHeight
        }
    }

    MouseArea {
        id: topLeftArea
        anchors.top: parent.top
        anchors.left: parent.left
        width: 6
        height: 6
        cursorShape: Qt.SizeFDiagCursor
        onPressed: {
            startMousePos = absoluteMousePos(topLeftArea)
            startWindowPos = Qt.point(Window.window.x, Window.window.y)
            startWindowSize = Qt.size(Window.window.width, Window.window.height)
        }
        onMouseYChanged: {
            var abs = absoluteMousePos(topLeftArea)
            var newHeight = Math.max(Window.window.minimumHeight, startWindowSize.height - (abs.y - startMousePos.y))
            var newY = startWindowPos.y - (newHeight - startWindowSize.height)
            var newWidth = Math.max(Window.window.minimumWidth, startWindowSize.width - (abs.x - startMousePos.x))
            var newX = startWindowPos.x - (newWidth - startWindowSize.width)
            Window.window.x = newX
            Window.window.width = newWidth
            Window.window.y = newY
            Window.window.height = newHeight
        }
    }

    MouseArea {
        id: topRightArea
        anchors.top: parent.top
        anchors.right: parent.right
        width: 6
        height: 6
        cursorShape: Qt.SizeBDiagCursor
        onPressed: {
            startMousePos = absoluteMousePos(topRightArea)
            startWindowPos = Qt.point(Window.window.x, Window.window.y)
            startWindowSize = Qt.size(Window.window.width, Window.window.height)
        }
        onMouseYChanged: {
            var abs = absoluteMousePos(topRightArea)
            var newHeight = Math.max(Window.window.minimumHeight, startWindowSize.height - (abs.y - startMousePos.y))
            var newY = startWindowPos.y - (newHeight - startWindowSize.height)
            var newWidth = Math.max(Window.window.minimumWidth, startWindowSize.width + (abs.x - startMousePos.x))
            Window.window.width = newWidth
            Window.window.y = newY
            Window.window.height = newHeight
        }
    }

    MouseArea {
        id: bottomRightArea
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 6
        height: 6
        cursorShape: Qt.SizeFDiagCursor
        onPressed: {
            startMousePos = absoluteMousePos(bottomRightArea)
            startWindowPos = Qt.point(Window.window.x, Window.window.y)
            startWindowSize = Qt.size(Window.window.width, Window.window.height)
        }
        onMouseYChanged: {
            var abs = absoluteMousePos(bottomRightArea)
            var newHeight = Math.max(Window.window.minimumHeight, startWindowSize.height + (abs.y - startMousePos.y))
            var newWidth = Math.max(Window.window.minimumWidth, startWindowSize.width + (abs.x - startMousePos.x))
            Window.window.width = newWidth
            Window.window.height = newHeight
        }
    }

    MouseArea {
        id: bottomLeftArea
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: 6
        height: 6
        cursorShape: Qt.SizeBDiagCursor
        onPressed: {
            startMousePos = absoluteMousePos(bottomLeftArea)
            startWindowPos = Qt.point(Window.window.x, Window.window.y)
            startWindowSize = Qt.size(Window.window.width, Window.window.height)
        }
        onMouseYChanged: {
            var abs = absoluteMousePos(bottomLeftArea)
            var newHeight = Math.max(Window.window.minimumHeight, startWindowSize.height + (abs.y - startMousePos.y))
            var newWidth = Math.max(Window.window.minimumWidth, startWindowSize.width - (abs.x - startMousePos.x))
            var newX = startWindowPos.x - (newWidth - startWindowSize.width)
            Window.window.x = newX
            Window.window.width = newWidth
            Window.window.height = newHeight
        }
    }
}
