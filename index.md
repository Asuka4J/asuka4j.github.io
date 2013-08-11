---
 layout: pageindex
 title: 
 tagline: 
---
{% include JB/setup %}
<table height="90%" border="0" align="center"><tr><td>
</br>
</br>
</br>
</br>
</br>
</br>
<center><img id="9EE382F35E616D3ED837772593F8B767" src="http://pic.yupoo.com/asuka4j/D2C98pNC/medish.jpg" /></center>
<center>
<img id="jiaqinglogoline" src="http://pic.yupoo.com/asuka4j/D2EHePXh/medish.jpg"/>&nbsp;&nbsp;</br>
<strong>Jiaqing's Foolish Thoughts&nbsp;&nbsp;</strong></br>
Thought fragments about: life, programming,</br>
workthinking, reading and hobbies.</br>
<!--&amp;</br>-->
</center>
</br>
<center><img id="sapprow" src="http://pic.yupoo.com/asuka4j/D2Cia9Jc/medish.jpg"/></center>
</br>
</br>
</br>
</br>
</br>
</br>
</td></tr></table>
</br>
</br>
</br>
</br>
</br>
</br> 
### Recent Post
<ul class="postsList">
  {% for post in site.posts %}
  <li><span>{{ post.date | date_to_string }}</span> <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

