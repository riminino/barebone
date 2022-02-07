{%- assign repository = site.github.public_repositories | where: "html_url", site.github.repository_url | first -%}
# Check default branch sha
check_sha = () ->
  head_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/branches/{{ repository.default_branch }}"
  get_branch = $.ajax head_url,
    method: "GET"
    cache: false
    headers: "Authorization": "token #{storage.get("login.token")}"
  get_branch.fail (request, status, error) -> alert "#{status} #{error}"
  get_branch.done (data) -> compare data.commit.sha, data.commit.commit.author.date
  true

# Compare build revisions sha and show updates
compare = (sha, date) ->
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

# Works only online
if "{{ site.github.environment }}" is "dotcom" or "production"
  if !storage.get("login.token")
    # Not logged will wait for rebuild
    $("#update").show()
  else
    if !storage.get "login.permissions.admin"
      # Logged will check branch sha
      check_sha()
    else
      # Admins will check daily update
      now = new Date().toISOString()
      if "{{ 'now' | date: '%F' }}" is now.split('T')[0]
        # Today updated, check sha
        check_sha()
      else
        # Check daily requested page buil
        updated = storage.get "repository.updated"
        if updated.split?('T')[0] isnt now.split('T')[0]
          # Request page build
          storage.set "repository.updated", now
          build_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/pages/builds"
          daily_build = $.ajax build_url,
            method: "POST"
            headers: "Authorization": "token #{storage.get("login.token")}"
          daily_build.fail (request, status, error) -> alert "#{status} #{error}"
          daily_build.done () -> compare 0, now
        else
          # Page build requested
          compare 0, updated
