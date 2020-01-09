---
weight: 3
cars:
  file: cars
  properties:
    date:
      type: date
    car:
      list: [kangoo, yaris, citroen]
    tax:
      list: [assicurazione, bollo, revisione]
---

# Cars

```liquid
{% raw %}{% include forms/add_item.html schema=page.cars %}{% endraw %}
```

{% include forms/add_item.html schema=page.cars %}