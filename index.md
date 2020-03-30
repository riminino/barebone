---
weight: 1
life:
  title: Life
  properties:
    bacteria:
      title: Domain [Bacteria](#)
      properties:
        Kingdom Monera: true
    empire:
      title: Empire [Eukaryota](#)
      properties:
        Kingdom Protista: true
        Kingdom Plantae: true
        Kingdom Animalia: true
---

# Home

- Add list item
  - Date (calendar)
  - Type (dropdown list)

## Schema

- `title` (default to capitalized file)
- `file` (no extension, assumed `yml`)
- `properties`

### Properties

- `title` (default to capitalized property name)
- `description`
- `unit`
- `type` (default to `text`)
  - `text`
  - `number`
  - `color`
  - `date`
    - `time` (string for time offset: `12:00` or `12:00:00`)
    - `repeat` (recurrent event every value-unit)
      - `value`
      - `unit` (day, week, month, year)
        - `exception` (custom value-unit recurrence for `condition`)
          - `condition`
          - `...`
          - `value` (day, week, month, year)
          - `unit`
  - `schema`
    - `properties`
- `repeat` (recurrent event every value-unit)
  - `value` (0 = no repeat)
  - `unit`
- `list` (array of values or objects with `value`)
  - `value`
  - `style` (CSS properties with a value)
    - `css-property`
    - ...
- `value` (default value)
- `min`
- `max`
- `required`
- `style` (CSS properties with a value)
  - `css-property`
  - ...

# Tree

{% include widgets/collapsed.html open=true %}
```yml
life:
  title: Life
  properties:
    bacteria:
      title: Domain [Bacteria](#)
      properties:
        Kingdom Monera: true
    empire:
      title: Empire [Eukaryota](#)
      properties:
        Kingdom Protista: true
        Kingdom Plantae: true
        Kingdom Animalia: true
```
{% include widgets/collapsed.html close=true %}

```liquid
{% raw %}{% include widgets/tree.html tree=page.life %}{% endraw %}
```

{% include widgets/tree.html tree=page.life %}