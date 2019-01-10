import QtQuick 2.7
import QtQuick.Controls 2.2

SwipeView {
    id: swipeView
    interactive: false
    clip: true
    currentIndex: applicationWindow.tabBar.currentIndex
}