{% if store.whatsapp %}
    <a href="{{ store.whatsapp }}" target="_blank" class="js-btn-fixed-bottom btn-whatsapp visible-when-content-ready" aria-label="{{ 'Comunicate por WhatsApp' | translate }}">
        {% include "snipplets/svg/whatsapp.tpl" with {svg_custom_class: "svg-inline--fa fa-2x"} %}
    </a>
{% endif %}
