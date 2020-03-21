{% assign repository = site.github.public_repositories | where: "html_url", site.github.repository_url | first %}
if storage.get("login.token") and "{{ site.github.environment }}" == "dotcom"
  head_url = "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}/branches/{{ repository.default_branch }}"
  get_branch = $.ajax head_url,
    method: "GET"
    cache: "false"
    headers: "Authorization": "token #{storage.get("login.token")}"
    success: compare
  get_branch.fail (request, status, error) -> alert "error: #{status} #{error}"
  get_branch.done
  true

compare = (data) ->
  if data.commit.sha != "{{ site.github.build_revision }}"
    span = $("<span/>",{
      datetime: new Date(data.commit.commit.author.date)
      "data-replace": "true"
    })
    dateTime span
    li = $("<li/>",{
      text: "Repository updated "
      title: data.commit.commit.message
    }).append(span).append " <i>[#{data.commit.sha.slice(0,7)}]</i>"
    $("#build").append li
  return