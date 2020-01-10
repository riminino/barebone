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

Cars schema:

```yml
file: cars
properties:
  date:
    type: date
  car:
    list: [kangoo, yaris, citroen]
  tax:
    list: [assicurazione, bollo, revisione]
```

## Add item

Embed input form:

```liquid
{% raw %}{% include forms/add_item.html schema=page.cars %}{% endraw %}
```

{% include forms/add_item.html schema=page.cars %}

## List

Embed event list:

```liquid
{% raw %}{% include time/list.html schema=page.cars %}{% endraw %}
```

{% include time/list.html schema=page.cars %}

