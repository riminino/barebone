---
weight: 5
trash:
  file: trash
  properties:
    date:
      type: date
    waste:
      list: [Mixed, Paper, Plastic, Glass]
      description: Type fo waste
    color:
      list: [Black, Blue, Yellow, Green]
    every:
      type: number
      unit: days
      min: 0
---

# Trash

Trash schema:

```yml
file: trash
properties:
  date:
    type: date
  waste:
    list: [Mixed, Paper, Plastic, Glass]
    description: Type fo waste
  color:
    list: [Black, Blue, Yellow, Green]
  every:
    type: number
    unit: days
    min: 0
```

## Add item

Embed input form:

```liquid
{% raw %}{% include forms/add_item.html schema=page.trash %}{% endraw %}
```

{% include forms/add_item.html schema=page.trash %}

## Table

Embed event table:

```liquid
{% raw %}{% include time/table.html schema=page.trash %}{% endraw %}
```

{% include time/table.html schema=page.trash %}
