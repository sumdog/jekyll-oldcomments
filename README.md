jekyll-oldcomments
==================

[![Gem](https://img.shields.io/gem/v/jekyll-oldcomments.svg?style=plastic)]()

Do you have an old wordpress blog? Are you migrating it to Jekyll? Tired of spam? Don't want to moderate comments anymore, but you don't want to lose all those comments of people who have contributed so far? 

The Jekyll-oldcomments gem is for you! You can use this gem to extract all the comments from your old wordpress website and present them on your new jekyll site (along with an explanation on why you're not accepting new comments). 

If you still want to allow comments with Jekyll, there are still many solutions for that. This isn't one of them. 

Installation 
============

To install the current release, run the following:

    gem install jekyll-oldcomments

To install from source:

    git clone https://github.com/sumdog/jekyll-oldcomments
    cd jekyll-oldcomments
    gem build jekyll-oldcomments.gemspec
    gem install jekyll-oldcomments-<version>.gem

If you need to customize this plugin, you can also clone the source and copy the `oldcomments.rb` into your Jekyll `_plugins` folder. If you come up with some useful additions, pull requests are encouraged. 


Extracting Wordpress Comments
=============================

You will need to use the built in Wordpress export. Go to `Tools>Export` in the Wordpress admin concert and export all data. It should generate an XML file. You can then use the following command to create a `_comments` directory.

    wp_comments2jekyll <wordpress-export.xml>

If you have installed the gem as a local user, you may need a full path like the following:

   $HOME/.gem/ruby/2.1.0/bin/wp_comments2jekyll <wordpress-export.xml>

Usage with Jekyll
=================

Add the gem to your Jekyll `_config.yml` like so:

```
gems:
  - jekyll-oldcomments
```

This plugin expects a file in `_includes` that's named `comments.html`. It should look something like the following:

```
{% if comments %}
<h3 id="comments-header">Comments</h3>
{% endif %}
{% for comment in comments %}
  <div class="comment">
    <div class="comment_header">
      <span class="comment_author">
        {% if comment.meta.author_url %}
          <a class="comment_author_url" href="{{ comment.meta.author_url }}">
        {% endif %}
        {{ comment.meta.author }}
        {% if comment.meta.author_url %}</a>{% endif %}
      </span>
      <span class="comment_date">
        {{ comment.meta.date  | date: "%Y-%m-%d" }}
      </span>
    </div>
    <div>
      {{ comment.text }}
    </div>
  </div>
{% endfor %}
{% if comments %}
<div class="comment closed">
  Comments are closed. <a href="http://example.org/comments">Why?</a>
</div>
{% endif %}
```

Then within your `_post.html`, you can include a `{% oldcomments %}` to render the `comments.html`. The following is an example:

```
---
layout: default
---
<section class="post">

  <header class="post-header">
    <h2 class="post-title">{{ page.title }}</h2>
    <p class="post-meta">{{ page.date | date: "%b %-d, %Y" }}{% if page.author %} • {{ page.author }}{% endif %}{% if page.meta %} • {{ page.meta }}{% endif %}</p>
  </header>

  <article class="post-content">
    {{ content }}

    <div id="comments">
      {% old_comments %}
    </div>

  </article>

</section>
```

Example
=======

I currently use this plugin on [PenguinDreams.org](http://penguindreams.org). the following is an example of a page with comments generated:

http://penguindreams.org/blog/running-beans-that-use-application-server-datasources-locally/

Help/Support
============

If you run into issues or have a question, add an issue to our issue tracker. Pull requests are welcome. 