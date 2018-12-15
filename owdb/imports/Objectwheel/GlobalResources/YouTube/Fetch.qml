pragma Singleton
import QtQuick 2.6
import "utils.js" as Utils

QtObject {
    function getChannelImageUrls(responses, callback) {
        var url = Utils.toChannelsUrl(responses)
        var xhttp = new XMLHttpRequest();
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
        var xhttp = new XMLHttpRequest();
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

                var trendsResponses = Utils.toTrendsList(response)
                var channelImageUrls = getChannelImageUrls(trendsResponses, function(val, err) {
                    if (!val || err)
                        return callback(null, err)
                    
                    for (var i = 0; i < trendsResponses.length; ++i)
                        trendsResponses[i].channelImageUrl = val[trendsResponses[i].channelId]
                    
                    callback(trendsResponses)
                })
            }
            if (xhttp.readyState === 4 && xhttp.status !== 200)
                callback(null, "Server rejected")
        }
        xhttp.open("GET", url, true)
        xhttp.send()
    }
}
