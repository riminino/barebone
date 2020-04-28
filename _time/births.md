---
weight: 5
births:
  file: time/births
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

{% include schema/manage.html schema=page.births table="future" %}