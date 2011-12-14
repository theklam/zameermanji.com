$(document).ready ->
  # Get my latest tweet
  url = "http://api.twitter.com/1/statuses/user_timeline.json?callback=?"
  params = {
    screen_name:'zmanji'
    include_rts: false
    exclude_replies: true
  }
  $.getJSON(url, params, (data, textStatus, jqXHR) ->
    $('#tweet-text').fadeOut(400, ->
      text = data[0].text
      text = twttr.txt.autoLink(text)
      $(this).html(text).fadeIn()
    )


    # Build html
    p = $('<p>').text("- ")
    tag = $("<time>")
    tag.attr("datetime", data[0].created_at)
    tag.addClass("timeago")
    tag.timeago()

    link = $('<a>')
    link.attr("href", "https://twitter.com/zmanji/status/#{data[0].id}")
    link.append(tag)
    p.append(link)

    $('#tweet-text').after(p)
  )
