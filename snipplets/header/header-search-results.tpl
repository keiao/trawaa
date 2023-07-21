<ul class="search-suggest-list">
    {% set search_suggestions = products | take(4) %}
    {% for product in search_suggestions %}
        <li class="search-suggest-item container-fluid">
            <a href="{{ product.url }}" class="search-suggest-link row justify-content-md-center">
                <div class="search-suggest-image-container col-xs-auto">
                    {{ product.featured_image | product_image_url("tiny") | img_tag(product.featured_image.alt, {class: 'search-suggest-image'}) }}
                </div>
                <div class="search-suggest-text col">
                	<div class="search-suggest-name">
                		{{ product.name | highlight(query) }}
                	</div>
                    {% if product.display_price %}
                    	<div>
                    		{{ product.price | money }}

                            {% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 and settings.product_installments %}
                            {% if product_can_show_installments %}
                                {% set max_installments_without_interests = product.get_max_installments(false) %}
                                {% if max_installments_without_interests and max_installments_without_interests.installment > 1 %}
                                    <span>| {{ "Hasta <strong class='installment-amount'>{1}</strong> cuotas sin interés" | t(max_installments_without_interests.installment) }}</span>
                                {% endif %}
                            {% endif %}
                    	</div>
                    {% endif %}
                </div>
                <div class="col-xs-auto">
                    {% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-text search-suggest-icon"} %}
                </div>
            </a>
        </li>
    {% endfor %}
    <a href="#" class="js-search-suggest-all-link btn btn-primary {% if settings.theme_variant == 'rounded' %}btn-small mt-1{% endif %} d-block">{{ 'Ver todos los resultados' | translate }}</a>
</ul>
