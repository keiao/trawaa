{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}

{% if settings.theme_variant == 'squared' %}
	<div class="{% if has_filters_available %}js-sticky-filters{% endif %} container-fluid">
		<div class="row align-items-center category-controls">
			<div class="col-8 d-none d-md-block">
				{% include 'snipplets/breadcrumbs.tpl' with {breadcrumbs_custom_class: "mb-0"} %}
			</div>
			<div class="col-12 col-md-4">
				{% if products %}
					<div class="row {% if not has_filters_available %}justify-content-end{% endif %}">
						{% if has_filters_available %}
							<div class="col-6 category-control-col">
								<a href="#" class="js-modal-open js-fullscreen-modal-open js-context-open-context js-toggle btn-link filter-link btn-block {% if settings.theme_variant == 'rounded' %} btn-line medium{% endif %}" data-toggle="#nav-filters" data-modal-url="modal-fullscreen-filters" data-component="filter-button">
									{{ 'Filtrar' | t }} {% include "snipplets/svg/filter.tpl" with { fa_custom_class: "float-right"} %}
								</a>
							</div>
						{% endif %}
						<div class="{% if has_filters_available %}col-6{% else %}col-12 col-md-7{% endif %} category-control-col">
							{% include 'snipplets/grid/sort-by.tpl' %}
						</div>
					</div>
				{% endif %}
			</div>
			{% if has_filters_available %}
				{% include 'snipplets/grid/filters.tpl' %}							
			{% endif %}
		</div>
	</div>
	<div class="container-fluid visible-when-content-ready">
		{% include 'snipplets/grid/filters.tpl' with {applied_filters: true} %}
	</div>
{% endif %}

{% if settings.theme_variant == 'rounded' %}
	<div class="container-fluid position-relative {% if  template == 'category' and ((category.images is not empty) or ("banner-products.jpg" | has_custom_image)) %}category-image-container{% endif %}"> 

	{% if  template == 'category' and ((category.images is not empty) or ("banner-products.jpg" | has_custom_image)) %}
		{% set image_sizes = ['small', 'large', 'huge', 'original', '1080p'] %}
		{% set category_images = [] %}
		{% set has_category_images = category.images is not empty %}

		{% for size in image_sizes %}
		    {% if has_category_images %}
		        {# Define images for admin categories #}
		        {% set category_images = category_images|merge({(size):(category.images | first | category_image_url(size))}) %}
		    {% else %}
		        {# Define images for general banner #}
		        {% set category_images = category_images|merge({(size):('banner-products.jpg' | static_url | settings_image_url(size))}) %}
		    {% endif %}
		{% endfor %}
		{% set category_image_url = 'banner-products.jpg' | static_url %}

		<div class="category-image-wrap">
			<div class="category-image">
				<img class="category-image-background lazyautosizes lazyload blur-up" src="{{ category_images['small'] }}" data-srcset="{{ category_images['large'] }} 480w, {{ category_images['huge'] }} 640w, {{ category_images['original'] }} 1024w, {{ category_images['1080p'] }} 1920w" data-sizes="auto" alt="{{ 'Banner de la categoría' | translate }} {{ category.name }}" />
			</div>
		</div>
	{% endif %}

		<div class="row align-items-center category-controls">
			<div class="col-12 col-md-6 offset-md-3">

{% endif %}

{% embed "snipplets/page-header.tpl" %}
	{% block page_header_text %}{{ category.name }}{% endblock page_header_text %}
{% endembed %}

{% if settings.theme_variant == 'rounded' %}
			</div>
			{% if category.description %}
				<div class="col col-md-6 offset-md-3 text-center order-md-last">
					<p class="font-small font-md-normal p-2 {% if ((category.images is not empty) or ("banner-products.jpg" | has_custom_image)) %}my-4{% else %}mb-4{% endif %} ">{{ category.description }}</p>
				</div>
			{% endif %}

			<div class="col-12 col-md-3 px-0 px-sm-3">
				{% if products %}
					<div class="form-row align-items-center category-controls pt-3">
						{% if has_filters_available %}
							<div class="col-4">
								<a href="#" class="js-modal-open js-fullscreen-modal-open js-context-open-context js-toggle btn-link filter-link btn-block {% if settings.theme_variant == 'rounded' %} btn-line medium{% endif %}" data-toggle="#nav-filters" data-modal-url="modal-fullscreen-filters">
									{{ 'Filtrar' | t }} {% include "snipplets/svg/filter.tpl" with { fa_custom_class: "float-right"} %}
								</a>
							</div>
						{% endif %}
						<div class="{% if has_filters_available %}col-8{% else %}col-12 col-md-8 offset-md-2{% endif %}">
							{% include 'snipplets/grid/sort-by.tpl' %}
						</div>
					</div>
				{% endif %}
			</div>
			{% if has_filters_available %}
				{% include 'snipplets/grid/filters.tpl' %}							
			{% endif %}
		</div>
	</div>
	<div class="container-fluid visible-when-content-ready">
		{% include 'snipplets/grid/filters.tpl' with {applied_filters: true} %}
	</div>
{% endif %}