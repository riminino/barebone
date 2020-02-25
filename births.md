---
weight: 6
births:
  file: births
  properties:
    date:
      type: date
    name: true
---

# Briths

{% include forms/add_item.html schema=page.births %}

{% include time/table.html schema=page.births %}