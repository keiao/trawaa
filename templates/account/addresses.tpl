
{% embed "snipplets/page-header.tpl" %}
    {% block page_header_text %}{{ "Mis direcciones" | translate }}{% endblock page_header_text %}
{% endembed %}

{# User addresses listed #}

<section class="account-page mb-0">
    <div class="container p-0">
        <div class="row justify-content-md-center">      
            {% for address in customer.addresses %}

                {# User addresses listed - Main Address #}

                {% if loop.first %}
                    <div class="col-md-4 col-12">
                        <div class="{% if settings.theme_variant == 'rounded' %}box box-square{% endif %} mt-2 p-3"> 
                           <h4 class="{% if settings.theme_variant == 'rounded' %} swiper-description {% endif %} text-uppercase mb-3">{{ 'Principal' | translate }} {{ 'Editar' | translate | a_tag(store.customer_address_url(address), '', 'mt-1 btn-link btn-link-primary font-small float-right font-weight-bold') }}</h4>

                {# User addresses listed - Other Addresses #}

                {% elseif loop.index == 2 %}
                    <div class="col-md-4 col-12">
                        <div class="{% if settings.theme_variant == 'rounded' %}box box-square{% endif %} mt-2 p-3"> 
                            <h4 class="{% if settings.theme_variant == 'rounded' %} swiper-description {% endif %}text-uppercase mb-3">{{ 'Otras direcciones' | translate }}</h4>
                {% endif %}
                    <div class="row font-small my-3">
                        <div class="col-2">
                            {% include "snipplets/svg/location.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-text svg-icon-accent mr-4 mt-4"} %} 
                        </div>
                        <div class="col-10 pl-0">
                            {% if not loop.first %}
                                <span class="{% if settings.theme_variant == 'rounded' %} swiper-description {% endif %}text-uppercase mb-3 float-right">{{ 'Editar' | translate | a_tag(store.customer_address_url(address), '', 'mt-1 btn-link btn-link-primary font-small font-weight-bold') }}</span>
                            {% endif %}
                            <span> {{ address | format_address }}</span>

                        </div>
                    </div>

                {% if loop.first %} 
                            <a class="btn btn-primary btn-small mt-2" href="{{ store.customer_new_address_url }}"> {{ 'Agregar una nueva dirección' | translate }}</a>
                        </div>
                    </div>
                {% elseif loop.last %}
                        </div>
                    </div>
                {% endif %}            
            {% endfor %}                
        </div>
    </div>
</section>
