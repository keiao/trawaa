{% if languages | length > 1 %}
    <div class="js-languages languages">
    	{% if settings.search_more_visible %}
				{% embed "snipplets/forms/form-select.tpl" with{select_label: false, select_custom_class: "js-lang-select", select_group_custom_class: "mb-0 form-vertical-align", select_small: true} %}
					{% block select_options %}
						{% for language in languages %}
							<option value="{{ language.country }}" {% if language.active %}selected{% endif %}>{{ language.country }}</option>
						{% endfor %}
					{% endblock select_options%}
				{% endembed %}
			{% if product.available and product.display_price and has_one_variant %}
		        {% include "snipplets/product/product-quantity.tpl" %}
		    {% endif %}
    	{% endif %}
        {% for language in languages %}
            {% set class = language.active ? "" : "opacity-50" %}
            <a href="{{ language.url }}" class="{% if settings.search_more_visible %}js-{{ language.country }} hidden {% endif %} {{ class }}"><img class="lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ language.country | flag_url }}" alt="{{ language.name }}" /></a>
        {% endfor %}
    </div>
{% endif %}