dateTime = (e) ->
  minute = 1000 * 60
  hour = minute * 60
  day = hour * 24
  week = day * 7
  month = day * 30.42
  year = week * 52.14
  decimals = $(e).data("decimals") || 0
  diff = new Date().getTime() - (new Date(Date.parse $(e).attr "datetime").getTime()) #+ (12 * hour)) Consider noon instead of midnight
  absolute = Math.abs diff
  # Check range
  if absolute < hour
    moment = "#{(absolute / minute).toFixed decimals} minutes"
  else if absolute < day
    moment = "#{(absolute / hour).toFixed decimals} hours"
  else if absolute < week
    moment = "#{(absolute / day).toFixed decimals} days"
  else if absolute < 4 * week
    moment = "#{(absolute / week).toFixed decimals} weeks"
  else if absolute < year
    moment = "#{(absolute / month).toFixed decimals} months"
  else moment = "#{(absolute / year).toFixed decimals} years"
  # Past or Future
  out = if diff > 0 then "#{moment} ago" else "in #{moment}"
  # Embed or add title attribute
  if $(e).data "embed"
    $(e).text "#{$(e).attr("datetime").slice 0, 10} (#{out})"
  else if $(e).data "replace"
    $(e).text out
    $(e).attr "title", new Date(Date.parse $(e).attr "datetime")
  else
    $(e).attr "title", out
  # Set every minute
  # Return a setTimeout function
  setTimeout ->
    dateTime e
  , 60 * 1000

$("[datetime]").each -> dateTime @