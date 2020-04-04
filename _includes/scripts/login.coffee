###
  Need:
  - Login link with id="login-button"
###
{% assign repository = site.github.public_repositories | where: "html_url", site.github.repository_url | first %}
login = {
  link: $ "#login-button"
  init: () ->
    if storage.get("login.token") and login.link.text() == "Login"
      login.link.text 'Logout'
        .off "click"
        .on "click", login.logout
        .attr "title", "Logged as #{storage.get('login.user')}"
    else
      login.link.on "click", login.serve
    login.link.show()
    true
  serve: (e) ->
    e.preventDefault()
    token = prompt "Paste a GitHub personal token"
    if token
      storage.set "login.token", token
      login.link.prop "disabled", true
      $.ajax "{{ site.github.api_url }}/user",
        method: "GET"
        headers: "Authorization": "token #{token}"
        success: login.success
        error: login.error
        complete: login.complete
    true
  complete: (request, status) ->
    login.link.prop "disabled", false
  success: (data, status) ->
    storage.set "login.user", data.login
      .set "login.created", new Date()
    login.link.text "Logout"
      .off "click"
      .on "click", login.logout
      .attr "title", "Logged as #{data.login}"
    alert "Logged as #{data.login}"
    login.permissions data.login
    true
  error: (request, status, error) ->
    storage.clear "login"
    alert "Login #{status}: #{error}"
    true
  logout: (e) ->
    e.preventDefault()
    storage.clear()
    $(e.target).text "Login"
      .off "click"
      .on "click", login.serve
      .attr "alt", "Login button"
    alert "Logged out"
    true
  permissions: (user) ->
    repo = $.ajax "{{ site.github.api_url }}/repos/{{ site.github.repository_nwo }}",
      method: "GET"
      headers: "Authorization": "token #{storage.get 'login.token'}"
      success: (data, status) -> storage.set "login.permissions", data.permissions
      error: (request, status, error) -> alert "This repo #{status} #{error}"
    true
}
login.init()