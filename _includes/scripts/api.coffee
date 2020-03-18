api_get = (f, debug) ->
  if !storage.get "login.token" then return alert "You need to login"
  if $.type(f) is "string"
    url = api_url(f)
  else
    url = api_url(f.data "file")
    f.find(":input").prop "disabled", true
  get_content = $.get url,
    headers: "Authorization": "token #{storage.get("login.token")}"
  if debug
    get_content.fail (request, status, error) -> alert "#{status}: #{error}"
  if $.type(f) isnt "string"
    get_content.always () -> f.find(":input").prop "disabled", false
  return get_content

api_put = (f, load) ->
  if !storage.get "login.token" then return alert "You need to login"
  if $.type(f) is "string"
    url = api_url(f)
  else
    url = api_url(f.data "file")
    f.find(":input").prop "disabled", true
  put_content = $.ajax url,
    headers: "Authorization": "token #{storage.get("login.token")}"
    method: "PUT"
    data: JSON.stringify load
  put_content.fail (request, status, error) -> alert "#{status}: #{error}"
  put_content.done (data, status) ->
    alert "#{load.message}: #{status}"
    data["commit"]["commit"] = data["commit"]
    compare data
    if $.type(f) isnt "string" then f.trigger "reset"
  if $.type(f) isnt "string"
    put_content.always () -> f.find(":input").prop "disabled", false
  return put_content

api_url = (file) -> "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/contents/_data/#{file}.yml"