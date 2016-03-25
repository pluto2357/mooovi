class Scraping1
  def self.comic_urls

    puts 'get movies link URL'
    agent = Mechanize.new
    links = []

    next_url = "/release/book/#{Date.today}?threshold=0&term=all&page=1"

    while true do
      current_page = agent.get("http://booklog.jp" + next_url)
      elements = current_page.search('.b10M a')

      elements.each do |ele|
        links << ele.get_attribute('href')
      end

    if current_page.search('.pagerArea li').last.children[0].attributes["href"]==nil
        break
    end
      next_url=current_page.search('.pagerArea li').last.children[0].attributes["href"].value 
   # binding.pry
    # # binding.pry を使用応用していく感じ
    #   next_url = next_link.get_attribute('href')
    end
    # 最後から一番目のurlが今のページのurlと同じなら終了

# http://booklog.jp/release/comic/2016-03-25?threshold=0&term=all&page=3

    links.each do |link|
      get_product('http://booklog.jp' + link)
    end
  end


  def self.get_product(link)
      puts 'get movies link URL'
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.breadcrumbs li:last span').inner_text if page.at('.breadcrumbs li:last span')

    # binding.pry
    author = page.at('.item-info-author a').inner_text if page.at('.item-info-author a')
    # detail = page.at('.career_box h3 p').inner text if page.at('.career_box h3 p')
    publisher =page.at('.item-info-description ul li:last span:nth-child(1)').inner_text if page.at('item-info-description ul li:last span:nth-child(1)')
    open_date = page.at('item-info-description ul li:last span:nth-child(2)').inner_text if page.at('item-info-description ul li:last span:nth-child(2)')


    image_url = page.at('.itemImg')[:src] if page.at('.itemImg')
    product.open_date = open_date
    product.author = author

    product = Product.where(title: title, image_url: image_url).first_or_initialize
    # 複数のデータ新たに更新するようにする
    # product.detail = detail


    product.save
  end
end

