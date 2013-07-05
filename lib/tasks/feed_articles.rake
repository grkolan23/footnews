namespace :feed_articles do
  
  desc "TODO"
    task :count => :environment do
      puts Feed.all.count
    end
  
  desc "TODO"
    task :list => :environment do
      all_feeds = Feed.all
      all_feeds.each do |feed|
        feed_me = feed.feed_url
        feeds = Feedzirra::Feed.fetch_and_parse(feed_me)
        feeds.entries.each do |entry|
        #updated_feed = Feedzirra::Feed.update(feed_me)
        #updated_feed.new_entries.each do |entry|
        #  Article.create!(
        #    :name         => entry.title,
        #    :summary      => entry.summary,
        #    :url          => entry.url,
        #    :published_at => entry.published,
        #    :guid         => entry.id,
        #    :feed_id      => feed.id
        #  )
          puts Time.now.to_s + " (  " + feed.id.to_s + " : " + feed.host.to_s + " )  " + entry.title.to_s     
        end
      end
    end
end