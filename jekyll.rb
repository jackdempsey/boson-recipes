# fix if/when this gets resolved
# https://rails.lighthouseapp.com/projects/8994/tickets/5630-active_supportinflectortransliterate-using-i18n-without-requiring-it
require 'active_support/lazy_load_hooks'
require 'active_support/i18n'
require 'active_support/core_ext/string/inflections'
module Jekyll
  def new_post(title)
    containing_folder = %w(_drafts _posts).find {|dir| Dir.exists?(dir)}
    unless containing_folder
      puts "Please run this inside a jekyll powered site"
      return
    end

    filename_title = title.parameterize
    pretty_title = title.titleize

    filename = File.join(containing_folder, %{#{Time.now.strftime("%Y-%m-%d")}-#{filename_title}.textile})
    File.open(filename, 'w') do |f|
      f.puts %{--- 
layout: post
title: "#{pretty_title}"
---

h1. {{ page.title }}


}
    end
    puts "Created new post: #{filename}"
  end
end
