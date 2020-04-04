---
weight: 4
briefings:
  file: time/briefings
  properties:
    date:
      type: date
      required: true
      time: "12:00"
    reported:
      list: [CC, CCC]
---

# Briefing

- The act or an instance of giving instructions or preparatory information to someone.
- A meeting at which such information is presented.
- The information conveyed at such a meeting.

{% include widgets/collapsed.html summary="Briefings schema" %}

```yml
briefings:
  file: time/briefings
  properties:
    date:
      type: date
      required: true
      time: "12:00"
    reported:
      list: [CC, CCC]
```

{% include widgets/collapsed.html %}

## Manage

Embed form and table:

```liquid
{% raw %}{% include schema/manage.html schema=page.briefings collapsed=true %}{% endraw %}
```

{% include schema/manage.html schema=page.briefings collapsed=true %}

{% include time/table.html schema=page.briefings filter="date" %}