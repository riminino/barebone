# Form events
$("form[data-action]").each ->
  form = $ @
  form.on "submit", (e) -> post form
  form.on "reset", (e) ->
    form.find("#timestamp").val ""
    form.find("span.action").text "Add"
    form.attr("data-action", "add")
    return
  true

# Edit item
$("a.edit").on "click", (e) ->
  link = $ e.target
  timestamp = Number link.attr("href").replace("#", "")
  form = $("form[data-file='#{link.parents("table").data "file"}']")
  form.find("span.action").text "Edit"
  form.attr("data-action", "edit")
  $("html, body").scrollTop form.offset().top
  get_content = api_get(form, true)
  get_content.done (data, status) ->
    # Populate form
    item = YAML.parse(atob(data.content)).find((x) => x.timestamp == timestamp)
    form.find(':input:not(button,[data-exclude])').each ->
      id = $(@).attr "id"
      if $(@).attr("type") in ["checkbox", "radio"]
        if item[id] then $(@).prop "checked", true else $(@).prop "checked", false
      else $(@).val item[id]
      return
    return
  true

# Remove item
$("a.remove").on "click", (e) ->
  link = $ e.target
  timestamp = Number link.attr("href").replace("#", "")
  file = link.parents("table").data "file"
  if confirm "Remove #{timestamp} from #{file}?"
    # Get file content
    get_content = api_get(file, true)
    get_content.done (data, status) ->
      content = YAML.parse(atob(data.content))
        .filter (item) -> item.timestamp != timestamp
      message = prompt "Commit message (optional)"
      # Update file
      data =
        message: message || "Remove element from #{file}"
        sha: data.sha
        content: btoa YAML.stringify(content, 8, 2)
      update_file = api_put(file, data)
      return
  true

# Get content and commit with updates
post = (form) ->
  # Get file content and sha
  get_sha = api_get(form)
  get_sha.fail (request, status, error) ->
    if error == 'Not Found'
      # File not found: create
      message = prompt "Commit message (optional)"
      data =
        message: message || "Create file #{form.data "file"}"
        content: btoa YAML.stringify(parseForm form, 8, 2)
      create_file = api_put(form, data)
    else alert "#{status}: #{error}"
    return
  # Append or edit item
  get_sha.done (data, status) ->
    form_data = parseForm form
    if form.attr("data-action") is "add"
      object = atob(data.content) + YAML.stringify(form_data, 8, 2)
    if form.attr("data-action") is "edit"
      content = YAML.parse(atob(data.content))
      index = content.findIndex((x) => x.timestamp == form_data[0].timestamp)
      content[index] = form_data[0]
      object = YAML.stringify(content, 8, 2)
    # Update file
    message = prompt "Commit message (optional)"
    data =
      message: message || "Update file #{form.data "file"}"
      sha: data.sha
      content: btoa object
    update_file = api_put(form, data)
    return
  true

# Parse form and return one element array
parseForm = (form) ->
  data = {}
  # Loop input fields
  form.find(':input:not(button, [data-exclude])').each ->
    value = if $(@).attr("type") in ["checkbox", "radio"] then $(@).is(':checked') else $(@).val()
    if $(@).attr("type") == "number" then value = Number value
    # if value then data[$(@).attr("id")] = value
    $(@).attr('id').split('.').reduce (data, i) =>
      if form.find("[data-add=#{i}]").length
        return data[i] ?= []
      else
        return if i is $(@).attr('aria-label') then data[i] ?= value else data[i] ?= {}
    , data
    return
  # Add timestamp
  data["timestamp"] = if data["timestamp"]
    Number data["timestamp"]
  else new Date().getTime()
  return [data]