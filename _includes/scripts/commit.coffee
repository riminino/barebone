# COMMIT function
commit = (object, form) ->
  file = form.data "file"
  inputs = form.find ":input"
  commit_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/contents/_data/#{file}.yml"
  get_sha = () ->
    inputs.prop "disabled", true
    $.ajax commit_url,
      method: 'GET'
      headers:
        authorization: "token #{storage.get("login.token")}"
        accept: "application/vnd.github.v3.full+json"
      success: update_file
      error: error_sha
    true
  error_sha = (request, status, error) ->
    if error == 'Not Found'
      create_file()
    else
      inputs.prop "disabled", false
      alert "get_sha(): #{status} #{error}"
    true
  ###  
  Create new file
  @param message {string}
  @param content {string}
  ###
  create_file = () ->
    # PUT /repos/:owner/:repo/contents/:path
    $.ajax commit_url,
      method: 'PUT'
      headers: "Authorization": "token #{storage.get("login.token")}"
      data: JSON.stringify {
        message: "create_file #{file}"
        content: btoa object
      }
      success: file_created
      error: error
    true
  error = (request, status, error) ->
    inputs.prop "disabled", false
    alert "create_file: #{status} #{error}"
    true
  update_file = (data, status) ->
    console.log atob(data.content), YAML.parse atob(data.content)
    # Commit
    $.ajax commit_url,
      method: 'PUT'
      headers: "Authorization": "token #{storage.get("login.token")}"
      data: JSON.stringify {
        message: "update_file #{file}"
        sha: data.sha
        content: btoa(atob(data.content)+object)
      }
      success: file_updated
      error: error
    true
  file_updated = (data, status) ->
    reset()
    alert "file_updated: #{status}"
    data["commit"]["commit"] = data["commit"]
    compare data
    true
  file_created = (data, status) ->
    reset()
    alert "file_created: #{status}"
    true
  reset = () ->
    inputs.prop "disabled", false
    form.trigger "reset"
    true
  # Start commit
  get_sha()
  return