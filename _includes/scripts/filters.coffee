$("table caption select").on "change", (e) ->
  # Get parent table
  table = $(@).closest "table"
  # Compose search string from the selects
  string = (table.find("caption select").map -> $(@).val()).get().join("")
  # Reset counter
  count = 0
  # Start loop on table-body rows
  table.find("tbody tr").each ->
    # Check if row's data-date match the search string
    if $(@).data("date").match string
      # Display row
      $(@).css "display", "table-row"
      # Increment counter
      count++
    else
      # Hide row
      $(@).css "display", "none"
    true
  # Show elements count
  table.find("caption span.size").text count
  true