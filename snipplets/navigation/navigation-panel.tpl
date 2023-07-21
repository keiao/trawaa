{% if primary_links %}
    <div class="nav-primary">
        {% if settings.search_more_visible %}
        <div class="d-md-none">
        {% endif %}
            {% include "snipplets/navigation/navigation-lang.tpl" %}
        {% if settings.search_more_visible %}
        </div>
        {% endif %}
        {% if settings.search_more_visible %}
        <div class="d-block d-md-none">
        {% endif %}
            {% include "snipplets/header/header-search.tpl" %}
        {% if settings.search_more_visible %}
        </div>
        {% endif %}
        <ul class="nav-list" data-store="navigation" data-component="menu">
            {% snipplet "navigation/navigation-nav-list.tpl" %}
        </ul>
    </div>
{% else %}
    <div class="nav-secondary{% if settings.theme_variant == 'squared' %} pb-0{% endif %}">
        <div class="account-user-icon">
            {% if not customer %}
                {% if settings.theme_variant == 'squared' %}
                    {% include "snipplets/svg/user.tpl" with {svg_custom_class : "svg-inline--fa fa-lg svg-icon-invert"} %}
                {% else %}
                    {% include "snipplets/svg/user.tpl" with {svg_custom_class : "svg-inline--fa svg-icon-invert"} %}
                {% endif %}
            {% else %}
                {% set customer_first_name_letter = customer.name| split(' ')[0]|slice(0, 1) %}
                {% set customer_last_name_letter = customer.name| split(' ')[1]|slice(0, 1) %}
                <span class="{% if settings.theme_variant == 'squared' %}h3 {% endif %}font-weight-bold">{{ customer_first_name_letter }}{{ customer_last_name_letter }}</span>
            {% endif %}
        </div>
        <ul class="nav-account" data-store="account-links">
            {% if not customer %}
                {% if 'mandatory' not in store.customer_accounts %}
                <li class="nav-accounts-item mt-2">{{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'nav-accounts-link') }}</li>
                {% endif %}
                <li class="nav-accounts-item mt-2">{{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, '', 'nav-accounts-link') }}</li>
            {% else %}
                {% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %}
                <div class="font-weight-bold">{{ "¡Hola, {1}!" | t(customer_short_name) }}</div>
                <li class="nav-accounts-item">{{ "Mi cuenta" | translate | a_tag(store.customer_home_url, '', 'nav-accounts-link') }}</li>
                <li class="nav-accounts-item">{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, '', 'nav-accounts-link') }}</li>
            {% endif %}
        </ul>
    </div>
{% endif %}