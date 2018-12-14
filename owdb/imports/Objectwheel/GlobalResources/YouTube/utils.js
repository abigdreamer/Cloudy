.pragma library
.import YouTube 1.0 as YouTube

function toTrendsUrl(countryCode) {
    return  YouTube.Constants.apiUrl + 'videos' +
        '?part=snippet&chart=mostPopular&maxResults=32' +
        '&key=' + YouTube.Constants.apiKey +
        '&regionCode=' + countryCode
}

function toStatisticsUrl(countryCode) {
    return  YouTube.Constants.apiUrl + 'videos' +
        '?part=statistics&chart=mostPopular&maxResults=32' +
        '&key=' + YouTube.Constants.apiKey +
        '&regionCode=' + countryCode
}

function toChannelsUrl(responses) {
    var res =  YouTube.Constants.apiUrl + 'channels' +
        '?part=snippet' +
        '&key=' + YouTube.Constants.apiKey + '&id='
    for (var i = 0; i < responses.length; ++i)
        res += responses[i].channelId + ','
    return res.slice(0, -1)
}

function toTrendsObject(response, statistics) {
    return {
        "id": response.id,
        "channelId": response.snippet.channelId,
        "channelImageUrl": null,
        "channelTitle": response.snippet.channelTitle,
        "title": response.snippet.localized.title,
        "description": response.snippet.localized.description,
        "imageUrl": response.snippet.thumbnails.high.url,
        "statistics": statistics[response.id],
        "date": new Date(response.snippet.publishedAt)
    }
}

function toChannelImageUrlList(response) {
    var finalList = {}
    for (var i = 0; i < response.items.length; ++i) {
        var entry = response.items[i]
        finalList[entry.id] = entry.snippet.thumbnails.medium.url
    }
    return finalList
}

function toTrendsList(response) {
    var finalList = []
    for (var i = 0; i < response.items.length; ++i)
        finalList.push(response.items[i])
    return finalList
}

function toStatisticsList(response) {
    var finalList = {}
    for (var i = 0; i < response.items.length; ++i) {
        var stat = response.items[i]
        finalList[stat.id] = stat.statistics
    }
    return finalList
}
