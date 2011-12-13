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
      $(this).text(data[0].text).fadeIn()
    )


    # Build time tag
    tag = $("<time>")
    tag.attr("datetime", data[0].created_at)
    tag.addClass("timeago")
    tag.timeago()
    text = "- #{tag.text()}"
    tag.text(text)



    $('#tweet-text').after(tag)
  )
