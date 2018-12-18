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
                    return callback(null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                if (response.kind !== 'youtube#channelListResponse')
                    return callback(null, "Server returned empty data")
                
                callback(Utils.toChannelImageUrlList(response))
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, "Server rejected")
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
                getChannelImageUrls(videoResponses, function(val, err) {
                    if (!val || err)
                        return callback(null, err)
                    
                    for (var i = 0; i < videoResponses.length; ++i) {
                        videoResponses[i].channelDescription = val[videoResponses[i].channelId].channelDescription
                        videoResponses[i].channelImageUrl = val[videoResponses[i].channelId].channelImageUrl
                        videoResponses[i].channelStatistics = val[videoResponses[i].channelId].channelStatistics
                    }
                    
                    callback(videoResponses)
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
                    return callback(null, "Server error")
                }

                var response = JSON.parse(xhttp.responseText)
                if (response.kind !== 'youtube#videoListResponse')
                    return callback(null, "Server returned empty data")
                
                callback(Utils.toStatisticsList(response))
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, "Server rejected")
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
                getChannelImageUrls(videoResponses, function(val, err) {
                    if (!val || err)
                        return callback(null, err)
                    
                    for (var i = 0; i < videoResponses.length; ++i) {
                        videoResponses[i].channelDescription = val[videoResponses[i].channelId].channelDescription
                        videoResponses[i].channelImageUrl = val[videoResponses[i].channelId].channelImageUrl
                        videoResponses[i].channelStatistics = val[videoResponses[i].channelId].channelStatistics
                    }
                    
                    getStatistics(videoResponses, function(val, err) {
                        if (!val || err)
                            return callback(null, err)
                        for (var i = 0; i < videoResponses.length; ++i)
                            videoResponses[i].statistics = val[videoResponses[i].id]
                        callback(videoResponses, response.nextPageToken)
                    })
                })
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
}
