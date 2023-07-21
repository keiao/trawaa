{# Cookie validation #}

{% if show_cookie_banner and not params.preview %}
    <div class="js-notification js-notification-cookie-banner notification notification-fixed-bottom notification-above notification-primary" style="display: none;">
        <div class="mb-3 text-foreground">{{ 'Al navegar por este sitio <strong>aceptás el uso de cookies</strong> para agilizar tu experiencia de compra.' | translate }}</div>
        <div class="text-center">
            <a href="#" class="js-notification-close js-acknowledge-cookies btn btn-primary btn-{% if settings.theme_variant == 'squared' %}medium px-4 py-2{% else %}small{% endif %} d-inline-block">{{ "Entendido" | translate }}</a>
        </div>
    </div>
{% endif %}

{# Order notification #}

{% if show_order_cancellation %}
    <div class="js-notification js-notification-order-cancellation notification notification-fixed-bottom notification-secondary {% if settings.theme_variant == 'rounded' %} mb-lg-2 {% endif %}" style="display:none;" data-url="{{ status_page_url }}">
        <div class="container">
            <div class="row">
                <div class="col">
                    <a href="{{ store.contact_url }}?order_cancellation=true"><strong class="text-primary">{{ "Botón de arrepentimiento" | translate }}</strong></a>
                    <a class="js-notification-close js-notification-order-cancellation-close ml-3" href="#">
                        {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}
                    </a>
                </div>
            </div>
        </div>
    </div>
{% endif %}

{% if order_notification and status_page_url %}
    <div class="js-notification js-notification-status-page notification notification-secondary" style="display: none;" data-url="{{ status_page_url }}">
        <div class="container">
            <div class="row">
                <div class="col">
                    <a class="btn btn-link" href="{{ status_page_url }}">{{ "Seguí acá tu última compra" | translate }}</a>
                    <a class="js-notification-close js-notification-status-page-close ml-3" href="#">{% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-icon-text"} %}</a>
                </div>
            </div>
        </div>
    </div>
{% endif %}

{# Add to cart notification #}

{% if add_to_cart %}
    <div class="js-alert-added-to-cart notification-floating notification-hidden {% if add_to_cart_fixed %}notification-fixed{% endif %}" style="display: none;">
        <div class="notification notification-primary {% if settings.theme_variant == 'rounded' %}notification-with-arrow{% endif %} {% if settings.theme_variant == 'rounded' and not settings.head_fix %}mt-3{% endif %} position-relative {% if not add_to_cart_mobile %}col-12 float-right{% endif %}">
            <div class="text-center mb-3 mr-3">
                <strong>{{ '¡Ya agregamos tu producto al carrito!' | translate }}</strong>
            </div>
            <div class="js-cart-notification-close notification-close">
                {% include "snipplets/svg/times.tpl" with {fa_custom_class: "icon-inline fa-2x  svg-icon-primary"} %}
            </div>
            <div class="js-cart-notification-item row" data-store="cart-notification-item">
                <div class="col-3 pr-0 notification-img">
                    <img src="" class="js-cart-notification-item-img img-fluid" />
                </div>
                <div class="col-9 text-left">
                    <div class="mb-1">
                        <span class="js-cart-notification-item-name"></span>
                        <span class="js-cart-notification-item-variant-container" style="display: none;">
                            (<span class="js-cart-notification-item-variant"></span>)
                        </span>
                    </div>
                    <div class="mb-1">
                        <span class="js-cart-notification-item-quantity"></span>
                        <span> x </span>
                        <span class="js-cart-notification-item-price"></span>
                    </div>
                </div>
            </div>
            <div class="row text-primary h5 font-weight-normal mt-2 mb-3">
                <span class="col-auto text-left">
                    <strong>{{ "Total" | translate }}</strong> 
                    (<span class="js-cart-widget-amount">
                        {{ "{1}" | translate(cart.items_count ) }} 
                    </span>
                    <span class="js-cart-counts-plural" style="display: none;">
                        {{ 'productos' | translate }}):
                    </span>
                    <span class="js-cart-counts-singular" style="display: none;">
                        {{ 'producto' | translate }}):
                    </span>
                </span>
                <strong class="js-cart-total col text-right">{{ cart.total | money }}</strong>
            </div>
            <a href="#" class="js-modal-open js-cart-notification-close js-fullscreen-modal-open btn btn-primary btn-small w-100 d-inline-block" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">
                {{'Ver carrito' | translate }}
            </a>
        </div>
    </div>
{% endif %}
