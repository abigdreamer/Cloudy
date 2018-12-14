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

function toChannelsUrl(channelId) {
    return  YouTube.Constants.apiUrl + 'channels' +
        '?part=snippet' +
        '&key=' + YouTube.Constants.apiKey +
        '&id=' + channelId
}

function toChannelImage(response) {
    return response.items[0].snippet.thumbnails.medium.url
}

function toTrendsObject(response, statistics) {
    return {
        "id": response.id,
        "channelId": response.snippet.channelId,
        "channelTitle": response.snippet.channelTitle,
        "title": response.snippet.localized.title,
        "description": response.snippet.localized.description,
        "imageUrl": response.snippet.thumbnails.high.url,
        "statistics": statistics[response.id],
        "date": new Date(response.snippet.publishedAt)
    }
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
