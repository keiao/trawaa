{% embed "snipplets/page-header.tpl" %}
	{% block page_header_text %}{{ 'Iniciar sesión' | translate }}{% endblock page_header_text %}
{% endembed %}

{# Login Form #}

<section class="account-page">
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col-md-10 col-lg-8">

				{# Account validation #}
				<div class="row justify-content-center">
					<div class="col-md-8">
						{% if account_validation == 'success' %}
							<div class="js-account-validation-success alert alert-success">
								<p class="m-1">{{ "¡Tu cuenta fue creada con éxito!" | translate }}</p>
							</div>
						{% elseif account_validation == 'expired' %}
							<div class="js-account-validation-expired alert alert-danger mb-2">
								<p class="m-1">{{ "Tu link de validación expiró." | translate }}</p>
							</div>
							<div class="text-center mb-4 font-small">
								<span class="js-resend-validation-link btn-link font-weight-bold">{{ "Enviar link de nuevo >" | translate }}</span>
							</div>
						{% elseif account_validation == 'pending' %}
							<div class="js-account-validation-pending alert alert-danger mb-2">
								<p class="m-1">{{ "Validá tu email usando el link que te enviamos a <strong>{1}</strong> cuando creaste tu cuenta." | t(customer_email) }}</p>
							</div>
							<div class="text-center mb-4 font-small">
								<p>{{ "¿No lo encontraste?" | translate }} <span class="js-resend-validation-link btn-link font-weight-bold">{{ "Enviar link de nuevo" | translate }}</span></p>
							</div>
			         	{% endif %}
		         		<div class="js-resend-validation-success alert alert-success" style="display:none">
							<p class="m-1">{{ "¡El link fue enviado correctamente!" | translate }}</p>
						</div>
					    <div class="js-resend-validation-error alert alert-danger" style="display:none">
							<p class="m-1">{{ "No pudimos enviar el email, intentalo de nuevo en unos minutos." | translate }}</p>
						</div>
						<div class="js-too-many-attempts alert alert-danger" style="display:none">
							<p class="mb-0">
								{{ 'Superaste la cantidad de intentos permitidos. <br> Volvé a probar en' | translate }}
								<span class="js-too-many-attempts-countdown"></span>
							</p>
						</div>
					</div>
				</div>

				{% embed "snipplets/forms/form.tpl" with{form_id: 'login-form', submit_text: 'Iniciar sesión' | translate, data_store: 'account-login' } %}
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

						{% embed "snipplets/forms/form-input.tpl" with{'input_label_custom_class': label_class, input_for: 'email', type_email: true, input_value: result.email, input_name: 'email', input_label_text: 'Email' | translate, input_placeholder: 'tunombre@email.com' | translate, input_required: true } %}
						{% endembed %}

						{# Password input #}

						{% embed "snipplets/forms/form-input.tpl" with{'input_label_custom_class': label_class, input_for: 'password', type_password: true, input_name: 'password', input_help: true, input_help_link: store.customer_reset_password_url, input_label_text: 'Contraseña' | translate, input_required: true } %}
							{% block input_help_text %}{{ '¿Olvidaste tu contraseña?' | translate }}{% endblock input_help_text %}
						{% endembed %}

						{% block input_form_alert %}
							{% if not result.facebook and result.invalid %}
								<div class="notification-danger text-center my-5 px-4">
									<span>
										{{ 'Estos datos no son correctos. ¿Chequeaste que estén bien escritos?' | translate }}
									</span>
								</div>
							{% endif %}
						{% endblock input_form_alert %}
					{% endblock %}
				{% endembed %}
				{% if 'mandatory' not in store.customer_accounts %}
					<p class="mt-4 text-center"> {{ "¿No tenés cuenta aún?" | translate }} {{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'btn-link font-weight-bold') }}</p>
				{% endif %}
			</div>
		</div>
	</div>
</section>