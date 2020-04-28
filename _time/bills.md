---
weight: 6
bills:
  file: time/bills
  properties:
    date:
      type: date
      required: true
    name:
      required: true
    amount:
      type: number
      unit: euro
      step: 0.01
      style:
        text-align: right
    repeat:
      type: schema
      properties:
        value:
          type: number
          value: 0
        unit:
          list: [day,week,month,year]
---

# Bills

```liquid
{% raw %}{% include schema/manage.html schema=page.bills table="future" filter="name" %}{% endraw %}
```

{% include schema/manage.html schema=page.bills table="future" filter="name" %}

{% include widgets/tree.html tree=page.bills %}