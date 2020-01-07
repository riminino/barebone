---
practice:
  file: practices
  properties:
    date:
      type: date
      required: true
    type:
      type: list
      list: [1, 2, 3]
    repetition:
      type: number
      min: 0
---

# Home

- Add list item
  - Date (calendar)
  - Type (dropdown list)

Second:
5,6/1

```liquid
{% raw %}{% include forms/add_item.html schema=page.practice %}{% endraw %}
```

{% include forms/add_item.html schema=page.practice %}