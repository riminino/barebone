api_get = (f, debug) ->
  if $.type(f) is "string"
    url = api_url(f)
  else
    url = api_url(f.data "file")
    f.find(":input").prop "disabled", true
  get_content = $.ajax url,
    headers: "Authorization": "token #{storage.get("login.token")}"
    method: "GET"
    cache: false
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
    compare data.commit.sha, data.commit.author.date
    true
  if $.type(f) isnt "string"
    put_content.always () ->
      f.find(":input").prop "disabled", false
      f.trigger "reset"
      true
  return put_content

api_url = (file) ->
  if file.split(".").slice(-1)[0] not in ["yml", "yaml"] then file = file + ".yml"
  return "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/contents/_data/#{file}"