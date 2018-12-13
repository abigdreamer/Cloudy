.pragma library
.import YouTube 1.0 as YouTube

function toTopNewsUrl(countryCode) {
    return  YouTube.Constants.apiUrl +
        '?apiKey=' + YouTube.Constants.apiKey +
        '&country=' + countryCode
}

function toTopNewsObject(response) {
    return {
        "sourceName": response.source.name,
        "sourceUrl": response.url,
        "imageUrl": response.urlToImage,
        "title": response.title,
        "description": response.description,
        "content": response.content,
        "date": new Date(response.publishedAt)
    }
}

function toNewsList(response) {
    var finalList = []
    for (var i = 0; i < response.articles.length; ++i)
        finalList.push(response.articles[i])
    return finalList
}