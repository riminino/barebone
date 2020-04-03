{% assign repository = site.github.public_repositories | where: "html_url", site.github.repository_url | first %}
if storage.get("login.token") and "{{ site.github.environment }}" == "dotcom"
  now = new Date().toISOString()
  if "{{ 'now' | date: '%F' }}" is now.split('T')[0]
    # Check sha
    head_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/branches/{{ repository.default_branch }}"
    get_branch = $.ajax head_url,
      method: "GET"
      cache: false
      headers: "Authorization": "token #{storage.get("login.token")}"
    get_branch.fail (request, status, error) -> alert "#{status} #{error}"
    get_branch.done (data) -> compare data.commit.sha, data.commit.commit.author.date
  else
    updated = storage.get "repository.updated"
    if updated.split('T')[0] isnt now.split('T')[0]
      storage.set "repository.updated", now
      build_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/pages/builds"
      daily_build = $.ajax build_url,
        method: "POST"
        headers: "Authorization": "token #{storage.get("login.token")}"
      daily_build.fail (request, status, error) -> alert "#{status} #{error}"
    compare 0, storage.get("repository.updated")

compare = (sha, date) ->
  console.log sha, date
  if sha != "{{ site.github.build_revision }}"
    # Update navigation
    span = $("<span/>",{
      datetime: new Date(date)
      text: "Building"
    })
    dateTime span
    $("#update").empty().append span
  $("#update").show()
  return