{% assign repository = site.github.public_repositories | where: "html_url", site.github.repository_url | first %}
check_sha = () ->
  head_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/branches/{{ repository.default_branch }}"
  $.ajax head_url,
    method: 'GET'
    headers:
      authorization: "token #{storage.get("login.token")}"
      accept: "application/vnd.github.v3.full+json"
    success: compare
    error: (request, status, error) -> alert "error: #{status} #{error}"
  true

compare = (data) ->
  if data.commit.sha != "{{ site.github.build_revision }}"
    $("#build").text("(waiting site build)")
  return

if storage.get("login.token") and "{{ site.github.environment }}" == "dotcom" then check_sha()