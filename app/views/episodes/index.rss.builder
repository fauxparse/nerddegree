title = "The Nerd Degree"
author = "The Nerd Degree"
description = "The Nerd Degree is a monthly comedy panel show performed live at Little Andromeda in Christchurch, New Zealand."

xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd", "xmlns:atom" => "http://www.w3.org/2005/Atom", :version => "2.0" do
  xml.channel do
    xml.title title
    xml.link root_url
    xml.atom :link, rel: :self, href: episodes_url(format: :rss)
    xml.description description
    xml.language "en"
    xml.pubDate @episodes.first.date.to_time.to_s(:rfc822)
    xml.lastBuildDate @episodes.first.date.to_time.to_s(:rfc822)
    xml.itunes :author, author
    xml.itunes :subtitle, "Six nerds. No Wikipedia."
    xml.itunes :keywords, "nerds, geeks, pop culture, quiz, panel, star wars, star trek"
    xml.itunes :explicit, "yes"
    xml.itunes :image, :href => image_url("podcast-image.png")
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, 'nerddegree@gmail.com'
    end
    xml.itunes :block, "no"
    xml.itunes :category, :text => "Comedy"
    xml.itunes :category, :text => "TV & Film"
    xml.itunes :category, :text => "Leisure"

    @episodes.each do |episode|
      description = episode.content

      xml.item do
        xml.title episode.title
        xml.description do
          xml.cdata! description
        end
        xml.pubDate episode.date.to_time.to_s(:rfc822)
        xml.enclosure :url => episode.url, :type => "audio/mpeg", length: episode.size
        xml.link episode_url(episode)
        xml.guid({:isPermaLink => "false"}, episode_url(episode))
        xml.itunes :author, author
        xml.itunes :subtitle, "Episode #{episode.number}"
        xml.itunes :summary do
          xml.cdata! description
        end
        xml.itunes :explicit, "yes"
        # xml.itunes :duration, episode.duration
      end
    end
  end
end
