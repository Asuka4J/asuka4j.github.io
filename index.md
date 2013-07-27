---
  layout: page
  title: 
  tagline: 
---

{% include JB/setup %}

<center><img id="9EE382F35E616D3ED837772593F8B767" src="http://pic.yupoo.com/asuka4j/D2C98pNC/medish.jpg" /></center>

    
## Recent Posts

<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

## To-Do

This theme is still unfinished. If you'd like to be added as a contributor, [please fork](http://github.com/plusjade/jekyll-bootstrap)!
We need to clean up the themes, make theme usage guides with theme-specific markup examples.


