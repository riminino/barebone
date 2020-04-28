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

- `title` default to capitalized file
- `file` optional extension, will be set to `yml`
- `action` Default to `add`, can be `create`
- `personal` boolean, to prepend username to file path, for conflicts
- `properties`

**Theory**

- `schema` Declare a Schema, not required, also draft specification
- Path
  - `id` URI reference: unique identifier and a base URI (absolute for top-level schema)
  - `ref` URI reference, point to a fregment in the same or different file. Can be recursive
- String
  - `minLength`, `maxLength`, `pattern`, `regex`
  - `format`: `date`, `time`, `date-time`, `email`, `hostname`, `uri`
- Numbers
  - `integer` is a type that correspond to `number` `multipleOf: 1.0`
  - `minimum`, `exclusiveMinimum`, `maximum`, `exclusiveMaximum`
- Root properties
  - `properties`
  - `definitions`
  - `required` Array of properties
  - `dependencies` properties with array of required properties
- `emun` array (of a optionally defined `type`). Restrict a value to a fixed set
- `enumNames` array of names
- `object` type has key-value pairs defined by `properties`
- Array
  - `array` type has `items:` with their own `type: ...` and `properties`
  - `minItems`, `maxItems`
- Annotations
  - `title`, `description`, `examples`
  - `default` for `type: array` can be an array
- `contentMediaType` could be `text/html`
- `contentEncoding` can be `7bit, 8bit, binary, quoted-printable, base64`
- Conditional subschema  

```yml
allOf:
  - if:
      properties:
        country:
          const: "String1"
    then:
      properties:
        postal_code:
          pattern: "..."
  - if:
      properties:
        country:
          const: "String2"
    then:
      properties:
        postal_code:
          pattern: "..."
```

### Properties

- `title` default to capitalized property name
- `description`
- `tooltip` Text visualized on mousehover
- `type` default to `text`
  - `text`
  - `number`
  - `color`
  - `date`
    - `time` string for time offset: `12:00` or `12:00:00`
    - `repeat` recurrent event every value-unit
      - `value` 0 = no repeat
      - `unit` day, week, month, year
        - `exception` custom value-unit recurrence for `condition`
          - `condition`
          - `...`
          - `value` day, week, month, year
          - `unit` 0 = no repeat
  - `schema`
    - `properties`
  - `textarea`
  - `url`
  - `email`
- `repeat` recurrent event every value-unit
  - `value` 0 = no repeat
  - `unit` day, week, month, year
- `list` array of values or objects with `value`
  - `value`
  - `style` CSS properties with a value
    - `css-property`
    - ...
- `multiple` for list and email
- `value` default value
- `min` for number
- `max` for number
- `step` for number
- `maxlength` for text
- `minlength` for text
- `required`
- `placeholder`
- `rows` for textarea
- `cols` for textarea
- `style` CSS properties with a value
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

# Examples

**Single array file, `timestamp` as added property**

`folder/file.yml`

```yml
-
  property: value
  timestamp: 1582884954735
-
  property: value
  timestamp: 1582884954736
```

**Single object file, `timestamp` as objects index**

`folder/file.yml`

```yml
1582884954735:
  property: value
1582884954736:
  property: value
```

**Multiple object files, `timestamp` as filename**

`folder/file/1582884954735.yml`

```yml
property: value
```

`folder/file/1582884954736.yml`

```yml
property: value
```