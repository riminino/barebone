---
weight: 1
life:
  title: Life
  properties:
    bacteria:
      title: Domain [Bacteria](#)
      properties:
        Kingdom Monera: true
    empire:
      title: Empire [Eukaryota](#)
      properties:
        Kingdom Protista: true
        Kingdom Plantae: true
        Kingdom Animalia: true
---

# Home

- Add list item
  - Date (calendar)
  - Type (dropdown list)

# Tree

{% include widgets/collapsed.html open=true %}
```yml
life:
  title: Life
  properties:
    bacteria:
      title: Domain [Bacteria](#)
      properties:
        Kingdom Monera: true
    empire:
      title: Empire [Eukaryota](#)
      properties:
        Kingdom Protista: true
        Kingdom Plantae: true
        Kingdom Animalia: true
```
{% include widgets/collapsed.html close=true %}

```liquid
{% raw %}{% include widgets/tree.html tree=page.life %}{% endraw %}
```

{% include widgets/tree.html tree=page.life %}