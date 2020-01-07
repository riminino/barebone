# Forms
# Add-item
$("form[data-add]").each ->
  form = $ @
  # Form submit
  form.on "submit", (e) ->
    e. preventDefault()
    # Check login
    if !storage.get "login.token"
      alert "You need to login"
    else
      commit(YAML.stringify(parseForm(), 8, 2), form.data "file")
  # Parse form
  parseForm = () ->
    data = {}
    form.find(':input:not([type=submit],[type=button],[type=reset],[data-exclude])').each ->
      value = if $(@).attr("type") in ["checkbox", "radio"] then $(@).is(':checked') else $(@).val()
      if $(@).attr("type") == "number" then value = Number value
      if value then data[$(@).attr("id")] = value
      true
    return [data]
  true