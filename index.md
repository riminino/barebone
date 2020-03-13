---
weight: 1
---

# Home

- Add list item
  - Date (calendar)
  - Type (dropdown list)

## Schema

- `title` (default to capitalized file)
- `file`
- `properties`

### Property

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
      - `unit`
        - exception (custom value-unit recurrence for `condition`)
          - `condition`
          - `...`
          - `value`
          - `unit`
- `list` (array of values or objects with `value`)
  - `value`
  - `style` (CSS properties with a value)
    - css-property
    - ...
- `value` (default value)
- `min`
- `max`
- `required`