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
- `file` (optional extension, will be set to `yml`)
- `action` Default to `add`, can be `create`
- `personal` boolean, to prepend username to file path, for conflicts
- `properties`

### Properties

- `title` (default to capitalized property name)
- `description`
- `tooltip` Text visualized on mousehover
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
  - `textarea`
  - `url`
  - `email`
- `repeat` (recurrent event every value-unit)
  - `value` (0 = no repeat)
  - `unit`
- `list` (array of values or objects with `value`)
  - `value`
  - `style` (CSS properties with a value)
    - `css-property`
    - ...
- `multiple` for list and email
- `value` (default value)
- `min` for number
- `max` for number
- `step` for number
- `maxlength` for text
- `minlength` for text
- `required`
- `placeholder`
- `rows` for textarea
- `cols` for textarea
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