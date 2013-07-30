---
 layout: pageindex
 title: 
 tagline: 
---
{% include JB/setup %}
<!--<table height="90%" border="0" align="center"><tr><td>-->
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
blog&nbsp;<a href="http://jiaqing.me">jiaqing.me</a>,&nbsp;email&nbsp;<a href="mailto:asuka4j@gmail.com">asuka4j@gmail.com</a>&nbsp;</br>
more&nbsp;<a href="http://weibo.com/Asuka4J">weibo</a>,&nbsp;<a href="http://www.douban.com/people/Asuka4J/">douban</a>,&nbsp;<a href="http://www.codoon.com/p/asuka4j">codoon</a>,&nbsp;<a href="http://www.yupoo.com/photos/asuka4j/albums/">yupoo</a>,&nbsp;<a href="http://instagram.com/asuka4j">instagram</a>,&nbsp;<a href="http://www.linkedin.com/pub/jiaqing-zheng/3a/b10/966">linkedin</a></br>
<img id="jiaqinglogoline" src="http://pic.yupoo.com/asuka4j/D2EHePXh/medish.jpg"/>&nbsp;&nbsp;</br>
</center>
</br>
<center><img id="sapprow" src="http://pic.yupoo.com/asuka4j/D2Cia9Jc/medish.jpg"/></center>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>
<!--</td></tr></table>-->
## Recent Post
<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>


