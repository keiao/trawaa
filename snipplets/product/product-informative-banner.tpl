{% for banner in ['product_informative_banner_01', 'product_informative_banner_02', 'product_informative_banner_03'] %}
    {% set product_banner_show = attribute(settings,"#{banner}_show") %}
    {% set product_informative_banner_title = attribute(settings,"#{banner}_title") %}
    {% set product_informative_banner_description = attribute(settings,"#{banner}_description") %}
    {% set has_product_informative_banner =  product_banner_show and (product_informative_banner_title or product_informative_banner_description) %}
    {% if has_product_informative_banner %}
        <div class="form-row mb-4 {% if loop.first and product.description is empty %}mt-4{% endif %}">
            <div class="col-11">
                {% if product_informative_banner_title %}
                    <div class="mb-1 font-weight-bold form-label">{{ product_informative_banner_title }}</div>
                {% endif %}
                {% if product_informative_banner_description %}
                    <p class="m0">{{ product_informative_banner_description }}</p>
                {% endif %}
            </div>
        </div>
    {% endif %}
{% endfor %}