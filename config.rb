DEFAULT_HAML_OPTIONS = { format: :html5 }
MAIN_SECTIONS = %w[Pizza Dessert Salad Pasta]

set :haml, DEFAULT_HAML_OPTIONS

def render_menu_for(section)
  maps = data.send(section.to_sym)
  maps.inject("") do |html, (id, map)|
    describer = :"desc_for_#{section}"
    locals = {
      identifier:  id,
      name:        titleize(id),
      desc:        map[:desc] || send(describer, map),
      price:       map[:price]
    }

    html << partial("menu_item", locals: locals)
  end
end

def desc_for_pizza(map)
  format  = "%s base topped with %s."
  base    = map[:base] || 'herb tomato'
  lead_in = base =~ /^[aeiou]/ ? 'An %s' : 'A %s'

  format % [lead_in % base, to_sentence(map[:toppings])]
end

def to_sentence(ary, joined_by = ', ', finally = ' and ')
  ary  = ary.dup
  last = ary.pop

  "%s%s%s" % [ary.join(joined_by), finally, last]
end

def titleize(word)
  word.to_s.gsub(/_and_/, ' &#038; ').gsub(/_/, ' ').gsub(/\b([a-z])/) { $1.capitalize }
end

activate :automatic_image_sizes

configure :build do
  set :haml, DEFAULT_HAML_OPTIONS.merge(ugly: true, attr_wrapper: '"')
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
  set :http_prefix, "/pi/"
end
