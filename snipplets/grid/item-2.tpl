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
           
        </div>
        <div class="item-description" data-store="product-item-info-{{ product.id }}">
            {% if settings.product_color_variants %}
                {% include 'snipplets/grid/item-colors.tpl' %}
            {% endif %}
            <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" class="item-link">
                <div class="js-item-name item-name font-weight-light" data-store="product-item-name-{{ product.id }}">{{ product.name }}</div>
                {% if product.display_price %}
                    <div class="item-price-container mt-1 mb-1" data-store="product-item-price-{{ product.id }}">
                        <span class="js-price-display item-price">
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
