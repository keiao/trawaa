<div class="service-item-container swiper-slide">
    <div class="service-item">
        {% if banner_services_url %}
            <a href="{{ banner_services_url | setting_url }}">
        {% endif %}
        {% if banner_services_icon == 'shipping' %}
            {% include "snipplets/svg/truck-big.tpl" with {fa_custom_class : "fa-5x service-icon svg-icon-text"} %}
        {% elseif banner_services_icon == 'card' %}
            {% include "snipplets/svg/credit-card-big.tpl" with {fa_custom_class : "fa-5x service-icon svg-icon-text"} %}
        {% elseif banner_services_icon == 'security' %}
            {% include "snipplets/svg/shield-check-big.tpl" with {fa_custom_class : "fa-6x service-icon svg-icon-text"} %}
        {% elseif banner_services_icon == 'returns' %}
            {% include "snipplets/svg/sync-big.tpl" with {fa_custom_class : "fa-5x service-icon svg-icon-text"} %}
        {% elseif banner_services_icon == 'whatsapp' %}
            {% include "snipplets/svg/whatsapp-big.tpl" with {fa_custom_class : "fa-5x service-icon svg-icon-text"} %}
        {% elseif banner_services_icon == 'promotions' %}
            {% include "snipplets/svg/badge-percent-big.tpl" with {fa_custom_class : "fa-6x service-icon svg-icon-text"} %}
        {% elseif banner_services_icon == 'cash' %}
            {% include "snipplets/svg/usd-circle-big.tpl" with {fa_custom_class : "fa-6x service-icon svg-icon-text"} %}
        {% elseif banner_services_icon == 'hand' %}
            {% include "snipplets/svg/clean-hands-big.tpl" with {fa_custom_class : "fa-6x service-icon svg-icon-text"} %}
        {% elseif banner_services_icon == 'home' %}
            {% include "snipplets/svg/stay-home-big.tpl" with {fa_custom_class : "fa-6x service-icon svg-icon-text"} %}
        {% elseif banner_services_icon == 'office' %}
            {% include "snipplets/svg/home-office-big.tpl" with {fa_custom_class : "fa-6x service-icon svg-icon-text"} %}
        {% endif %}
        {% if banner_services_title %}
            <h3 class="service-title">{{ banner_services_title }}</h3>
        {% endif %}
        {% if banner_services_description %}
            <p class="font-weight-light">{{ banner_services_description }}</p>
        {% endif %}
        {% if banner_services_url %}
            </a>
        {% endif %}
    </div>
</div>
