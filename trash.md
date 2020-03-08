---
weight: 5
trash:
  file: trash
  properties:
    date:
      type: date
      repeat:
        value: 2
        unit: week
    waste:
      description: Type
      list:
        - value: Mixed
          style:
            background: Black
            color: White
        - value: Paper
          style:
            background: Blue
            color: White
        - value: Plastic
          style:
            background: Yellow
        - value: Glass
          style:
            background: ForestGreen
          repeat:
            value: 4
            unit: week
---

# Trash

{% include widgets/collapsed.html open=true summary="Trash schema" %}

```yml
file: trash
properties:
  date:
    type: date
    repeat:
      value: 2
      unit: week
  waste:
    description: Type fo waste
    list:
      - value: Mixed
        style:
          background: Black
          color: White
      - value: Paper
        style:
          background: Blue
          color: White
      - value: Plastic
        style:
          background: Yellow
      - value: Glass
        style:
          background: ForestGreen
        repeat:
          value: 4
          unit: week
```

{% include widgets/collapsed.html close=true %}

## Add item

Embed input form:

```liquid
{% raw %}{% include forms/add_item.html schema=page.trash %}{% endraw %}
```

{% include forms/add_item.html schema=page.trash %}

## Future

Embed future event table:

```liquid
{% raw %}{% include time/future.html schema=page.trash %}{% endraw %}
```

{% include time/future.html schema=page.trash %}
