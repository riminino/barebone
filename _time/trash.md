---
weight: 4
trash:
  file: time/trash
  properties:
    date:
      type: date
      required: true
      repeat:
        value: 2
        unit: week
        exception:
          waste: Glass
          value: 4
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
            color: White
---

# Trash

{% include widgets/collapsed.html summary="Trash schema" %}

```yml
trash:
  file: time/trash
  properties:
    date:
      type: date
      required: true
      repeat:
        value: 2
        unit: week
        exception:
          waste: Glass
          value: 4
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
            color: White
```

{% include widgets/collapsed.html %}

## Manage

Embed form and table:

```liquid
{% raw %}{% include schema/manage.html schema=page.trash table="future" %}{% endraw %}
```

{% include schema/manage.html schema=page.trash table="future" %}
