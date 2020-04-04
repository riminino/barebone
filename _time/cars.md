---
weight: 3
cars:
  file: time/cars
  properties:
    date:
      type: date
      required: true
      repeat:
        unit: year
        value: 1
        exception:
          car: yaris
          tax: assicurazione
          unit: month
          value: 6
    car:
      list: [kangoo, yaris, citroen]
    tax:
      list: [assicurazione, bollo, revisione]
---

# Cars

{% include widgets/collapsed.html summary="Cars schema" %}

```yml
cars:
  file: time/cars
  properties:
    date:
      type: date
      required: true
      repeat:
        unit: year
        value: 1
        exception:
          car: yaris
          tax: assicurazione
          unit: month
          value: 6
    car:
      list: [kangoo, yaris, citroen]
    tax:
      list: [assicurazione, bollo, revisione]
```

{% include widgets/collapsed.html %}

## Manage

Embed form and table:

```liquid
{% raw %}{% include schema/manage.html schema=page.cars collapsed=true %}{% endraw %}
```

{% include schema/manage.html schema=page.cars collapsed=true %}

## Future

Embed future event table:

```liquid
{% raw %}{% include time/future.html schema=page.cars %}{% endraw %}
```

{% include time/future.html schema=page.cars %}