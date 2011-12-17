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


      # Build )tml
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

  )

  # Get latest Github Activity

  url = 'https://api.github.com/users/zmanji/repos'
  $.getJSON(url, (data, textStatus, jqXHR) ->
    data.sort (a,b) ->
      datea = Date.parse a.pushed_at
      dateb = Date.parse b.pushed_at

      if dateb < datea
        return -1
      if dateb > datea
        return 1
      return 0


    # Create links to the repo
    $('#github-text').fadeOut(400, ->
      $(this).empty()

      repos = data.slice(0,2)
      tags = []
      _.each(repos, (repo) ->
        link = $('<a>')
        link.attr('href',repo.html_url).text(repo.name)

        p = $('<li>')
        p.append(link)
        p.prepend("#{repo.description} - ")

        tags.push(p)
      )

      _.each(tags, (tag) =>
        $(this).append(tag)
      )

      $(this).fadeIn()
    )
  )

  window.stackoverflow = (data, textStatus, jqXHR) ->
    rep = data.users[0].reputation
    $('#stackoverflow-text').fadeOut(400, ->
      link = $('<a>')
      link.attr('href', 'http://stackoverflow.com/users/2874/zameer-manji').text(rep)

      p = $('<p>')
      p.append(link)
      p.prepend("My reputation on StackOverflow is: ")

      $(this).empty().append(p).fadeIn()

    )


  url = 'http://api.stackoverflow.com/1.1/users/2874?callback=?'
  params = {
    dataType: 'jsonp'
    jsonp: 'stackoverflow'
  }
  $.getJSON(url, params)
