
{% if settings.theme_variant == 'squared' %}
	{% set featured_products = sections.primary.products | take(9) %}
{% else %}
	{% set featured_products = sections.primary.products | take(16) %}
{% endif %}
{% if sections.primary.products | length %}
	<section class="section-featured-home" data-store="products-home-featured">
	    <div class="container-fluid p-0">
	    	<div class="row no-gutters">
	    		{% if settings.theme_variant != 'squared' %}
					<div class="featured-title col-md-12 text-center">
			            {% if settings.featured_products_title %}
					        <h2 class="my-5 mb-md-5">{{ settings.featured_products_title }}</h2>
					    {% endif %}
			        </div>
			    {% endif %}
			    {% for product in featured_products %}

			    	{% if settings.theme_variant == 'squared' %}
				    	{# This if creates the container columns of the smallest modules #}
					    {% if loop.index == 1 or loop.index == 6 %}
					    	<div class="col-md-6">
					    		<div class="row no-gutters">

								{# This if shows the title in the first module #}
					    		{% if loop.index == 1 %}
						    		<div class="featured-title d-flex col-md-6 text-center text-md-left">
							            {% if settings.featured_products_title %}
									        <h2 class="my-5 m-md-4 h2-md">{{ settings.featured_products_title }}</h2>
									    {% endif %}
							        </div>
							    {% endif %}
					    {% endif %}
					{% endif %}
						    	<div class="featured-item {% if settings.theme_variant == 'squared' %}{% if loop.index == 4 or loop.index == 5 %}featured-item-big{% endif %} col-md-6{% else %}col-md-3{% endif %}">
						            {% include 'snipplets/grid/item.tpl' with {'square_item': true}  %}
						        </div>

					{# This if closes the container columns of the smallest modules #}
				    {% if settings.theme_variant == 'squared' and (loop.index == 3 or loop.index == 9) %}
				    		</div>
					    </div>
				    {% endif %}
			    {% endfor %}
	    	</div>
	    </div>
	</section>
{% endif %}