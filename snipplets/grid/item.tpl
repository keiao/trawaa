{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set square_item = square_item | default(false) %}
{% set slide_item = slide_item | default(false) %}
{% set columns = settings.grid_columns %}

<div class="js-item-product {% if square_item %}{% if settings.theme_variant == 'squared' %}square-item{% endif %}{% else %} {% if slide_item %}swiper-slide{% else %}col{% if columns == 2 %}-md-6{% elseif columns == 3 %}-md-4{% else %}-md-3{% endif %}{% endif %}{% endif %} item item-product{% if not product.display_price %} no-price{% endif %} {% if settings.theme_variant == 'rounded' %}mb-4{% endif %}" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item">
    <div id="quick{{ product.id }}{% if slide_item %}slide-item{% endif %}" class="js-product-container js-quickshop-container item-container" data-variants="{{ product.variants_object | json_encode }}">
        {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}
        <div class="item-image mb-2">
            {% set item_img_width = product.featured_image.dimensions['width'] %}
            {% set item_img_height = product.featured_image.dimensions['height'] %}
            {% set item_img_srcset = product.featured_image %}
            {% set item_img_alt = product.featured_image.alt %}
            {% set item_img_spacing = item_img_height / item_img_width * 100 %}

            <div style="padding-bottom: {{ item_img_spacing }}%;" class="p-relative" data-store="product-item-image-{{ product.id }}">
                <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}">
                    <img alt="{{ item_img_alt }}" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ item_img_srcset | product_image_url('small')}} 240w, {{ item_img_srcset | product_image_url('medium')}} 320w, {{ item_img_srcset | product_image_url('large')}} 480w, {{  item_img_srcset | product_image_url('huge') }} 640w, {{  item_img_srcset | product_image_url('original') }} 1024w" class="js-item-image lazyload img-absolute img-absolute-centered fade-in{% if settings.product_hover and product.other_images %} item-image-primary{% endif %}" data-expand="-10" width="{{ item_img_width }}" height="{{ item_img_height }}" />
                    <div class="placeholder-fade">
                    </div>

                    {% if settings.product_hover and product.other_images %}
                        <img alt="{{ item_img_alt }}" data-sizes="auto" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset="{{ product.other_images | first | product_image_url('small')}} 240w, {{ product.other_images | first | product_image_url('medium')}} 320w, {{ product.other_images | first | product_image_url('large')}} 480w, {{  product.other_images | first | product_image_url('huge') }} 640w, {{  product.other_images | first | product_image_url('original') }} 1024w" class="js-item-image lazyautosizes lazyload img-absolute img-absolute-centered item-image-secondary" />
                    {% endif %}

                </a>
                {% if settings.product_color_variants %}
                    {% include 'snipplets/labels.tpl' with {color: true} %}
                {% else %}
                    {% include 'snipplets/labels.tpl' %}
                {% endif %}
            </div>
            {% if settings.quick_shop or settings.product_color_variants %}
                <div class="item-buy {% if settings.product_color_variants %}{% if not settings.quick_shop %}hidden{% elseif product.variations %}item-buy-color{% endif %}{% endif %}">
                    <a href="#" class="js-item-buy-open item-buy-open" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}" data-component="product-list-item.show-add-to-cart"  >
                        {% include "snipplets/svg/shopping-bag.tpl" %}
                    </a>
                    <div class="js-item-variants item-buy-variants">
                        <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                            <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                            {% if product.variations %}
                                {% include "snipplets/product/product-variants.tpl" with {quickshop: true} %}
                            {% endif %}
                            {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                            {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                            {# Add to cart CTA #}

                            {% if settings.theme_variant == 'squared' %}
                                {% set cta_col_class = '8' %}
                            {% else %}
                                {% set cta_col_class = '10' %}
                            {% endif %}

                            <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary btn-small col-{{ cta_col_class }} mb-2 {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}" />

                            {# Fake add to cart CTA visible during add to cart event #}

                            {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "mb-2 col-" ~ cta_col_class, quickshop: true} %}
                            
                            <a href="{{ product.url }}" title="{{ product.name }}" class="d-inline-block{% if settings.theme_variant == 'squared' %} item-details col-8 pb-2{% else %} mt-1{% endif %} font-weight-light w-100">{{ "Ver más detalles" | translate }}</a>
                        </form>
                    </div>
                </div>
            {% endif %}
        </div>
        <div class="item-description" data-store="product-item-info-{{ product.id }}">
            {% if settings.product_color_variants %}
                {% include 'snipplets/grid/item-colors.tpl' %}
            {% endif %}
            <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" class="item-link">
                <div class="js-item-name item-name font-weight-light mt-1 mb-2 mx-2" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>
                {% if product.display_price %}
                    <div class="item-price-container mb-1" data-store="product-item-price-{{ product.id }}">
                        <span class="js-price-display item-price font-weight-bold">
                            {{ product.price | money }}
                        </span>
                        <span class="js-compare-price-display price-compare" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %}style="display:inline-block;"{% endif %}>
                            {{ product.compare_at_price | money }}
                        </span>
                    </div>
                {% endif %}
            </a>
            {% if settings.product_installments %}
                {{ component('installments', {'location' : 'product_item', container_classes: { installment: "item-installments"}}) }}
            {% endif %}
        </div>
    </div>
    {# Structured data to provide information for Google about the product content #}
    {{ component('structured-data', {'item': true}) }}
</div>
