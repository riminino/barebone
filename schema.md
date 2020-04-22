---
weight: 1
create:
  title: schema
  action: create
  properties:
    file:
      description: Extension optional
      placeholder: "folders/filename"
      tooltip: "Path to istance files"
      required: true
    personal:
      type: checkbox
      tooltip: Will save the istance inside a `username` folder
    title:
      description: Default to `file`
    action:
      value: add
      list: [add,create]
    properties:
      type: property
      properties:
        type:
          list: [text,number,date,color,schema]
          required: true
        title: true
        description: true
        placeholder: true
        tooltip: true
        value: true
        list:
          type: array
        required:
          type: checkbox
        repeat:
          type: schema
          properties:
            value:
              type: number
              value: 0
              subordinate: date
              description: Repeat value
            unit:
              list: [day,week,month,year]
              subordinate: date
              description: Repeat unit
        properties:
          type: property
          subordinate: schema
          properties:
            type:
              list: [text,number,date,color,schema]
              required: true
        time:
          type: time
          subordinate: date
        unit:
          type: text
          subordinate: number
        step:
          type: number
          step: 0.000000001
          subordinate: number
        min:
          type: number
          subordinate: number
        max:
          type: number
          subordinate: number
        maxlength:
          type: number
          subordinate: text
        minlength:
          type: number
          subordinate: text
---

# Schema

```liquid
{% raw %}{% include schema/form.html schema=page.create %}{% endraw %}
```

{% include schema/form.html schema=page.create %}

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
  - `properties` For schemas: add properties
  - `array` Add a list
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
- `step`
- `maxlength`
- `minlength`
- `required`
- `placeholder`
- `style` (CSS properties with a value)
  - `css-property`
  - ...