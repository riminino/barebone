---
---

# Includes
{% include scripts/storage.coffee %}
{% include scripts/login.coffee %}
{% include scripts/datetime.coffee %}
{% include scripts/sha.coffee %}
{% include scripts/filters.coffee %}
{% include scripts/api.coffee %}
{% include scripts/manage.coffee %}
{% include scripts/create.coffee %}


# Get storage
console.log storage.get()

# Prevent default events on forms and links
$("body").on "submit", "form[data-prevent]", (e) -> e.preventDefault()
$("body").on "click", "a[data-prevent]", (e) -> e.preventDefault()
