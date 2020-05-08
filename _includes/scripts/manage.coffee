# Form events
$("form[data-type]").each ->
  form = $ @
  # Submit
  form.on "submit", (e) ->
    valid = true
    # Validation minItems
    form.find("[data-index-min]").each ->
      if $(@).attr("data-index") < $(@).attr("data-index-min")
        $(@).closest("div").addClass "invalid"
        alert "#{$(@).attr("data-add")} must have minimum #{$(@).attr("data-index-min")} elements"
        valid = false
      return
    # Validation maxItems
    form.find("[data-index-max]").each ->
      if $(@).attr("data-index") > $(@).attr("data-index-max")
        $(@).closest("div").addClass "invalid"
        alert "#{$(@).attr("data-add")} must have maximum #{$(@).attr("data-index-max")} elements"
        valid = false
      return
    if valid
      # Check login and permissions
      if !storage.get("login.token") or !storage.get("login.permissions.admin")
        alert "You need to login with admin permission"
      # else post form
      else
        console.log jsyaml.dump(parseForm form)
        # console.log jsyaml.load(jsyaml.dump(parseForm form))
    return
  # Reset
  form.on "reset", (e) ->
    form.find("#timestamp").val ""
    # Remove array items and reset index
    form.find("[data-property]").remove()
    form.find("[data-index]").attr "data-index", 0
    setTimeout -> form.find("input[type=range]").trigger "input"
    # Remove invalid class
    form.find(".invalid").removeClass "invalid"
    return
  # Update range output
  form.find("input[type=range]").each ->
    $(@).on "input", (e) -> $(e.target).next("output").val $(e.target).val()
    # Initial update
    $(@).trigger "input"
    return
  # Array items 'add' 'remove' 'up and 'down' events
  form.on "click", "a[data-add]", (e) -> add_item e
  form.on "click", "a[data-remove]", (e) -> remove_item e
  form.on "click", "a[data-up]", (e) -> up_item e
  form.on "click", "a[data-down]", (e) -> down_item e
  # Additional property
  form.on "click", "a[data-additional-property]", (e) -> add_property e
  form.on "click", "a[data-remove-property]", (e) -> remove_property e
  # Prevent url update and reset invalid fields
  form.on "click", "a[data-prevent]", (e) ->
    e.preventDefault()
    form.find(".invalid").removeClass "invalid"
  true

# Add property
add_property = (e) ->
  link = $ e.target
  form = link.closest "form"
  parent_div = link.closest "div"
  # Get added property template
  property = link.attr "data-additional-property"
  template = $ form.find("#template_#{property}").clone().prop "content"
  # Append property
  parent_div.append template
  # Update event
  form.find("#aP_#{property}").on "change", (e) ->
    target = form.find("input[data-value='aP_#{property}']")
    target.attr
      id: (i, val) -> "#{ /^(.+_)*/.exec(val)[0]}#{e.target.value}"
      name: (i, val) -> "#{ /^(.+_)*/.exec(val)[0]}#{e.target.value}"
    return
  true

remove_property = (e) ->
  $(e.target).closest("div").remove()
  true

# Add item
add_item = (e) ->
  # Get elements
  link = $ e.target
  form = link.closest "form"
  parent_div = link.closest "div"
  container_div = parent_div.closest "div.array"
  # Get added property, relative index and template
  property = link.attr("href").replace "#", ""
  index = link.attr 'data-index'
  template = $ form.find("#template_#{property}").clone().prop "content"
  # Add 'data-property' and 'href' for 'remove' function
  template.find "[data-property]"
    .attr "data-property", "#{property}_#{index}"
  template.find "a[data-prevent]"
    .attr "href", "##{property}_#{index}"
  # Loop inputs and update 'id' and 'name'
  template.find(":input:not(button, [data-exclude])").each ->
    $(@).attr
      id: (i, val) -> "#{val}".replace "#{property}", "#{property}_#{index}"
      name: (i, val) -> "#{val}".replace "#{property}", "#{property}_#{index}"
    return
  # Loop labels and update 'for' and index number
  template.find("label").each ->
    $(@).attr "for", (i, val) -> "#{val}".replace "#{property}", "#{property}_#{index}"
      .children ".index"
      .text index
    return
  # Show index number in objects headers
  template.find("h4 .index").text index
  # Append property
  container_div.append template
  # Focus on new item
  container_div.find("div[data-property]:last").find(":input:first").focus()
  # Update index
  link.attr "data-index", (i, val) -> (Number val) + 1
  true

