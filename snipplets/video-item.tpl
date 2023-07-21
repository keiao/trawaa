{% if thumb %}
    {% set svg_size = 'fa-2x' %}
{% else %}
    {% set svg_size = 'fa-6x' %}
{% endif %}

{% if product_modal %}

    {# Product video modal wrapper #}

    <div id="product-video-modal" class="js-product-video-modal product-video" style="display: none;">
{% endif %}

    <div class="{% if not thumb %}js-video{% endif %} {% if product_video and not product_modal %}js-video-product{% endif %} embed-responsive embed-responsive-16by9 visible-when-content-ready">
        {% if thumb %}
            <div class="video-player">
        {% else %}
            {% if product_modal_trigger %}

                {# Open modal in mobile with product video inside #}

                <a href="#product-video-modal" data-fancybox="product-gallery" class="js-play-button video-player d-block d-md-none">
                    <div class="video-player-content text-center col-12 col-md-9">
                        {% include "snipplets/svg/play-circle.tpl" with {svg_custom_class: "svg-inline--fa fa-play-circle fa-w-16 " ~ svg_size ~ ""} %}
                    </div>
                </a>
            {% endif %}
            <a href="#" class="js-play-button video-player {% if product_modal_trigger %}d-none d-md-block{% endif %}">
        {% endif %}
            <div class="video-player-content text-center col-12 col-md-9">
                {% if  settings.theme_variant == 'squared' or template == 'product' %}
                    {% include "snipplets/svg/play-circle.tpl" with {svg_custom_class: "svg-inline--fa fa-play-circle fa-w-16 " ~ svg_size ~ ""} %}
                {% endif %}
                {% if template == 'home' %}
                    {% if settings.video_title %}
                        <h2 class="h1 h1-huge-md mt-3">{{ settings.video_title }}</h2>
                    {% endif %}
                    {% if settings.video_text %}
                        <div class="h3 my-4 font-secondary">{{ settings.video_text }}</div>
                    {% endif %}
                    {% if  settings.theme_variant == 'rounded' %}
                        <div class="btn btn-line btn-small mt-2">{{ "Reproducir video" | translate }}</div>
                    {% endif %}
                {% endif %} 
            </div>
        {% if thumb %}
            </div>
        {% else %}
            </a>
        {% endif %}
        <div class="js-video-image">
            <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="" class="lazyload video-image fade-in" alt="{{ 'Video de' | translate }} {% if template != 'product' %}{{ product.name }}{% else %}{{ store.name }}{% endif %}" style="display: none;">
            <div class="placeholder-fade">
            </div>
        </div>
    </div>

    {% if not thumb %}
        
        {# Empty iframe component: will be filled with JS on play button click #}

        <div class="js-video-iframe embed-responsive embed-responsive-16by9" style="display: none;" data-video-color="{{ settings.primary_color | trim('#') }}">
        </div>
    {% endif %}
{% if product_modal %}
    </div>
{% endif %}