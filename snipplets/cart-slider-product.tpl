{# <div> 
 {% for product in products %}   
 {{ product.brand }}
{% endfor %} 
 {{ store.logo | img_tag | a_tag(store.url) }} 
</div>  #}



{# {% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_auto_height_slider = not settings.slider_viewport_height %}

{% if not mobile %}
<div class="js-home-main-slider-container {% if not has_main_slider %}hidden{% endif %}">
{% endif %}
    <div class="{% if mobile %}js-home-mobile-slider{% else %}js-home-main-slider{% endif %}-visibility section-slider {% if has_auto_height_slider %}section-slider-auto{% endif %} {% if has_main_slider and has_mobile_slider %}{% if mobile %}d-md-none{% else %}d-none d-md-block{% endif %}{% elseif not settings.toggle_slider_mobile and mobile %}hidden{% endif %}">
        <div class="js-home-slider{% if mobile %}-mobile{% endif %} nube-slider-home swiper-container">
            <div class="swiper-wrapper">
                {% if mobile %}
                    {% set product_list = settings.slider_mobile %}
                {% else %}
                    {% set product_list = settings.slider %}
                {% endif %}
                {% for product in product_list %}
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
{% if not mobile %}
</div>
{% endif %} #}
