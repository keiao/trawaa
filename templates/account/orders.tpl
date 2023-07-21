{% embed "snipplets/page-header.tpl" %}
    {% block page_header_text %}{{ "Mi cuenta" | translate }}{% endblock page_header_text %}
{% endembed %}

<section class="account-page">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-3">
            <div class="{% if settings.theme_variant == 'rounded' %} box box-square p-md-3{% endif %}">
                <h4 class="{% if settings.theme_variant == 'rounded' %} swiper-description {% endif %}text-uppercase">{{ 'Mis datos' | translate }} {{ 'Editar' | translate | a_tag(store.customer_info_url, '', 'mt-1 btn-link btn-link-primary font-small float-right font-weight-bold') }}</h4>

                <p class="mb-0 font-small">
                    <strong>
                       {% include "snipplets/svg/user.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-text svg-icon-accent mr-2"} %} {{customer.name}}
                    </strong>
                    <div class="divider ml-4 mr-0 my-2"></div>
                    <span class="d-block font-small">
                        {% include "snipplets/svg/envelope.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-text svg-icon-accent mr-2"} %} {{customer.email}}
                    </span>
                    <div class="divider ml-4 mr-0 my-2"></div>
                    {% if customer.cpf_cnpj %}
                    <span class="d-block font-small">
                        {% include "snipplets/svg/address-card.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-text svg-icon-accent mr-2"} %} {{ 'DNI' | translate }}: {{ customer.cpf_cnpj | format_cpf_cnpj }}
                    </span>
                    <div class="divider ml-4 mr-0 my-2"></div>
                    {% endif %}
                    {% if customer.phone %}
                    <span class="d-block font-small">
                        {% include "snipplets/svg/phone.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-text svg-icon-accent mr-2"} %} {{ customer.phone }}
                    </span>
                    {% endif %}
                </p>
            </div>
            <div class="{% if settings.theme_variant == 'rounded' %} box box-square  p-md-3{% endif %} my-4">
                <h4 class="{% if settings.theme_variant == 'rounded' %}swiper-description{% endif %} text-uppercase mb-3">{{ 'Mis direcciones' | translate }} {{ 'Editar' | translate | a_tag(store.customer_addresses_url, '', 'mt-1 btn-link btn-link-primary font-small float-right font-weight-bold') }}</h4>
                {% if customer.default_address %}
                    <span class="font-small d-flex">
                        {% include "snipplets/svg/location.tpl" with {svg_custom_class: "svg-inline--fa svg-icon-text svg-icon-accent mr-4 mt-4"} %} 
                        <span> <strong class="d-block mb-1">{{ 'Principal' | translate }}</strong> {{ customer.default_address.name }} - {{ customer.default_address | format_address_short }}</span>
                        {% if settings.theme_variant == 'squared' %}
                            <div class="divider"></div>
                        {% endif %}
                    </span>
                {% endif %}
            </div>
            </div>
            <div class="col-md-8">
                <h4 class="{% if settings.theme_variant == 'rounded' %}swiper-description{% endif %} text-uppercase mb-4">{{ 'Mis compras' | translate }}</h4>
                <div class="row" data-store="account-orders">
                    {% if customer.orders %}
                    {% for order in customer.orders %}
                        {% set add_checkout_link = order.pending %}
                        <div class="col-md-6" data-store="account-order-item-{{ order.id }}">
                            <div class="box box-square p-0">
                                {% embed "snipplets/card.tpl" with{card_footer: true, card_custom_class: 'card-collapse', card_active: card_active, card_collapse: true} %}
                                    {% block card_head %}
                                        <div class="row">
                                            <div class="col{% if settings.theme_variant == 'squared' %}-12{% endif %}">
                                                <h4 class="{% if settings.theme_variant == 'squared' %}h6 text-uppercase {% endif %}m-0 text-primary">
                                                    <strong>{{'Orden' | translate}}:  <a class="btn-link-primary text-primary" href="{{ store.customer_order_url(order) }}">#{{order.number}} </a></strong>
                                                </h4>
                                            </div>
                                            <div class="col{% if settings.theme_variant == 'squared' %}-12 {% else %}text-center{% endif %} opacity-40">
                                                <p class="mb-0{% if settings.theme_variant == 'rounded' %} mr-2{% endif %}"><small>{{ order.date | i18n_date('%d/%m/%Y') }}</small></p>
                                            </div> 
                                        </div>
                                    {% endblock %}
                                    {% block card_body %}
                                        <div class="container">
                                            <div class="row">
                                                <div class="col-4">
                                                     <div class="card-img-square-container">
                                                        {% for item in order.items %}
                                                        {% if loop.first %} 
                                                            {{ item.featured_image | product_image_url("") | img_tag(item.featured_image.alt, {class: 'card-img-square'}) }}
                                                        {% endif %}
                                                        {% endfor %}
                                                    </div>
                                                </div>
                                                <div class="col-8">
                                                    <p class="my-1">
                                                        {{'Pago' | translate}}: <strong class="{{ order.payment_status }}">{{ (order.payment_status == 'pending'? 'Pendiente' : (order.payment_status == 'authorized'? 'Autorizado' : (order.payment_status == 'paid'? 'Pagado' : (order.payment_status == 'voided'? 'Cancelado' : (order.payment_status == 'refunded'? 'Reintegrado' : 'Abandonado'))))) | translate }}</strong>
                                                    </p>
                                                    <div class="divider my-0"></div>
                                                    <p class="my-1">
                                                        {{'Envío' | translate}}: <strong> {{ (order.shipping_status == 'fulfilled'? 'Enviado' : 'No enviado') | translate }} </strong>
                                                    </p>
                                                    <div class="divider mt-0 mb-2"></div>
                                                    <h4 class="mb-2">
                                                        {{'Total' | translate}} <strong>{{ order.total | money }}</strong>
                                                    </h4>
                                                    <a class="btn-link-primary text-primary text-uppercase" href="{{ store.customer_order_url(order) }}"> {{'Ver detalle >' | translate}} </a>
                                                </div>
                                            </div>
                                        </div>
                                    {% endblock %}
                                    {% block card_foot %}
                                        {% if add_checkout_link %}
                                            <a class="btn btn-primary btn-small w-100 d-inline-block" href="{{ order.checkout_url | add_param('ref', 'orders_list') }}" target="_blank">{{'Realizar el pago' | translate}}</a>
                                        {% elseif order.order_status_url != null %}
                                            <a class="btn btn-primary btn-small w-100 d-inline-block" href="{{ order.order_status_url | add_param('ref', 'orders_list') }}" target="_blank">{% if 'Correios' in order.shipping_name %}{{'Seguí la entrega' | translate}}{% else %}{{'Seguí tu orden' | translate}}{% endif %}</a>
                                        {% endif %}
                                    {% endblock %}
                                {% endembed %}
                            </div>
                        </div>
                    {% endfor %}
                    {% else %}
                        <div class="col text-center">
                            {% include "snipplets/svg/shopping-bag.tpl" with {svg_custom_class: "svg-icon-accent fa-2x mb-2 "} %}
                            <p class="mb-0">{{ '¡Hacé tu primera compra!' | translate }}</p>
                            {{ 'Ir a la tienda' | translate | a_tag(store.url, '', 'btn-primary btn-small w-100 mt-2') }}
                        </div>
                    {% endif %}
                </div>
            </div>
        </div>
    </div>
</section>