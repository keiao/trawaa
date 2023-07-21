{% if settings.theme_variant == 'squared' %}
    {% set cart_alert_class = 'm-3' %}
    <div class="section-cart-detail">
{% endif %}

        {% embed "snipplets/page-header.tpl" with {'breadcrumbs': true} %}
            {% block page_header_text %}{{ "Carrito de Compras" | translate }}{% endblock page_header_text %}
        {% endembed %}

        <div id="shoppingCartPage" class="cart-page container-fluid {% if settings.theme_variant == 'rounded' %}mt-2{% endif %} visible-when-content-ready" data-minimum="{{ settings.cart_minimum_value }}">
            <form action="{{ store.cart_url }}" method="post" class="cart-body" data-store="cart-form">
                <div class="row cart-body">
                    <div class="col-12 {% if cart.items %}col-md-8{% endif %} {% if settings.theme_variant == 'squared' %}pl-0 pr-0{% endif %}">
                        {# Cart alerts #}

                        {% if error.add %}
                            {{ component('alert', {
                                'type': 'warning',
                                'message': 'our_components.cart.error_messages.' ~ error.add,
                                'class': cart_alert_class,
                            }) }}
                        {% endif %}
                        {% for error in error.update %}
                            <div class="alert alert-warning {% if settings.theme_variant == 'squared' %}m-3{% endif %}">{{ "No podemos ofrecerte {1} unidades de {2}. Solamente tenemos {3} unidades." | translate(error.requested, error.item.name, error.stock) }}</div>
                        {% endfor %}
                        {% if cart.items %}
                            <div class="js-ajax-cart-list cart-row mt-3 {% if settings.theme_variant == 'rounded' %}box float-none{% endif %}">

                                {# Cart items #}

                                {% if cart.items %}
                                  {% for item in cart.items %}
                                    {% include "snipplets/cart-item-ajax.tpl" with {'cart_page': true} %}
                                  {% endfor %}
                                {% endif %}
                            </div>
                        {% else %}

                            {#  Empty cart  #}

                            {% if not error %}
                                {{ component('alert', {
                                    'type': 'info',
                                    'message': ('El carrito de compras está vacío.' | translate),
                                    'class': cart_alert_class,
                                }) }}
                            {% endif %}
                        {% endif %}
                        <div id="error-ajax-stock" style="display: none;">
                            <div class="alert alert-warning">
                                {{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}<a href="{{ store.products_url }}" class="btn-link ml-1">{{ "ver otros acá" | translate }}</a>
                            </div>
                        </div>

                        <div class="d-md-none mt-2 mb-3 px-3">

                          {# Check if store has free shipping without regions or categories #}

                          {% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}

                          {% if has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}
                            
                            {# includes free shipping progress bar: only if store has free shipping with a minimum #}
                            
                            {% include "snipplets/shipping/shipping-free-rest.tpl" %}
                          {% endif %}

                        </div>

                        {% set show_cart_fulfillment = settings.shipping_calculator_cart_page and (store.has_shipping or store.branches) %}

                        {% if show_cart_fulfillment %}
                            <div class="mb-2 full-width-container">
                              {% include "snipplets/cart-shipping.tpl" %}
                            </div>
                        {% endif %}
                    </div>
                    {% if cart.items %}
                        <div class="col-12 col-md-4 pl-md-3 pr-md-3 pb-3 {% if settings.theme_variant == 'squared' %}border-left-md{% endif %}">
                            <div id="cart-sticky-summary" class="position-sticky-md {% if settings.theme_variant == 'rounded' %}box mt-md-3{% endif %}">
                                {% include "snipplets/cart-totals-and-cta.tpl" with {'cart_page': true} %}
                            </div>
                        </div>
                    {% endif %}
                </div>
            </form>
            <div id="store-curr" class="hidden">{{ cart.currency }}</div>
        </div>
{% if settings.theme_variant == 'squared' %}
    </div>
{% endif %}
