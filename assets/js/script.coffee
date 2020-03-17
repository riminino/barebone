---
---

# Includes
{% include scripts/storage.coffee %}
{% include scripts/login.coffee %}
{% include scripts/datetime.coffee %}
{% include scripts/sha.coffee %}
{% include scripts/filters.coffee %}
{% include scripts/manage.coffee %}


# Get storage
console.log storage.get()

# Helpers
$("form[data-action]").on "submit", (e) ->
  e.preventDefault()
  return

$("a.edit, a.remove").on "click", (e) ->
  e.preventDefault()
  return