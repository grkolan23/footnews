class Feed < ActiveRecord::Base
  attr_accessible :etag, :feed_url, :host, :last_modified, :title
  has_many :articles
  after_create :insert_info

  def insert_info
  	feeds = Feedzirra::Feed.fetch_and_parse(self.feed_url)
  	host  = URI(feeds.url).host.gsub("www.", "")
  	update_attributes(:title => feeds.title, :host => host)
  	#update_attributes(:host	=> host)
  	update_attributes(:feed_url => feeds.feed_url)
  	update_attributes(:last_modified  => feeds.last_modified)
  	update_attributes(:etag => feeds.etag)
    feeds.entries.each do |entry|
        Article.create!(
          :name         => entry.title,
          :summary      => entry.summary,
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id,
          :feed_id      => id
        )
    end
  end
end
