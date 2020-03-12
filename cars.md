---
weight: 3
cars:
  file: cars
  properties:
    date:
      type: date
      repeat:
        unit: year
        value: 1
        exception:
          car: yaris
          tax: assicurazione
          unit: day
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

## Future

Embed future event table:

```liquid
{% raw %}{% include time/future.html schema=page.cars %}{% endraw %}
```

{% include time/future.html schema=page.cars %}