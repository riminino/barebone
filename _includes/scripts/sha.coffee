{% assign repository = site.github.public_repositories | where: "html_url", site.github.repository_url | first %}
if storage.get("login.token") and "{{ site.github.environment }}" == "dotcom"
  head_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/branches/{{ repository.default_branch }}"
  get_branch = $.ajax head_url,
    method: "GET"
    cache: false
    headers: "Authorization": "token #{storage.get("login.token")}"
  get_branch.fail (request, status, error) -> alert "#{status} #{error}"
  get_branch.done (data) ->
    compare data
    built = data.commit.commit.author.date.substr(0,10)
    now = new Date().toISOString().split('T')[0]
    if built isnt now and storage.get("repository.updated") isnt now
      console.log "#{built} #{now} requesting build"
      build_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/pages/builds"
      daily_build = $.ajax build_url,
        method: "POST"
        headers: "Authorization": "token #{storage.get("login.token")}"
      daily_build.done () -> storage.set "repository.updated", now
      daily_build.fail (request, status, error) -> alert "#{status} #{error}"
    true

compare = (data) ->
  if data.commit.sha != "{{ site.github.build_revision }}"
    # Update navigation
    span = $("<span/>",{
      datetime: new Date(data.commit.commit.author.date)
      text: "Building"
    })
    dateTime span
    $("#update").empty().append span
  $("#update").show()
  return