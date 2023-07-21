{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set square_item = square_item | default(false) %}
{% set slide_item = slide_item | default(false) %}
{% set columns = settings.grid_columns %}


<div class="{% if square_item %}{% if settings.theme_variant == 'squared' %}square-item{% endif %}{% else %} {% if slide_item %}swiper-slide{% else %}col{% if columns == 2 %}-md-6{% elseif columns == 3 %}-md-4{% else %}-md-3{% endif %}{% endif %}{% endif %} item item-product {% if settings.theme_variant == 'rounded' %}mb-4{% endif %}">
    <div id="quick{{ product.id }}" class="item-container js-product-container js-quickshop-container">
        <div class="item-image mb-2">
            <div class="p-relative">
                <a href="{{ store.url }}/product/example" title="{{ "Producto de ejemplo" | translate }}">
                    {% if help_item_1 %}
                        {% include "snipplets/svg/help/help-product-1.tpl" %}
                    {% elseif help_item_2 %}
                        {% include "snipplets/svg/help/help-product-2.tpl" %}
                    {% elseif help_item_3 %}
                        {% include "snipplets/svg/help/help-product-3.tpl" %}
                    {% elseif help_item_4 %}
                        {% include "snipplets/svg/help/help-product-4.tpl" %}
                    {% elseif help_item_5 %}
                        {% include "snipplets/svg/help/help-product-5.tpl" %}
                    {% elseif help_item_6 %}
                        {% include "snipplets/svg/help/help-product-6.tpl" %}
                    {% elseif help_item_7 %}
                        {% include "snipplets/svg/help/help-product-7.tpl" %}
                    {% elseif help_item_8 %}
                        {% include "snipplets/svg/help/help-product-8.tpl" %}
                    {% endif %}
                </a>
                {% if help_item_1 %}
                    <div class="labels">
                        <div class="label label-primary">{{ "20% OFF" | translate }}</div>
                    </div>
                {% elseif help_item_2 %}
                    <div class="labels">
                        <div class="label label-secondary">{{ "Envío gratis" | translate }}</div>
                    </div>
                {% elseif help_item_3 %}
                    <div class="labels">
                        <div class="label label-primary">{{ "35% OFF" | translate }}</div>
                    </div>
                {% elseif help_item_7 %}
                    <div class="labels">
                        <div class="label label-primary">{{ "20% OFF" | translate }}</div>
                    </div>
                {% endif %}
            </div>
            {% if settings.quick_shop %}
                <div class="item-buy">
                    <a href="#" class="js-item-buy-open item-buy-open" title="{{ "Producto de ejemplo" | translate }}">
                        {% include "snipplets/svg/shopping-bag.tpl" %}
                    </a>
                    <div class="js-item-variants item-buy-variants">
                        <form id="product_form" class="js-product-form" method="post" action="{{ store.cart_url }}">
                            <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                            <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary col{% if settings.theme_variant == 'squared' %}-8{% else %}-10 btn-medium{% endif %}  d-inline-block mb-2" value="{{ 'Agregar al carrito' | translate }}"/>
                        </form>
                    </div>
                </div>
            {% endif %}
        </div>
        <div class="item-description">
            <a href="{{ store.url }}/product/example" title="{{ "Producto de ejemplo" | translate }}" class="item-link">
                <div class="js-item-name item-name font-weight-light mt-1 mb-2 mx-2">{{ "Producto de ejemplo" | translate }}</div>
                <div class="item-price-container mb-1">
                    {% if help_item_1 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"9600" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"120000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"96000" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"1200000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_2 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"68000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"680000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_3 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"18200" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"28000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"182000" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"280000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_4 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"32000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"320000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_5 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"24900" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"249000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_6 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"42000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"420000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_7 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"36800" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"46000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"368000" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"460000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_8 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"12200" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"122000" | money }}
                            </span>
                        {% endif %}
                    {% endif %}
                </div>
            </a>
        </div>
    </div>
</div>