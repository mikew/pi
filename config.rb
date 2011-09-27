def render_pizza_list
  data.pizzas.pizzas.inject("") do |html, (id, map)|
    locals = {
      name: id,
      desc: map[:desc] || toppings_list(map)
    }

    html << partial("menu_pizza", locals: locals)
  end
end

def toppings_list(map)
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

activate :automatic_image_sizes

configure :build do
  activate :minify_css
  activate :minify_javascript
  # activate :cache_buster
  # set :http_path, "/Content/images/"
end
