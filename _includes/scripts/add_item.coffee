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
      alert "ok"
      # console.log YAML.stringify parseForm(), 8, 2