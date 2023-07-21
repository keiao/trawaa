{% if settings.show_instafeed and store.instagram %}
    <section class="section-instafeed-home" data-store="instagram-feed">
        <div class="container-fluid p-0">
            <div class="row no-gutters">
                <div class="col{% if settings.theme_variant == 'rounded' %}-12 text-center my-5{% endif %}">
                    {% set instuser = store.instagram|split('/')|last %}
                    {% set instagram_icon_class = settings.theme_variant == 'rounded' ? 'svg-inline--fa fa-3x svg-icon-primary' : 'svg-inline--fa fa-2x svg-icon-invert' %}

                    {# Instagram fallback info #}

                    {% if settings.theme_variant == 'squared' %}
                        <div class="js-ig-fallback text-center py-5 px-3">
                            <a target="_blank" href="{{ store.instagram }}" aria-label="{{ 'Instagram de' | translate }} {{ store.name }}">
                                {% include "snipplets/svg/instagram.tpl" with {svg_custom_class: 'svg-inline--fa fa-4x svg-icon-invert'} %}
                                <div class="instafeed-title-user text-secondary text-left mt-1 ml-2">
                                    <h2 class="instafeed-user-fallback mb-0 mb-md-1">{{ instuser }}</h2>
                                    <div class="text-uppercase ml-1">{{ 'Seguinos en Instagram' | translate }}</div>
                                </div>
                            </a>
                        </div>
                    {% endif %}
                    <a target="_blank" href="{{ store.instagram }}" class="{% if settings.theme_variant == 'squared' %}js-ig-success{% endif %} instafeed-title" aria-label="{{ 'Instagram de' | translate }} {{ store.name }}" {% if settings.theme_variant == 'squared' %}style="display: none;"{% endif %}>
                        <div class="text-center">
                            <div class="mb-2">
                                {% include "snipplets/svg/instagram.tpl" with {svg_custom_class: instagram_icon_class} %}
                                <h2 class="instafeed-title-user {% if settings.theme_variant == 'rounded' %}h1-md h2{% else %}h3{% endif %}">{{ instuser }}</h2>
                            </div>
                            {% if settings.theme_variant == 'rounded' %}
                                {# Instagram fallback link #}
                                <span class="js-ig-fallback btn btn-line btn-line-primary btn-small mt-2">{{ 'Seguinos' | translate }}</span>
                            {% endif %}
                        </div>
                    </a>
                {% if settings.theme_variant == 'rounded' %}</div><div class="col">{% endif %}
                    {% if store.hasInstagramToken() %}
                        <div id="instagram-feed" class="js-ig-success instafeed-container" 
                            data-ig-feed
                            data-ig-items-count="7"
                            data-ig-item-class="instafeed-link"
                            data-ig-link-class=""
                            data-ig-image-class="instafeed-img fade-in"
                            data-ig-aria-label="{{ 'Publicación de Instagram de' | translate }} {{ store.name }}"
                            style="display: none;">
                        </div>
                    {% endif %}
                </div>
            </div>
        </div>
    </section>
{% endif %}