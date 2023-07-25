{# <div>
  {% for product in products %}
    <span>{{ product.name }}</span>
  {% endfor %}
</div> #}

{# {% for product in products %}
    {% include 'snipplets/grid/item.tpl' %}
{% endfor %} #}


{# <div class="js-home-main-slider-container">
<div class="{% if mobile %}js-home-mobile-slider{% else %}js-home-main-slider{% endif %}-visibility section-slider">
    <div class="js-home-slider{% if mobile %}-mobile{% endif %} nube-slider-home swiper-container">
        <div class="swiper-wrapper">

                <div class="swiper-slide slide-container">
                    <a href="{{ product.link }}" aria-label="{{ 'Carrusel' | translate }} {{ loop.index }}">
                        <div class="js-slider-slide slider-slide">
                            <img 
                                {% if product.image.width and product.image.height %} width="{{ product.image.width }}" height="{{ product.image.height }}" {% endif %}
                                src="{{ product.image.url }}" alt="{{ product.name }}"
                            />
                            <div class="swiper-text swiper-{{ product.color }}">
                                <div class="swiper-description mb-1">{{ product.description }}</div>
                                <div class="swiper-title">{{ product.name }}</div>
                                <div class="btn btn-line btn-small swiper-btn">View Details</div>
                            </div>
                        </div>
                    </a>
                </div>
            {% endfor %}
        </div>
        <div class="js-swiper-home-control js-swiper-home-pagination{% if mobile %}-mobile{% endif %} swiper-pagination swiper-pagination-white"></div>
        <div class="js-swiper-home-control js-swiper-home-prev{% if mobile %}-mobile{% endif %} swiper-button-prev">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
        <div class="js-swiper-home-control js-swiper-home-next{% if mobile %}-mobile{% endif %} swiper-button-next">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
    </div>
</div>
</div> #}


{# <div class="flex-row flex-wrap">
{% for product in products %}
    <div class="col-3">
        {% set item_img_srcset = product.featured_image %}
        {% set item_img_alt = product.featured_image.alt %}
        <div class="row">
            <div class="col">
                <img
                    style="max-width: 100%;"
                    alt="{{ item_img_alt }}"
                    src="{{ 'images/empty-placeholder.png' | static_url }}"
                    data-srcset="
                        {{ item_img_srcset | product_image_url('small')}} 240w, 
                        {{ item_img_srcset | product_image_url('medium')}} 320w, 
                        {{ item_img_srcset | product_image_url('large')}} 480w, 
                        {{  item_img_srcset | product_image_url('huge') }} 640w, 
                        {{ item_img_srcset | product_image_url('original') }} 1024w"
                    class="js-item-image lazyload"
                    data-expand="-10"
                />
            </div>
            <div class="col">
                 <div
                    class="js-item-name item-name font-weight-light mt-1 mb-2 mx-2"
                     data-store="product-item-name-{{ product.id }}">
                     {{ product.name }}
                </div>
                {% if product.display_price %}
                    <div class="item-price-container mb-1" data-store="product-item-price-{{ product.id }}">
                        <span class="js-price-display item-price font-weight-bold">
                            {{ product.price | money }}
                        </span>
                        <span
                            class="js-compare-price-display price-compare"
                            {% if not product.compare_at_price or not product.display_price %}
                            style="display:none;"{% else %}
                            style="display:inline-block;"{% endif %}>
                            {{ product.compare_at_price | money }}
                        </span>
                    </div>
                {% endif %}
            </div>
            <div class="col">
                {% if settings.quick_shop %}
                    <div class="item-buy">
                        <form
                            class="js-product-form"
                            method="post"
                            action="{{ store.cart_url }}">
                            <input type="hidden" name="add_to_cart" value="{{product.id}}" />

                            {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}

                            {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}


                            <input
                                type="submit"
                                class="js-addtocart js-prod-submit-form btn btn-primary btn-small mb-2 {{ state }}" value="Agregar" data-component="product-list-item.add-to-cart" data-component-value="{{ product.id }}" />


                            {% include 'snipplets/placeholders/button-placeholder.tpl' with {quickshop: true} %}
                        </form>
                    </div>
                {% endif %}
            </div>
        </div>
    </div>
{% endfor %}
</div> #}
