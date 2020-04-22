# Form events
$("form[data-action='create']").each ->
  form = $ @
  form.on "submit", ->
    if !storage.get "login.token" or !storage.get "login.permissions.admin"
      alert "You need to login"
    else console.log YAML.stringify((parseForm form),8,2)
  form.on "reset", ->
    form.find("[data-property]").remove()
    return
  form.on "click", "a.add-element", (e) -> add_element e
  form.on "click", "a.add-property", (e) -> add_property e
  form.on "click", "a.remove-property", (e) -> remove_property e
  form.on "click", "a.remove-element", (e) -> remove_element e
  true

# Add property
add_property = (e) ->
  # Promp for property name
  name = prompt "Property name"
  if !name then return false
  # Get elements
  link = $ e.target
  form = link.parents "form"
  property = link.attr("href").replace "#", ""
  append_after = link.parent().next "hr"
  template = $ form.find("#template-#{property}").clone().prop "content"
  # Fill in data-property for remove function
  template.find "> div, a.remove-property, hr"
    .attr "data-property", "#{property}.#{name}"
  # Loop inputs
  template.find(":input:not(button, [data-exclude])").each ->
    # Fill in input 'id' for nesting
    id = $(@).attr("id").split(".")
    # Insert `name` at position 1, removing 0 elements
    id.splice(1, 0, name)
    $(@).attr "id", id.join(".")
    # Fill in 'label' and 'for' 
    label = $(@).attr "aria-label"
    required = if $(@).attr("required") then "<sup>*</sup>" else ""
    $(@).prev("label").attr("for", id.join(".")).html "#{label}#{required}"
    true
  # Bind subordinate event
  template.find("[id='#{property}.#{name}.type']").on "change", (e) ->
    type = $(@).val()
    # Find subordinates and toggle visibility
    form.find("[data-subordinate][data-property='#{property}.#{name}']").each ->
      if $(@).data("subordinate") is type
        $(@).show()
        $(@).find(":input").removeAttr "data-exclude"
      else
        $(@).hide()
        $(@).find(":input").attr "data-exclude", true
      true
    true
  # Show property name on top label
  template.find(">div:first-of-type label").text name
  # Append property
  append_after.after template
  # Initialize subordinates
  form.find("[id='#{property}.#{name}.type']").change()
  return

# Remove property
remove_property = (e) ->
  $ e.target
    .parents "form"
    .find "[data-property='#{$(e.target).attr "data-property"}']"
    .remove()
  true

# Add element
add_element = (e) ->
  # Get elements
  link = $ e.target
  index = Number link.attr 'data-index'
  form = link.parents "form"
  property = link.attr("href").replace "#", ""
  parent_div = link.parent()
  template = $ form.find("#template-#{property}").clone().prop "content"
  # Add data-property for remove property function
  template.find "> div"
    .attr "data-property", parent_div.attr("data-property")
  # Loop inputs
  template.find(":input:not(button, [data-exclude])").each ->
    # Fill in label 'for' and input 'id' for nesting
    id = "#{parent_div.attr("data-property")}.#{property}.#{index}"
    $(@).attr "id", id
    $(@).prev("label")
      .attr "for", id
      .children ".index"
      .text "#{index}"
    true
  index++
  link.attr "data-index", index
  # Append property
  parent_div.after template
  form.find("[id='#{parent_div.attr("data-property")}.#{property}.#{index-1}']").focus()
  true

# Remove element
remove_element = (e) ->
  link = $ e.target
  form = link.parents "form"
  property = link.attr("href")
  adder = form.find("a.add-element[href='#{property}']")
  index = adder.attr("data-index")
  index--
  adder.attr("data-index", index)
  # Remove element
  link.parents "div[data-property]"
    .remove()
  substring = link.parents("label").attr("for").split(".").slice(0,-1).join(".")
  form.find("label[for*='#{substring}']").each (i, e) ->
    $(e).attr("for","#{substring}.#{index-1-i}")
    $(e).children(".index").text (index-1-i)
    true
  form.find(":input[id*='#{substring}']").each (i, e) ->
    $(e).attr("id","#{substring}.#{index-1-i}")
    true
  true