{% paginate by 12 %}

{% embed "snipplets/page-header.tpl" with { breadcrumbs: false } %}
	{% block page_header_text %}{{ "Resultados de búsqueda" | translate }}{% endblock page_header_text %}
{% endembed %}

<section class="category-body">
	<div class="container-fluid p-0">
		{% if products %}
			<div class="js-product-table product-table row no-gutters">
				{% include 'snipplets/product_grid.tpl' %}
			</div>
			{% if pages.current == 1 and not pages.is_last %}
				<div class="js-load-more text-center mt-5 mb-5">
					<a class="js-load-more btn btn-primary d-inline-block">
						<span class="js-load-more-spinner" style="display:none;">{% include "snipplets/svg/sync.tpl" with {svg_custom_class : "svg-inline--fa fa-spin svg-icon-primary"} %}</span>{{ 'Mostrar más productos' | t }}
					</a>
				</div>
				<div id="js-infinite-scroll-spinner" class="mt-5 mb-5 text-center w-100" style="display:none">
					{% include "snipplets/svg/sync.tpl" with {svg_custom_class : "svg-inline--fa fa-2x fa-spin svg-icon-text"} %}
				</div>
			{% endif %}
		{% else %}
			<div class="container-fluid p-0">
				<div class="row no-gutters">
					<div class="col-12 text-center">
						<p class="mb-1">{{ "No hubo resultados para tu búsqueda" | translate }}</br>
					</div>
				</div>
				{% set related_products = sections.primary.products | take(4) | shuffle %}
				{% if related_products | length > 1 %}
					<div class="row no-gutters">
						<div class="col-12 text-center">
							{{ "Quizás te interesen los siguientes productos." | translate }}
						</div>
					</div>
					<div class="product-table row no-gutters mt-5">
						{% for related in related_products %}
							{% include 'snipplets/grid/item.tpl' with {product : related} %}
						{% endfor %}
					</div>
				{% endif %}
			</div>
		{% endif %}
	</div>
</section>