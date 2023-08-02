{% if settings.cart_suggested_products_show %}
    <div class="">
        <div class="js-swiper-cart swiper-container">
            <div class="swiper-cart-header border-gray">
                {% if settings.cart_suggested_products_title %}
                    <h5>{{ settings.cart_suggested_products_title }}</h5>
                {% endif %}
                <div class="swiper-cart-buttons">
                    <div class="swiper-cart-control js-swiper-cart-prev">
                        {% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}
                    </div>

                    <div class="swiper-cart-control js-swiper-cart-next">
                        {% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}
                    </div>
                </div>
            </div>

            <div class="swiper-wrapper">
                {% for product in sections.cart.products %}
                    {% set item_img_srcset = product.featured_image %}
                    {% set item_img_alt = product.featured_image.alt %}

                    <div
                        class="
                            js-item-product swiper-slide item item-product cart-shopping-item border-gray
                            {% if not product.display_price %} 
                                no-price
                            {% endif %}
                        "
                        data-product-type="list"
                        data-product-id="{{ product.id }}"
                        data-store="product-item-{{ product.id }}"
                        data-component="product-list-item"
                    >
                        <div
                            id="quick{{ product.id }}
                            {% if slide_item %}
                                slide-item
                            {% endif %}"
                            class="js-product-container js-quickshop-container item-container"
                            data-variants="{{ product.variants_object | json_encode }}">
                            <img
                                class="js-item-image lazyload cart-shopping-item-img"
                                src="{{ item_img_srcset | product_image_url('small')}}"
                                alt="{{ item_img_alt }}">

                            <div class="cart-shopping-info">
                                <h5 class="js-item-name cart-shopping-title"
                                    data-store="product-item-name-{{ product.id }}">
                                    {{ product.name }}
                                </h5>

                                {% if product.display_price %}
                                    <div
                                        class="cart-shopping-price"
                                        data-store="product-item-price-{{ product.id }}">
                                        <span class="js-price-display">
                                            {{ product.price | money }}
                                        </span>
                                        <span
                                            class="js-compare-price-display"
                                            {% if not product.compare_at_price or not product.display_price %}
                                                style="display: none;"
                                            {% else %}
                                                style="display: inline-block;"
                                            {% endif %}
                                        >
                                            {{ product.compare_at_price | money }}
                                        </span>
                                    </div>
                                {% endif %}
                            </div>
                            <div class="js-item-variants">
                                {% set state = store.is_catalog ? 
                                    'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') 
                                %}
                                {% 
                                    set texts = {'cart': "Agregar", 'contact': "Consultar", 'nostock': "Sin stock", 'catalog': "Consultar"} 
                                %}

                                <form
                                    class="js-product-form"
                                    method="post"
                                    action="{{ store.cart_url }}">
                                    <input type="hidden" name="add_to_cart" value="{{product.id}}" />

                                    {# {% if product.variations %}
                                        {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                                    {% endif %} #}

                                    <input
                                        type="submit"
                                        class="js-addtocart js-prod-submit-form {{ state }}"
                                        value="{{ texts[state] | translate }}"
                                        {% if state == 'nostock' %}disabled{% endif %} 
                                        data-component="product-list-item.add-to-cart"
                                        data-component-value="{{ product.id }}" />



                                    {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "mb-2" , quickshop: true} %}
                                </form>
                            </div>
                        </div>
                    </div>
                {% endfor %}
            </div>
        </div>
    </div>
{% endif %}