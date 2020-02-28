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
    every:
      type: hidden
      value: 2
      unit: month
---

# Bills

{% include forms/add_item.html schema=page.bills %}

{% include time/table.html schema=page.bills %}