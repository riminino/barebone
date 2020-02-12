---
weight: 2
practices:
  file: practices
  properties:
    date:
      type: date
      required: true
    serie:
      type: number
      list: [1, 2, 3]
---

# Practices

Practices schema:

```yml
file: practices
properties:
  date:
    type: date
    required: true
  serie:
    type: number
    list: [1, 2, 3]
```

## Add item

Embed input form:

```liquid
{% raw %}{% include forms/add_item.html schema=page.practice %}{% endraw %}
```

{% include forms/add_item.html schema=page.practices %}

## Table

Embed event table:

```liquid
{% raw %}{% include time/table.html schema=page.practices collapsed=true %}{% endraw %}
```

{% include time/table.html schema=page.practices collapsed=true %}
