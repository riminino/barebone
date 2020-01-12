if storage.get("repository.sha") != "{{ site.github.build_revision }}"
  $("#build").text("(waiting site build)")