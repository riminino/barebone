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

{% include widgets/collapsed.html open=true summary="Briefings schema" %}

```yml
briefings:
  file: briefings
  properties:
    date:
      type: date
      required: true
      time: "12:00"
    reported:
      list: [CC, CCC]
```

{% include widgets/collapsed.html close=true %}

## Manage

Embed form and table:

```liquid
{% raw %}{% include schema/manage.html schema=page.briefings %}{% endraw %}
```

{% include schema/manage.html schema=page.briefings %}