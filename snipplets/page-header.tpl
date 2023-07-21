{# /*============================================================================
  #Page header
==============================================================================*/

#Properties

#Title

#}

{% if  template == 'category' and ((category.images is not empty) or ("banner-products.jpg" | has_custom_image)) and settings.theme_variant == 'squared' %}
	{% set image_sizes = ['small', 'large', 'huge', 'original', '1080p'] %}
	{% set category_images = [] %}
	{% set has_category_images = category.images is not empty %}

	{% for size in image_sizes %}
	    {% if has_category_images %}
	        {% set category_images = category_images|merge({(size):(category.images | first | category_image_url(size))}) %}
	    {% else %}
	        {% set category_images = category_images|merge({(size):('banner-products.jpg' | static_url | settings_image_url(size))}) %}
	    {% endif %}
	{% endfor %}

	{% set category_image_url = 'banner-products.jpg' | static_url %}

	<section class="page-header category-image-container section-title">

		<div class="category-image">
			<img class="category-image-background lazyautosizes lazyload blur-up" src="{{ category_images['small'] }}" data-srcset="{{ category_images['large'] }} 480w, {{ category_images['huge'] }} 640w, {{ category_images['original'] }} 1024w, {{ category_images['1080p'] }} 1920w" data-sizes="auto" alt="{{ 'Banner de la categoría' | translate }} {{ category.name }}" />
		</div>
{% else %}

	<section class="page-header {% if template != 'product' %}section-title transparent{% endif %}">

{% endif %}

    <div class="{% if template != 'product' %}text-center {% endif %}" data-store="page-title">
        {% if template == 'product' or 'account.orders' %}
            {% include 'snipplets/breadcrumbs.tpl' %}
        {% elseif template == 'account.login' or template == 'account.register' %}
            {% include 'snipplets/breadcrumbs.tpl' with {breadcrumbs_custom_class: 'mb-4'} %}
        {% endif %}
        {% set contact_with_order_cancel = template == 'contact' and is_order_cancellation %}
        <h1 class="{% if contact_with_order_cancel %}font-weight-bold h3{% else %}h2{% endif %} {% if template == 'product' or contact_with_order_cancel %}{% if template != 'contact' %}js-product-name{% endif %} h2-md{% elseif template == 'category' %}category-name h1-md{% else %}h1-md{% endif %}" {% if template == "product" %}data-store="product-name-{{ product.id }}"{% endif %}>{% block page_header_text %}{% endblock %}</h1>
    </div>
</section>

{% if template == 'category' and category.description and settings.theme_variant == 'squared' %}
	<section class="category-description-container section-description">
		<div class="text-center row justify-content-md-center">
			<div class="col col-md-6">
				<p class="font-small font-md-normal p-2 {% if ((category.images is not empty) or ("banner-products.jpg" | has_custom_image)) %}my-4{% else %}mb-4{% endif %} ">{{ category.description }}</p>
			</div>
		</div>
	</section>
{% endif %}

{% if template == 'cart' and settings.theme_variant == 'squared' %}
	<div class="divider my-0"></div>
{% endif %}