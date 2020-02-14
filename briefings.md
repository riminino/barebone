---
weight: 4
briefings:
  file: briefings
  properties:
    date:
      type: date
    reported:
      list: [CC, CCC]
---

# Briefing

- The act or an instance of giving instructions or preparatory information to someone.
- A meeting at which such information is presented.
- The information conveyed at such a meeting.

{% include widgets/collapsed.html open=true summary="Briefings schema" %}

```yml
file: briefings
properties:
  date:
    type: date
  reported:
    list: [CC, CCC]
```

{% include widgets/collapsed.html close=true %}

## Add item

Embed input form:

```liquid
{% raw %}{% include forms/add_item.html schema=page.briefings %}{% endraw %}
```

{% include forms/add_item.html schema=page.briefings %}

## Table

Embed event table:

```liquid
{% raw %}{% include time/table.html schema=page.briefings %}{% endraw %}
```

{% include time/table.html schema=page.briefings %}

