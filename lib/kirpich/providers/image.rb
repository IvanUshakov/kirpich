module Kirpich::Providers
  class Image
    class << self
      def les_400_image
        _extract_tumblr("http://les400culs.com/page/#{rand(200)}")
      end

      def lesaintdesseins_image
        _extract_tumblr("http://lesaintdesseins.fr/page/#{rand(200)}")
      end

      def _extract_tumblr(url)
        response = Faraday.get url

        Nokogiri::HTML(response.body).css('.post.photo > a img').map do |i|
          i['src']
        end.sample
      end

      def developerslife_image
        connection = Faraday.new(url: 'http://developerslife.ru/random'.freeze) do |faraday|
           faraday.use FaradayMiddleware::FollowRedirects, limit: 5
           faraday.adapter Faraday.default_adapter
        end
        response = connection.get

        page = Nokogiri::HTML(response.body)
        image = page.css('.entry .image .gif video source')
        text = page.css('.entry .code .value')

        [image.first['src'], text.first.text.delete("'")] if image.any? && text.any?
      end

      def devopsreactions_image
        connection = Faraday.new(url: 'http://devopsreactions.tumblr.com/random'.freeze) do |faraday|
           faraday.use FaradayMiddleware::FollowRedirects, limit: 5
           faraday.adapter Faraday.default_adapter
        end
        response = connection.get

        page = Nokogiri::HTML(response.body)
        image = page.css('#content .item.text .middle .item_content figure img'.freeze)
        text = page.css('#content .item.text .middle .item_content .post_title a'.freeze)

        [image.first['src'], text.first.text] if image.any? && text.any?
      end
    end
  end
end
