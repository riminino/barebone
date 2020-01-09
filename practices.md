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

```liquid
{% raw %}{% include forms/add_item.html schema=page.practice %}{% endraw %}
```

{% include forms/add_item.html schema=page.practices %}