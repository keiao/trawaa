<section class="section-banners-home" data-store="banner-home-categories">
    <div class="container-fluid p-0">
        <div class="row align-items-center no-gutters">
            
            {% if settings.banner_01_show and ( settings.banner_01_title or "banner_01.jpg" | has_custom_image) %}{% set has_banner_01 = true %}{% endif %}
            {% if settings.banner_02_show and ( settings.banner_02_title or "banner_02.jpg" | has_custom_image) %}{% set has_banner_02 = true %}{% endif %}
            {% if settings.banner_03_show and ( settings.banner_03_title or "banner_03.jpg" | has_custom_image) %}{% set has_banner_03 = true %}{% endif %}
            {% if settings.banner_04_show and ( settings.banner_04_title or "banner_04.jpg" | has_custom_image) %}{% set has_banner_04 = true %}{% endif %}

            {% set num_banners = 0 %}
            {% for banner in ['banner_01', 'banner_02', 'banner_03', 'banner_04'] %}
                {% set banner_show = attribute(settings,"#{banner}_show") %}
                {% set banner_title = attribute(settings,"#{banner}_title") %}
                {% set banner_button_text = attribute(settings,"#{banner}_button") %}
                {% set has_banner =  banner_show and (banner_title or "#{banner}.jpg" | has_custom_image) %}
                {% if has_banner %}
                    {% set num_banners = num_banners + 1 %}
                {% endif %}
            {% endfor %}

            {% for banner in ['banner_01', 'banner_02', 'banner_03', 'banner_04'] %}
                {% set banner_show = attribute(settings,"#{banner}_show") %}
                {% set banner_title = attribute(settings,"#{banner}_title") %}
                {% set banner_button_text = attribute(settings,"#{banner}_button") %}
                {% set banner_url = attribute(settings,"#{banner}_url") %}
                {% set has_banner =  banner_show and (banner_title or "#{banner}.jpg" | has_custom_image) %}
                {% set has_banner_text =  banner_title or banner_button_text %}
                {% if has_banner %}

                    {% if num_banners == 4 and loop.index == 2 %}
                    <div class="col-md{% if settings.theme_variant == 'squared' %}-6{% else %}-7{% endif %}">
                        <div class="row no-gutters">
                    {% endif %}
                    <div class="col-md{% if num_banners == 1 %}-12{% elseif num_banners == 3 %}{% if has_banner_01 %}{% if loop.index == 1 %}{% if settings.theme_variant == 'squared' %}-6{% else %}-5{% endif %}{% else %}-12{% endif %}{% else %}{% if loop.index == 2 %}-12{% else %}{% if settings.theme_variant == 'squared' %}-6{% else %}-5{% endif %}{% endif %}{% endif %}{% elseif num_banners == 4 %}{% if loop.index == 1 %}{% if settings.theme_variant == 'squared' %}-6{% else %}-5{% endif %}{% elseif loop.index == 2 %}-12 {% else %}-6 {% endif %}{% else %}{% endif %}">
                        <div class="textbanner {% if num_banners == 4 %}{% if loop.index != 1 %}banner-mid-height{% endif %}{% elseif num_banners == 3 %}{% if loop.index != 1 %}banner-mid-height{% endif %}{% endif %}">
                            {% if banner_url %}
                                <a class="textbanner-link" href="{{ banner_url | setting_url }}"{% if banner_title %} title="{{ banner_title }}" aria-label="{{ banner_title }}"{% else %} title="{{ 'Banner de' | translate }} {{ store.name }}" aria-label="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %}>
                            {% endif %}
                            <div class="textbanner-image{% if has_banner_text and textoverimage %} overlay{% endif %}">
                                {% if "#{banner}.jpg" | has_custom_image %}
                                    <img class="textbanner-image-background lazyautosizes lazyload blur-up" src='{{ "#{banner}.jpg" | static_url | settings_image_url('tiny') }}' data-srcset='{{ "#{banner}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{banner}.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "#{banner}.jpg" | static_url | settings_image_url('original') }} 1024w' data-sizes="auto" data-expand="-10" {% if banner_title %}alt="{{ banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
                                {% endif %}
                            </div>
                            <div class="textbanner-text{% if textoverimage %} over-image{% endif %}">
                                {% if banner_title %}
                                    <h3 class="{% if settings.theme_variant == 'squared' %}h2{% else %}{% if num_banners == 4 and ( loop.index == 3 or loop.index == 4 ) %}h2 mb-2{% else %}h2 h1-md mb-5{% endif %}{% endif %} textbanner-title {% if banner_url and banner_button_text %}textbanner-title-with-btn{% endif %}">{{ banner_title }}</h3>
                                {% endif %}
                                {% if banner_url and banner_button_text %}
                                    <div class="btn btn-small textbanner-btn">{{ banner_button_text }}</div>
                                {% endif %}
                            </div>
                            {% if banner_url %}
                                </a>
                            {% endif %}
                        </div>
                    </div>
                    {% if num_banners == 4 and loop.index == 4 %}
                        </div>
                    </div>
                    {% endif %}
                    {% if num_banners == 3 and has_banner_01 and loop.index == 1 %}
                    <div class="col-md{% if settings.theme_variant == 'squared' %}-6{% else %}-7{% endif %}">
                        <div class="row no-gutters">
                    {% endif %}

                {% endif %}
            {% endfor %}
            {% if num_banners == 3 and has_banner_01 %}
                </div>
            </div>
            {% endif %}
        </div>
    </div>
</section>
