# Filter elements on <select> change event
# Used for .filters
$(".filters select").on "change", () ->
  # Get container element to filter: container > filters div > .filters > select
  container = $(@).parent().parent().parent()
  # Compose search string from the selects value
  string = ( container.find(".filters select").map -> $(@).val() ).get().join("")
  # Reset counter
  count = 0
  # Start loop on data-date elements
  container.find("[data-date]").each ->
    # Check if row's data-date match the search string
    if $(@).data("date").toString().match string
      # Display
      if container.prop("tagName") == "TABLE"
        display = "table-row"
      else
        display = "block"
      $(@).css "display", display
      # Increment counter
      if $(@).hasClass("data") then count++
    else
      # Hide row
      $(@).css "display", "none"
    true
  container.find(".filters select").each ->
    id = $(@).attr("id")
    value = $(@).val()
    container.find("[data-#{id}]").each ->
      if $(@).data(id).toString().match value
        if id == "month"
          display = "flex"
        else
          display = "block"
        $(@).css "display", display
      else
        $(@).css "display", "none"
      true
    true
  # Show elements count
  container.find(".filters span.size").text count
  true

# Trigger default filter event if initial selected option is found
$(".filters select option[selected]").each ->
  # Trigger change event for parent <select>
  $(@).parent().trigger "change"