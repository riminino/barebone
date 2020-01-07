# COMMIT function
commit = (object, file) ->
  commit_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/contents/_data/#{file}.yml"
  get_sha = () ->
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
    alert "create_file: #{status} #{error}"
    true
  update_file = (data, status) ->
    # Commit
    $.ajax commit_url,
      method: 'PUT'
      headers: "Authorization": "token #{storage.get("login.token")}"
      data: JSON.stringify {
        message: "update_file #{file}"
        sha: data.sha
        content: btoa object
      }
      success: file_updated
      error: error
    true
  file_updated = (data, status) ->
    console.log data
    store_sha data
    alert "file_updated: #{status}"
    true
  file_created = (data, status) ->
    store_sha data
    alert "file_created: #{status}"
    true
  store_sha = (data) ->
    storage.set 'repository.sha', data.sha
    console.log data
    true
  # Start commit
  get_sha()
  return