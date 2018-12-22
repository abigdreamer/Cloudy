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

// Min, max both should be integer
function getRandomInteger(min, max) { // Min, max both included
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function getRandomNumber(min, max, precision) {
    if (!precision)
        precision = 2
    return (Math.random() * (max - min) + min).toFixed(precision);
}

function repeatedlyCall(interval, parent, callback) {
    var timer = Qt.createQmlObject('import QtQuick 2.0; Timer{}', parent)
    timer.repeat = true
    timer.interval = interval
    timer.triggered.connect(callback)
    timer.start()
    return timer
}

function delayCall(interval, parent, callback) {
    var timer = Qt.createQmlObject('import QtQuick 2.0; Timer{}', parent)
    timer.interval = interval
    timer.triggered.connect(function () {
        callback()
        timer.destroy()
    })
    timer.start()
}

function suppressCall(interval, parent, callback) {
    var timerObj = timerMap[parent]
    if (typeof timerObj === "undefined") {
        timerObj = {}
        timerObj.timer = Qt.createQmlObject('import QtQuick 2.0; Timer{}', parent)
        timerObj.callback = callback // to suppress a warning of qt
        if (!timerObj.timer)
            return console.trace()
    }
    
    timerObj.timer.triggered.disconnect(timerObj.callback)
    timerObj.timer.triggered.connect(callback)
    timerObj.timer.interval = interval
    timerObj.callback = callback
    timerObj.timer.restart()
    timerMap[parent] = timerObj
}

function showMessage(parent, properties) {
    var dialog = Qt.createQmlObject('import Qt.labs.platform 1.0; MessageDialog{}', parent)
    if (!dialog)
        return console.trace()
        
    if (typeof properties !== "object") {
        dialog.destroy()
        return console.trace()
    }
    
    var keys = Object.keys(properties)
    for (var i = 0; i < keys.length; ++i) {
        var key = keys[i]
        var prop = properties[key]
        if (typeof prop === "function")
            dialog[key].connect(prop)
        else
            dialog[key] = prop
    }
    
    dialog.clicked.connect(dialog.destroy)
    dialog.visible = true
}

function fromNow(date) {
    var firstSec = date.getTime() / 1000.0
    var nowSec = (new Date()).getTime() / 1000.0
    var diff = Math.abs(Math.floor(firstSec - nowSec))
    if (diff < 10)
        return qsTr("Just now")
    if (diff < 60)
        return diff + ' ' + qsTr("seconds ago")
    if (diff < (60 * 60))
        return Math.floor(diff / 60.0) + ' ' + qsTr("minutes ago")
    if (diff < (60 * 60 * 24))
        return Math.floor(diff / (60 * 60.0)) + ' ' + qsTr("hours ago")
    if (diff < (60 * 60 * 24 * 7))
        return Math.floor(diff / (60 * 60 * 24.0)) + ' ' + qsTr("days ago")
    if (diff < (60 * 60 * 24 * 30))
        return Math.floor(diff / (60 * 60 * 24 * 7.0)) + ' ' + qsTr("weeks ago")
    if (diff < (60 * 60 * 24 * 30 * 12))
        return Math.floor(diff / (60 * 60 * 24 * 30.0)) + ' ' + qsTr("months ago")
    return Math.floor(diff / (60 * 60 * 24 * 30 * 12.0)) + ' ' + qsTr("years ago")
}

function viewString(viewCount) {
    if (viewCount < 0 || typeof viewCount === "undefined")
        return '?'
    var val
    if (viewCount < 1000)
        return viewCount + ' ' + qsTr("views")
    if (viewCount < 1000000) {
        val = viewCount / 1000.0
        if (val < 10 && (val % 1.0 > 0.1))
            return Number(val).toLocaleString(Qt.locale(), 'f', 1) + qsTr("K views")
         return Math.floor(val) + qsTr("K views")
    }
    if (viewCount < 1000000000) {
        val = viewCount / 1000000.0
        if (val < 10 && (val % 1.0 > 0.1))
            return Number(val).toLocaleString(Qt.locale(), 'f', 1) + qsTr("M views")
         return Math.floor(val) + qsTr("M views")
    }
    if (viewCount < 1000000000000) {
        val = viewCount / 1000000000.0
        if (val < 10 && (val % 1.0 > 0.1))
            return Number(val).toLocaleString(Qt.locale(), 'f', 1) + qsTr("B views")
         return Math.floor(val) + qsTr("B views")
    }
    return console.trace()
}

function subsString(subsCount) {
    if (subsCount < 0 || typeof subsCount === "undefined")
        return '?'
    var val
    if (subsCount < 1000)
        return subsCount + ' ' + qsTr("subscribers")
    if (subsCount < 1000000) {
        val = subsCount / 1000.0
        if (val < 10 && (val % 1.0 > 0.1))
            return Number(val).toLocaleString(Qt.locale(), 'f', 1) + qsTr("K subscribers")
         return Math.floor(val) + qsTr("K subscribers")
    }
    if (subsCount < 1000000000) {
        val = subsCount / 1000000.0
        if (val < 10 && (val % 1.0 > 0.1))
            return Number(val).toLocaleString(Qt.locale(), 'f', 1) + qsTr("M subscribers")
         return Math.floor(val) + qsTr("M subscribers")
    }
    if (subsCount < 1000000000000) {
        val = subsCount / 1000000000.0
        if (val < 10 && (val % 1.0 > 0.1))
            return Number(val).toLocaleString(Qt.locale(), 'f', 1) + qsTr("B subscribers")
         return Math.floor(val) + qsTr("B subscribers")
    }
    return console.trace()
}

function likeString(likeCount) {
    if (likeCount < 0 || typeof likeCount === "undefined")
        return '?'
    var val
    if (likeCount < 1000)
        return likeCount
    if (likeCount < 1000000) {
        val = likeCount / 1000.0
        if (val < 10 && (val % 1.0 > 0.1))
            return Number(val).toLocaleString(Qt.locale(), 'f', 1) + qsTr("K")
         return Math.floor(val) + qsTr("K")
    }
    if (likeCount < 1000000000) {
        val = likeCount / 1000000.0
        if (val < 10 && (val % 1.0 > 0.1))
            return Number(val).toLocaleString(Qt.locale(), 'f', 1) + qsTr("M")
         return Math.floor(val) + qsTr("M")
    }
    if (likeCount < 1000000000000) {
        val = likeCount / 1000000000.0
        if (val < 10 && (val % 1.0 > 0.1))
            return Number(val).toLocaleString(Qt.locale(), 'f', 1) + qsTr("B")
         return Math.floor(val) + qsTr("B")
    }
    return console.trace()
}

function getQualities(info) {
    var qualities = []
    for (var i = 0; i < info.length; ++i) {
        var video = info[i]
        if (!video.format.match(/[a|A]udio/g))
            qualities.push(video.format)
    }
    return qualities
}

function getVideo(info, quality) {
    for (var i = 0; i < info.length; ++i) {
        var video = info[i]
        if (video.format === quality)
            return video
    }
}

function getAudio(info) {
    for (var i = 0; i < info.length; ++i) {
        var audio = info[i]
        if (audio.format.match(/[a|A]udio/g))
            return audio
    }
}