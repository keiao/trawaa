<div class="utilities-container">
	{% if settings.search_more_visible or settings.account_more_visible %}
	<div class="row no-gutters align-items-center justify-content-end">
		{% if settings.account_more_visible %}
			<div class="col-auto p-0 d-none d-md-block{% if languages | length > 1 %} mr-3{% endif %}">
				<div class="js-toggle-account-container form-select form-select-account" data-store="account-links">
					<div class="js-toggle-account pr-4">
						{% include "snipplets/svg/user.tpl" with {svg_custom_class : "svg-inline--fa fa-lg svg-icon-text mr-2"} %}
						<div class="js-account-arrow form-control-icon form-control-icon-account">
							{% include "snipplets/svg/chevron-down.tpl" %}
						</div>
						{% if not customer %}
							<div class="d-inline-block mr-2">{{ "Mi cuenta" | translate }}</div>
						</div>
							<div class="js-account-container form-select-account-links hidden">
								{% if 'mandatory' not in store.customer_accounts %}
									<span class="d-block">{{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'text-foreground') }}</span>
								{% endif %}
								<span class="d-block">{{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, '', 'text-foreground') }}</span>
							</div>
						{% else %}
							{% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %}
							<div class="d-inline-block mr-2">{{ "¡Hola, {1}!" | t(customer_short_name) }}</div>
						</div>
							<div class="js-account-container form-select-account-links hidden">
								<span class="d-block">{{ "Mi cuenta" | translate | a_tag(store.customer_home_url, '', 'text-foreground') }}</span>
								<span class="d-block">{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, '', 'text-foreground') }}</span>
							</div>
						{% endif %}
				</div>
			</div>
		{% endif %}
		{% if settings.search_more_visible %}
			<div class="col-auto p-0">
				<div class="d-none d-md-block">
					{% include "snipplets/navigation/navigation-lang.tpl" %}
				</div>
			</div>
		{% endif %}
		<div class="col-auto pl-4">
	{% endif %}
	{% if not store.is_catalog %}
		<a 
		{% if settings.ajax_cart and template != 'cart' %}
			href="#" class="js-modal-open js-toggle-cart js-fullscreen-modal-open utilities-item" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart"
		{% else %}
			href="{{ store.cart_url }}" class="utilities-item" 
		{% endif %} 
		data-component="cart-button">
			{% include "snipplets/svg/shopping-bag.tpl" %}
			<span class="js-cart-widget-amount cart-widget-amount">{{ "{1}" | translate(cart.items_count ) }}</span>
		</a>
	{% endif %}
	{% if settings.search_more_visible or settings.account_more_visible %}
	</div>
	</div>
	{% endif %}
</div>