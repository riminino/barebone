---
weight: 2
practices:
  file: practices
  properties:
    date:
      type: date
      required: true
      time: "12:00"
    serie:
      type: number
      list: [1, 2, 3]
---

# Practices

Practices schema:

```yml
file: practices
properties:
  date:
    type: date
    required: true
    time: "12:00"
  serie:
    type: number
    list: [1, 2, 3]
```

# Add item

Embed input form:

```liquid
{% raw %}{% include forms/add_item.html schema=page.practice %}{% endraw %}
```

{% include forms/add_item.html schema=page.practices %}

## Table

Embed event table:

```liquid
{% raw %}{% include time/table.html schema=page.practices filters=true year="2020" collapsed=true %}{% endraw %}
```

{% include time/table.html schema=page.practices filters=true year="2020" collapsed=true %}

## Days

Embed days stream.

```liquid
{% raw %}{% include time/days.html schema=page.practices %}{% endraw %}
```

{% include time/days.html schema=page.practices %}

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