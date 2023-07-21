{# /*============================================================================
  #Contact links
==============================================================================*/

#Properties

#Columns

#}

{% set columns = columns | default(false) %}

<ul class="contact-info p-0 ml-0 mt-0 text-center{% if columns %} row{% endif %}">
{% if store.whatsapp %}
	<li class="contact-item list-unstyled{% if columns %} col-6 col-md{% endif %}">{% include "snipplets/svg/whatsapp.tpl" with {svg_custom_class: "svg-inline--fa fa-lg fa-fw svg-icon-text mr-2"} %}<a href="{{ store.whatsapp }}" class="list-unstyled">{{ store.whatsapp |trim('https://wa.me/') }}</a></li>
{% endif %}
{% if store.phone %}
    <li class="contact-item list-unstyled{% if columns %} col-6 col-md{% endif %}">{% include "snipplets/svg/phone.tpl" with {svg_custom_class: "svg-inline--fa fa-lg fa-fw svg-icon-text mr-2"} %}<a href="tel:{{ store.phone }}" class="list-unstyled">{{ store.phone }}</a></li>
{% endif %}
{% if store.email %}
    <li class="contact-item list-unstyled{% if columns %} col-6 col-md{% endif %}">{% include "snipplets/svg/envelope.tpl" with {svg_custom_class: "svg-inline--fa fa-lg fa-fw svg-icon-text mr-2"} %}<a href="mailto:{{ store.email }}" class="list-unstyled">{{ store.email }}</a></li>
{% endif %}
{% if store.address and not is_order_cancellation %}
    <li class="contact-item list-unstyled{% if columns %} col-6 col-md{% endif %}">{% include "snipplets/svg/map-marker-alt.tpl" with {svg_custom_class: "svg-inline--fa fa-lg fa-fw svg-icon-text mr-2"} %}{{ store.address }}</li>
{% endif %}
{% if store.blog %}
    <li class="contact-item list-unstyled{% if columns %} col-6 col-md{% endif %}">{% include "snipplets/svg/comments.tpl" with {svg_custom_class: "svg-inline--fa fa-lg fa-fw svg-icon-text mr-2"} %}<a target="_blank" href="{{ store.blog }}" class="list-unstyled">{{ "Visita nuestro Blog!" | translate }}</a></li>
{% endif %}
</ul>