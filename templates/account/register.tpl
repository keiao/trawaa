{% embed "snipplets/page-header.tpl" %}
	{% block page_header_text %}{{ 'Crear cuenta' | translate }}{% endblock page_header_text %}
{% endembed %}

{# Register Form #}

<section class="account-page">
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col-md-8">
				<p class="text-center mb-4"> {{ 'Comprá más rápido y llevá el control de tus pedidos, ¡en un solo lugar!'| translate }}</p>

			{# Account validation #}
			{% if account_validation == 'pending' %}
				<div class="row justify-content-md-center">
					<div class="col-md-10 col-lg-8">
						<div class="js-account-validation-pending alert alert-primary p-3 my-3">
							{% if settings.theme_variant == 'rounded' %}
								{% include "snipplets/svg/envelope.tpl" with {svg_custom_class: "svg-inline--fa fa-lg svg-icon-primary"} %}
							{% endif %}
							<h5 class="mt-2 mb-1 font-weight-bold">{{ "¡Estás a un paso de crear tu cuenta!" | translate }}</h5>
							<p class="mb-0 mt-0 mt-2 font-small">{{ "Te enviamos un link a <strong>{1}</strong> para que valides tu email." | t(customer_email) }} </p>
						</div>
						<div class="text-center mb-3 font-small">
							<p>{{ "¿Todavía no lo recibiste?" | translate }} <span class="js-resend-validation-link btn-link font-weight-bold">{{ "Enviar link de nuevo" | translate }}</span></p>
						</div>
						<div class="js-resend-validation-success alert alert-success" style="display:none">
							<p class="m-1">{{ "¡El link fue enviado correctamente!" | translate }}</p>
						</div>
					    <div class="js-resend-validation-error alert alert-danger" style="display:none" >
    						<p class="m-1">{{ "No pudimos enviar el email, intentalo de nuevo en unos minutos." | translate }}</p>
						</div>
					</div>
				</div>

			{% else %}

				{% embed "snipplets/forms/form.tpl" with{form_id: 'login-form', submit_custom_class: 'js-recaptcha-button', submit_prop: 'disabled', submit_text: 'Crear cuenta' | translate, data_store: 'account-register' } %}
					{% block form_body %}

						{# Facebook login #}

						<div class="row">
							<div class="col-12 col-md-6 offset-md-3">
								{% include 'snipplets/facebook-login.tpl' %}
							</div>
						</div>

						{# Label class for rounded version #}

						{% if settings.theme_variant == 'rounded' %}
							{% set label_class = 'ml-3' %}
						{% endif %}

						{# Name input #}
						
						{% embed "snipplets/forms/form-input.tpl" with{'input_label_custom_class': label_class, type_text: true, input_for: 'name', input_value: result.name, input_name: 'name', input_id: 'name', input_label_text: 'Nombre' | translate, input_placeholder: 'María Perez' | translate} %}
							{% block input_form_alert %}
								{% if result.errors.name %}
									<div class="notification notification-danger text-left font-small">
										{% include "snipplets/svg/exclamation.tpl" with {svg_custom_class: "svg-inline--fa mr-1"} %}
										{{ 'Necesitamos tu nombre para registrarte.' | translate }}
									</div>
								{% endif %}
							{% endblock input_form_alert %}
						{% endembed %}

						{# Email input #}

						{% embed "snipplets/forms/form-input.tpl" with{'input_label_custom_class': label_class, type_email: true, input_for: 'email', input_value: result.email, input_name: 'email', input_id: 'email', input_label_text: 'Email' | translate, input_placeholder: 'tunombre@email.com' | translate} %}
							{% block input_form_alert %}
								{% if result.errors.email == 'exists' %}
									<div class="notification notification-danger text-left font-small">
										{% include "snipplets/svg/exclamation.tpl" with {svg_custom_class: "svg-inline--fa mr-1"} %}
										{{ 'Encontramos otra cuenta que ya usa este email. Intentá usando otro.' | translate }}
									</div>
								{% elseif result.errors.email %}
									<div class="notification notification-danger text-left font-small">
										{% include "snipplets/svg/exclamation.tpl" with {svg_custom_class: "svg-inline--fa mr-1"} %}
										{{ 'Necesitamos tu email para registrarte. Lo vamos a usar para enviarte el estado de tus compras.' | translate }}
									</div>
								{% endif %}
							{% endblock input_form_alert %}
						{% endembed %}

						{# Phone input #}

						{% embed "snipplets/forms/form-input.tpl" with{'input_label_custom_class': label_class, type_tel: true, input_for: 'phone', input_value: result.phone, input_name: 'phone', input_id: 'phone', input_label_text: 'Teléfono' | translate, input_placeholder: '1123445567' | translate} %}
						{% endembed %}

						{# Password input #}

						{% embed "snipplets/forms/form-input.tpl" with{'input_label_custom_class': label_class, type_password: true, input_for: 'password', input_name: 'password', input_id: 'password', input_label_text: 'Contraseña' | translate} %}
							{% block input_form_alert %}
								{% if result.errors.password == 'required' %}
									<div class="notification notification-danger text-left font-small">
										{% include "snipplets/svg/exclamation.tpl" with {svg_custom_class: "svg-inline--fa mr-1"} %}
										{{ 'Necesitamos una contraseña para registrarte.' | translate }}
									</div>
								{% endif %}
							{% endblock input_form_alert %}
						{% endembed %}

						{# Password confirm input #}

						{% embed "snipplets/forms/form-input.tpl" with{'input_label_custom_class': label_class, type_password: true, input_for: 'password_confirmation', input_name: 'password_confirmation', input_id: 'password_confirmation', input_label_text: 'Confirmar Contraseña' | translate} %}
							{% block input_form_alert %}
								{% if result.errors.password == 'confirmation' %}
									<div class="notification notification-danger text-left font-small">
										{% include "snipplets/svg/exclamation.tpl" with {svg_custom_class: "svg-inline--fa mr-1"} %}
										{{ 'Las contraseñas que escribiste no coinciden. Chequeá que sean iguales entre sí.' | translate }}
									</div>
								{% endif %}
							{% endblock input_form_alert %}
						{% endembed %}

						{# Google reCAPTCHA #}

						<div class="g-recaptcha" data-sitekey="{{recaptchaSiteKey}}" data-callback="recaptchaCallback"></div>
						
					{% endblock %}
				{% endembed %}
				<p class="mt-4 text-center">{{ '¿Ya tenés una cuenta?' | translate }} {{ "Iniciá sesión" | translate | a_tag(store.customer_login_url, '', 'btn-link font-weight-bold') }}</p>
			</div>
			{% endif %}
		</div>
	</div>
</section>