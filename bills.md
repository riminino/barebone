---
weight: 7
bills:
  file: bills
  properties:
    date:
      type: date
      required: true
      repeat:
        value: 2
        unit: month
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

{% include schema/manage.html schema=page.bills %}

{% include time/future.html schema=page.bills %}
