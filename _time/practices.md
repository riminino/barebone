---
weight: 2
practices:
  file: time/practices
  properties:
    date:
      type: date
      required: true
      time: "12:00"
    serie:
      type: number
      list:
        - value: 1
          style:
            background-color: Honeydew
        - value: 2
          style:
            background-color: SeaShell
        - value: 3
          style:
            background-color: LavenderBlush
---

# Practices

Practices schema:

```yml
file: time/practices
properties:
  date:
    type: date
    required: true
    time: "12:00"
  serie:
    type: number
    list:
      - value: 1
        style:
          background-color: Honeydew
      - value: 2
        style:
          background-color: SeaShell
      - value: 3
        style:
          background-color: LavenderBlush
```

# Manage

Embed input form:

```liquid
{% raw %}{% include schema/manage.html schema=page.practice collapsed="true" filter="date" year="2020" %}{% endraw %}
```

{% include schema/manage.html schema=page.practices collapsed=true filter="date" year="2020" %}

## Calendar

Embed a calendar view

```liquid
{% raw %}{% include time/calendar.html schema=page.practices collapsed=true filters=true year="2020" property="serie" %}{% endraw %}
```

{% include time/calendar.html schema=page.practices collapsed=true filters=true year="2020" property="serie" %}

## Weeks

```liquid
{% raw %}{% include time/weeks.html schema=page.practices %}{% endraw %}
```

{% include time/weeks.html schema=page.practices %}

## Months

```liquid
{% raw %}{% include time/months.html schema=page.practices %}{% endraw %}
```

{% include time/months.html schema=page.practices %}

## Group

```liquid
{% raw %}{% include time/group.html property="serie" schema=page.practices %}{% endraw %}
```

{% include time/group.html property="serie" schema=page.practices %}