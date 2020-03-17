# Form events
$("form[data-action]").each ->
  form = $ @
  # Submit
  form.on "submit", (e) ->
    if !storage.get "login.token"
      alert "You need to login"
    else
      post form
    return
  # Reset
  form.on "reset", (e) ->
    form.find("#timestamp").val ""
    form.find("span.action").text "Add"
    form.data "action", "add"
    return
  true

# Edit-item
$("a.edit").on "click", (e) ->
  link = $ e.target
  timestamp = Number link.attr("href").replace("#", "")
  file = link.parents("table").data "file"
  form = $("form[data-file='#{file}']")
  form.find(".action").text "Edit"
  form.data "action", "edit"
  inputs = form.find ":input"
  content_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/contents/_data/#{file}.yml"
  inputs.prop "disabled", true
  get_content = $.get content_url,
    headers: "Authorization": "token #{storage.get("login.token")}"
  get_content.fail (request, status, error) -> alert "#{status}: #{error}"
  get_content.always = () -> inputs.prop "disabled", false
  get_content.done (data, status) ->
    item = YAML.parse(atob(data.content)).find((x) => x.timestamp == timestamp)
    form.find(':input:not(button,[data-exclude])').each ->
      $(@).val item[$(@).attr "id"]
      return
    return
  true

post = (form) ->
  file = form.data "file"
  commit_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/contents/_data/#{file}.yml"
  inputs = form.find ":input"
  inputs.prop "disabled", true
  get_sha = $.get commit_url,
    headers: "Authorization": "token #{storage.get("login.token")}"
  get_sha.fail (request, status, error) ->
    if error == 'Not Found'
      # create_file()
    else
      inputs.prop "disabled", false
      alert "#{status}: #{error}"
    return
  get_sha.done (data, status) ->
    form_data = parseForm form
    if form.data("action") == "add"
      object = atob(data.content) + YAML.stringify(form_data, 8, 2)
    if form.data("action") == "edit"
      content = YAML.parse(atob(data.content))
      index = content.findIndex((x) => x.timestamp == form_data[0].timestamp)
      content[index] = form_data[0]
      object = YAML.stringify(content, 8, 2)
    update_file = $.ajax commit_url,
      headers: "Authorization": "token #{storage.get("login.token")}"
      method: "PUT"
      data: JSON.stringify {
        message: "update_file #{file}"
        sha: data.sha
        content: object
      }
    update_file.fail (request, status, error) -> alert "#{status}: #{error}"
    update_file.done (data, status) ->
      alert "file_updated: #{status}"
      data["commit"]["commit"] = data["commit"]
      compare data
      return
    update_file.always () -> inputs.prop "disabled", false
    return
  true

parseForm = (form) ->
  data = {}
  form.find(':input:not(button, [data-exclude])').each ->
    value = if $(@).attr("type") in ["checkbox", "radio"] then $(@).is(':checked') else $(@).val()
    if $(@).attr("type") == "number" then value = Number value
    if value then data[$(@).attr("id")] = value
    return
  # Add timestamp
  data["timestamp"] = if data["timestamp"]
    Number data["timestamp"]
  else new Date().getTime()
  return [data]