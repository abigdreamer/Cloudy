pragma Singleton
import QtQuick 2.6
import "utils.js" as Utils

QtObject {
    function getChannelImageUrls(responses, callback) {
        var url = Utils.toChannelsUrl(responses)
        var xhttp = new XMLHttpRequest()
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                if (!xhttp.responseText
                        || xhttp.responseText === ""
                        || typeof xhttp.responseText === "undefined") {
                    return callback(null, null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                if (response.kind !== 'youtube#channelListResponse')
                    return callback(null, null, "Server returned empty data")
                
                callback(responses, Utils.toChannelImageUrlList(response))
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }

    function getTrends(countryCode, callback) {
        var url = Utils.toTrendsUrl(countryCode)
        var xhttp = new XMLHttpRequest()
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                if (!xhttp.responseText
                        || xhttp.responseText === ""
                        || typeof xhttp.responseText === "undefined") {
                    return callback(null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                if (response.kind !== 'youtube#videoListResponse')
                    return callback(null, "Server returned broken data")

                var videoResponses = Utils.toVideoList(response)
                getChannelImageUrls(videoResponses, function(vR, val, err) {
                    if (!val || err)
                        return callback(null, err)
                    
                    for (var i = 0; i < vR.length; ++i) {
                        vR[i].channelDescription = val[vR[i].channelId].channelDescription
                        vR[i].channelImageUrl = val[vR[i].channelId].channelImageUrl
                        vR[i].channelStatistics = val[vR[i].channelId].channelStatistics
                    }
                    
                    callback(vR)
                })
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
    
    function getComments(videoId, orderByTime, pageToken, callback) {
        var url = Utils.toCommentsUrl(videoId, orderByTime, pageToken)
        var xhttp = new XMLHttpRequest()
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                if (!xhttp.responseText
                        || xhttp.responseText === ""
                        || typeof xhttp.responseText === "undefined") {
                    return callback(null, null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                if (response.kind !== 'youtube#commentThreadListResponse')
                    return callback(null, null, "Server returned empty data")
                
                callback(Utils.toCommentsList(response), response.nextPageToken)
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
    
    function getStatistics(responses, callback) {
        var url = Utils.toStatisticsUrl(responses)
        var xhttp = new XMLHttpRequest()
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                if (!xhttp.responseText
                        || xhttp.responseText === ""
                        || typeof xhttp.responseText === "undefined") {
                    return callback(null, null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                if (response.kind !== 'youtube#videoListResponse')
                    return callback(null, null, "Server returned empty data")
                
                callback(responses, Utils.toStatisticsList(response))
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
    
    function getSearchResults(searchTerm, pageToken, callback) {
        var url = Utils.toSearchUrl(searchTerm, pageToken)
        var xhttp = new XMLHttpRequest()
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                if (!xhttp.responseText
                        || xhttp.responseText === ""
                        || typeof xhttp.responseText === "undefined") {
                    return callback(null, null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                if (response.kind !== 'youtube#searchListResponse')
                    return callback(null, null, "Server returned empty data")
                
                var videoResponses = Utils.toSearchList(response)
                getChannelImageUrls(videoResponses, function(vRR, val, err) {
                    if (!val || err)
                        return callback(null, err)

                    for (var i = 0; i < vRR.length; ++i) {
                        vRR[i].channelDescription = val[vRR[i].channelId].channelDescription
                        vRR[i].channelImageUrl = val[vRR[i].channelId].channelImageUrl
                        vRR[i].channelStatistics = val[vRR[i].channelId].channelStatistics
                    }
                    
                    getStatistics(vRR, function(vR, val, err) {
                        if (!val || typeof val === "undefined" || err)
                            return callback(null, err)

                        for (var i = 0; i < vR.length; ++i) {
                            vR[i].duration = val[vR[i].id].duration
                            vR[i].statistics = val[vR[i].id].statistics
                        }
                        callback(vR, response.nextPageToken)
                    })
                })
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
    
    function getVideoInfo(videoId, callback) {
        var url = Utils.toVideoInfoUrl(videoId)
        var xhttp = new XMLHttpRequest()
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState === 4 && xhttp.status === 200) {
                if (!xhttp.responseText
                        || xhttp.responseText === ""
                        || typeof xhttp.responseText === "undefined") {
                    return callback(null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                if (!response || typeof response === "undefined" || response.length < 1)
                    return callback(null, "Server returned empty data")
                
                callback(response)
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
}
