$(document).ready ->
  # Get my latest tweet
  url = "http://api.twitter.com/1/statuses/user_timeline.json?callback=?"
  params = {
    screen_name:'zmanji'
    include_rts: false
    exclude_replies: true
  }
  $.getJSON(url, params, (data, textStatus, jqXHR) ->
    console.log data[0].text
  )
