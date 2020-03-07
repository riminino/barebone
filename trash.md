---
weight: 5
trash:
  file: trash
  properties:
    date:
      type: date
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
---

# Trash

{% include widgets/collapsed.html open=true summary="Trash schema" %}

```yml
file: trash
properties:
  date:
    type: date
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
```

{% include widgets/collapsed.html close=true %}

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
