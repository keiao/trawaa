<div class="service-item-container swiper-slide">
    <div class="service-item">  
        {% if help_item_1 %}
            {% include "snipplets/svg/truck-big.tpl" with {fa_custom_class : "fa-5x service-icon svg-icon-text"} %}
        {% elseif help_item_2 %}
            {% include "snipplets/svg/credit-card-big.tpl" with {fa_custom_class : "fa-5x service-icon svg-icon-text"} %}
        {% elseif help_item_3 %}
            {% include "snipplets/svg/shield-check-big.tpl" with {fa_custom_class : "fa-6x service-icon svg-icon-text"} %}
        {% elseif help_item_4 %}
            {% include "snipplets/svg/sync-big.tpl" with {fa_custom_class : "fa-5x service-icon svg-icon-text"} %}
        {% elseif help_item_5 %}
            {% include "snipplets/svg/whatsapp-big.tpl" with {fa_custom_class : "fa-5x service-icon svg-icon-text"} %}
        {% elseif help_item_6 %}
            {% include "snipplets/svg/badge-percent-big.tpl" with {fa_custom_class : "fa-6x service-icon svg-icon-text"} %}
        {% endif %}
        {% if help_item_1 %}
            <h3 class="service-title">{{ "Medios de envío" | translate }}</h3>
        {% elseif help_item_2 %}
            <h3 class="service-title">{{ "Tarjetas de crédito" | translate }}</h3>
        {% elseif help_item_3 %}
            <h3 class="service-title">{{ "Seguridad" | translate }}</h3>
        {% elseif help_item_4 %}
            <h3 class="service-title">{{ "Cambios y devoluciones" | translate }}</h3>
        {% elseif help_item_5 %}
            <h3 class="service-title">{{ "WhatsApp" | translate }}</h3>
        {% elseif help_item_6 %}
            <h3 class="service-title">{{ "Promociones" | translate }}</h3>
        {% endif %}
    </div>
</div>