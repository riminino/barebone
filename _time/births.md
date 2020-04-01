---
weight: 6
births:
  file: births
  properties:
    date:
      type: date
      required: true
      repeat:
        value: 1
        unit: year
    name: true
---

# Briths

{% include schema/manage.html schema=page.births %}

{% include time/future.html schema=page.births %}