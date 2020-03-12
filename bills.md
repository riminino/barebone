---
weight: 7
bills:
  file: bills
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
---

# Bills

{% include forms/add_item.html schema=page.bills %}

{% include time/table.html schema=page.bills %}