# Item up
up_item = (e) ->
  parent_div = $(e.target).closest "div[data-property]"
  above_div = parent_div.prevAll "div[data-property]:first"
  # Update divs
  update_item parent_div, -1
  update_item above_div, 1
  # Swap elements
  parent_div.after above_div
  true

# Item down
down_item = (e) ->
  # Get moving elements
  parent_div = $(e.target).closest "div[data-property]"
  below_div = parent_div.nextAll "div[data-property]:first"
  # Update divs
  update_item parent_div, 1
  update_item below_div, -1
  # Swap elements
  parent_div.before below_div
  true

# Update item
update_item = (element, add) ->
  # Get property and index
  old_string = element.attr "data-property"
  property = /^[^_]*/.exec(old_string)[0]
  index = Number /[^_]*$/.exec(old_string)[0]
  # Create new string and replace
  new_string = "#{property}_#{index + add}"
  element.attr "data-property", new_string
  # Update label.index
  element.find ".index"
    .text(index + add)
  # Update label 
  element.find "label[for^='#{old_string}']"
    .attr "for", (i, val) -> "#{val}".replace "#{old_string}", "#{new_string}"
  # Update links href
  element.find "a[data-prevent]"
    .attr "href", (i, val) -> "#{val}".replace "#{old_string}", "#{new_string}"
  # Update inputs id and name
  element.find(":input:not(button, [data-exclude])").attr
    id: (i, val) -> "#{val}".replace "#{old_string}", "#{new_string}"
    name: (i, val) -> "#{val}".replace "#{old_string}", "#{new_string}"
  true

# Edit item
$("a.edit").on "click", (e) ->
  link = $ e.target
  timestamp = Number link.attr("href").replace("#", "")
  form = $("form[data-file='#{link.parents("table").data "file"}']")
  form.find("span.action").text "Edit"
  form.attr("data-action", "edit")
  if $(window).scrollTop() > form.offset().top
    $("html, body").scrollTop form.offset().top
  get_content = api_get(form, true)
  get_content.done (data, status) ->
    # Populate form
    item = YAML.parse(atob(data.content)).find((x) => x.timestamp == timestamp)
    form.find(':input:not(button,[data-exclude])').each ->
      id = $(@).attr "id"
      value = id.split("_").reduce(((item,i)->item[i]),item)
      if $(@).attr("type") in ["checkbox", "radio"]
        if value then $(@).prop "checked", true else $(@).prop "checked", false
      else $(@).val value
      return
    return
  true

# Remove item
remove_item = (e) ->
  # Get elements
  link = $ e.target
  form = link.closest "form"
  # Remove items
  remove = link.attr("href").replace "#", ""
  form.find("[data-property='#{remove}']").remove()
  # Get removed property and index
  index = Number /[^_]*$/.exec(remove)[0]
  property = link.attr "data-remove"
  # Loop elements to update indexes
  form.find("[data-property^='#{property}_']").each ->
    # Get old string and index
    old = $(@).attr "data-property"
    i = Number /[^_]*$/.exec(old)[0]
    if i > index
      update_item $(@), -1
    return
  # Decrease index
  form.find "[data-add='#{property}']"
    .attr "data-index", (i, val) -> (Number val) - 1
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
        message: message || "Create file"
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
      message: message || "#{form.attr('data-action')}"
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
    # Check boolean
    if $(@).attr("type") in ["checkbox","radio"]
      if $(@).attr("data-boolean")
        value = $(@).is(':checked')
      else if $(@).is(':checked') then value = $(@).val()
    else value = $(@).val()
    # Check number
    if $(@).attr("type") in ["number","range"] or $(@).attr("data-number")
      value = Number value
    # Loop id
    if value or $(@).attr("data-boolean") or value is 0
      len = $(@).attr("id").split("_").length
      $(@).attr("id").split("_").reduce (data, i, index) =>
          if form.find("a[href='##{i}']").length
            return data[i] ?= []
          else
            return if index is (len-1) then data[i] ?= value else data[i] ?= {}
        , data
    return
  # Check if we need an object or a timestamped array element
  if form.attr("data-type") is "array"
    # Add timestamp
    data["timestamp"] = if data["timestamp"]
      Number data["timestamp"]
    else new Date().getTime()
    return [data]
  else return data