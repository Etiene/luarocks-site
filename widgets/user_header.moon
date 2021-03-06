import time_ago_in_words from require "lapis.util"

class UserHeader extends require "widgets.page_header"
  @needs: {
    "user"
  }

  admin_panel: =>

  inner_content: =>
    div class: "page_header_inner", ->
      div class: "social_links", ->
        data = @user\get_data!
        if github = data\github_handle!
          a href: "https://github.com/#{github}", title: github, ->
            span class: "icon-github"

        if twitter = data\twitter_handle!
          a href: "https://twitter.com/#{twitter}", title: twitter, ->
            span class: "icon-twitter"

      h1 ->
        a href: @url_for(@user), ->
          img class: "avatar", src: @user\gravatar(60)

        span class: "username", @user\name_for_display!

        if @user\is_admin!
          div class: "user_flag", "Admin"

    div class: "metadata_columns", ->
      module_count = @pager\total_items!

      div class: "page_header_inner", ->
        div class: "column", ->
          h3 "Modules"
          text @format_number module_count

        div class: "column", ->
          h3 "Registered"
          span title: @user.created_at, time_ago_in_words @user.created_at

        if module_count > 0
          div class: "column", ->
            h3 "Downloads"
            text @format_number @user\count_downloads!

        if url = @user\get_data!.website
          div class: "column", ->
            h3 "Website"
            url_title = url\gsub "https?://", ""
            a {
              class: "external_url"
              rel: "nofollow"
              href: @format_url url
              @truncate url_title, 30
            }



