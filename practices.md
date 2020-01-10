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

## Add item

Embed input form:

```liquid
{% raw %}{% include forms/add_item.html schema=page.practice %}{% endraw %}
```

{% include forms/add_item.html schema=page.practices %}

## List

Embed event list:

```liquid
{% raw %}{% include time/list.html schema=page.practices details=true %}{% endraw %}
```

{% include time/list.html schema=page.practices details=true %}
