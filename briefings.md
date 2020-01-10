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

## Add item

Embed input form:

```liquid
{% raw %}{% include forms/add_item.html schema=page.briefings %}{% endraw %}
```

{% include forms/add_item.html schema=page.briefings %}

## List

Embed event list:

```liquid
{% raw %}{% include time/list.html schema=page.briefings %}{% endraw %}
```

{% include time/list.html schema=page.briefings %}

