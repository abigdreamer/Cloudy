.pragma library

var timerMap = {}

function toCleanTemp(temp, metric) {
    return Math.round(temp) + '\u00B0' + (metric ? 'C' : 'F')
}

function toCleanSpeed(speed, metric) {
    return speed + (metric ? ' m/s' : ' mph')
}

function toTitleCase(str) {
    return str.replace(
        /\w\S*/g,
        function(txt) {
            return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
        }
    )
}

function suppressCall(interval, parent, callback) {
    var timerObj = timerMap[parent]
    if (typeof timerObj === "undefined") {
        timerObj = {}
        timerObj.timer = Qt.createQmlObject('import QtQuick 2.0; Timer{}', parent)
        timerObj.callback = callback // to suppress a warning of qt
    }
    
    timerObj.timer.triggered.disconnect(timerObj.callback)
    timerObj.timer.triggered.connect(callback)
    timerObj.timer.interval = interval
    timerObj.callback = callback
    timerObj.timer.restart()
    timerMap[parent] = timerObj
}
