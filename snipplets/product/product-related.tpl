<section id="related-products" class="section-products-related" data-store="related-products">
    {% include 'snipplets/product/product-related-grid.tpl' with {'related_slider': true} %}
</section>


{% set related_products_ids = product.metafields.related_products.related_products_ids %}
{% if related_products_ids %}
    {% set related_products = related_products_ids | get_products %}
    {% set show = (related_products | length > 0) %}
{% endif %}
{% if not show %}
    {% set related_products = category.products | shuffle | take(8) %}
    {% set show = (related_products | length > 1) %}
{% endif %}


<section id="related-products" class="section-products-related">
    {% if show %}
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <h3>{{ "Productos Relacionados" | translate }}</h3>
                </div>
                <div class="col-12">
                    <div class="js-swiper-related swiper-container">
                        <div class="swiper-wrapper">
                            {% for related in related_products %}
                                {% if product.id != related.id %}
                                    {% include 'snipplets/grid/item.tpl' with {'product': related, 'slide_item': true} %}
                                {% endif %}
                            {% endfor %}
                        </div>
                        {% if related_products | length < 4 %}
                        <div class="d-sm-none">
                        {% endif %}
                            <div class="js-swiper-related-pagination swiper-pagination"></div>
                            <div class="js-swiper-related-prev swiper-button-prev">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "icon-inline icon-w-8 icon-2x svg-icon-text"} %}</div>
                            <div class="js-swiper-related-next swiper-button-next">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "icon-inline icon-w-8 icon-2x svg-icon-text"} %}</div>
                        {% if related_products | length < 4 %}
                        </div>
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
    {% endif %}
</section>