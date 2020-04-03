# Filter elements on <select> change event
# Used for .filters
date_select = ".filters #year, .filters #month"
$(date_select).on "change", () ->
  # Get container element to filter: container > filters div > .filters > select
  container = $(@).parent().parent().parent()
  # Compose search string from the selects value
  string = ( container.find(date_select).map -> $(@).val() ).get().join("")
  # Reset counter
  count = 0
  # Start loop on data-date elements
  container.find("[data-date]").each ->
    # Check if row's data-date match the search string
    if $(@).data("date").toString().match string
      $(@).show()
      # Count only calendar items with data
      if $(@).hasClass("data") then count++
    else
      $(@).hide()
    true
  # Filter calendar year and month boxes
  id = $(@).attr "id"
  string = $(@).val()
  # Check if data-month and data-year match search strings
  container.find("[data-#{id}]").each ->
    if $(@).data(id).toString().match string
      display = if id is "month" then "flex" else "block"
      $(@).css "display", display
    else
      $(@).css "display", "none"
    true
  # Show elements count
  container.find(".filters span.size").text count
  true

other_select = ".filters select:not(#year):not(#month)"
$(other_select).on "change", () ->
  count = 0
  # Get container element to filter: container > filters div > .filters > select
  container = $(@).parent().parent().parent()
  string = $(@).val()
  id = $(@).attr "id"
  container.find("td[data-property='#{id}']").each ->
    if $(@).text().toString().match string
      $(@).parent().show()
      count++
    else $(@).parent().hide()
    true
  # Show elements count
  container.find(".filters span.size").text count
  true

# Trigger default filter event if initial selected option is found
$(".filters select option[selected]").each ->
  # Trigger change event for parent <select>
  $(@).parent().trigger "change"