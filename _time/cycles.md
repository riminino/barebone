---
weight: 7
cycles:
  file: time/cycles
  properties:
    date:
      type: date
      required: true
      repeat:
        value: 28
        unit: day
---

# Cycles

```liquid
{% raw %}{% include schema/manage.html schema=page.cycles table="future" %}{% endraw %}
```

{% include schema/manage.html schema=page.cycles table="future" %}