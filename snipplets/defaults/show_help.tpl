{# Only remove this if you want to take away the theme onboarding advices #}

{# Slider that work as example #}

<section class="js-home-empty-slider-container section-slider {% if settings.slider or not settings.slider is empty %} hidden {% endif %}">
	<div class="js-home-empty-slider nube-slider-home swiper-container" style="visibility:hidden; height:0;">
		<div class="swiper-wrapper">
			<div class="swiper-slide slide-container">
				<div class="slider-slide slider-slide-empty"></div>
			</div>
			<div class="swiper-slide slide-container">
				<div class="slider-slide slider-slide-empty"></div>
			</div>
			<div class="swiper-slide slide-container">
				<div class="slider-slide slider-slide-empty"></div>
			</div>
		</div>
		<div class="js-swiper-empty-home-pagination swiper-pagination swiper-pagination-white"></div>
		<div class="js-swiper-empty-home-prev swiper-button-prev">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
		<div class="js-swiper-empty-home-next swiper-button-next">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
	</div>
</section>

{#  **** Home slider ****  #}
{% include 'snipplets/home/home-slider.tpl' %}

{# Products slider that work as examples #}

<section class="section-product-slider-home">
	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<div class="col-md{% if settings.theme_variant == 'squared' %}-6{% else %}-3{% endif %}">
				<div class="textbanner textbanner-slider m-0">
					<div class="textbanner-image textbanner-slider-image"></div>
					<div class="textbanner-text textbanner-slider-text over-image px-4 text-center text-md-left">
					<div class="h2 textbanner-title">{{ "Novedades" | translate }}</div>
				</div>
			</div>
		</div>
			<div class="col-md{% if settings.theme_variant == 'squared' %}-6{% else %}-9{% endif %}">
				<div class="js-swiper-featured swiper-container">
					<div class="swiper-wrapper">
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_1': true}  %}
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_2': true}  %}
						{% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_3': true}  %}
					</div>
					<div class="js-swiper-featured-pagination swiper-pagination"></div>
					<div class="js-swiper-featured-prev swiper-button-prev">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
					<div class="js-swiper-featured-next swiper-button-next">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
				</div>
			</div>
		</div>
	</div>
</section>

{# Welcome message that work as examples #}

<section class="section-welcome-home">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-8 offset-md-2">
				<div class="row">
					<h2 class="h1 h1-md align-self-center mb-md-0 {% if settings.theme_variant == 'squared' %}col-12 col-md-6 text-right text-center-xs{% else %}text-center {% if  settings.theme_variant == 'rounded' %} col-12{% endif %}{% endif %}">{{ "Dale la bienvenida a tus clientes" | translate }}</h2>
					<h3 class="welcome-text font-secondary align-self-center mb-0 {% if  settings.theme_variant == 'squared' %}col-12 col-md-6 text-left text-center-xs{% else %}text-center {% if  settings.theme_variant == 'rounded' %} col-12 mt-4{% endif %}{% endif %}">{{ "En este campo de texto podés escribir de qué se trata tu negocio, cómo trabajan y parte de tu historia. Contale a tus futuros clientes los motivos para comprar en tu tienda." | translate }}</h3>
				</div>
			</div>
		</div>
	</div>
</section>

{# Video that work as examples #}

<section class="section-video-home">
	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<div class="col">
				<div class="js-video-home embed-responsive embed-responsive-16by9">
					<div class="js-play-button video-player">
						<div class="video-player-content text-center col-12 col-md-9">
							{% if  settings.theme_variant == 'squared' %}
								{% include 'snipplets/svg/play-circle.tpl' with {fa_custom_class: "fa-6x"} %}
							{% endif %}
							<div class="h1 h1-huge-md mt-3">{{ "Video" | translate }}</div>
							<div class="h3 mt-4 font-secondary">{{ "Ver video" | translate }}</div>
							{% if settings.theme_variant == 'rounded' %}
								<div class="btn btn-line btn-small mt-2">{{ "Reproducir video" | translate }}</div>
							{% endif %}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

{# Informative banners that work as examples #}

<section class="section-informative-banners">
	<div class="container-fluid">
		<div class="row">
			<div class="js-informative-banners swiper-container">
			<div class="swiper-wrapper">
				{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_1': true} %}
				{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_2': true} %}
				{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_3': true} %}
				{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_4': true} %}
				{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_5': true} %}
				{% include 'snipplets/defaults/help_banner_services_item.tpl' with {'help_item_6': true} %}
				</div>
				<div class="js-informative-banners-pagination service-pagination swiper-pagination swiper-pagination-black"></div>
				<div class="js-informative-banners-prev swiper-button-prev">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
				<div class="js-informative-banners-next swiper-button-next">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
			</div>
		</div>
	</div>
</section>

{# Instagram feed that work as examples #}

<section class="section-instafeed-home">
	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<div class="col">
				<div class="instafeed-title">{% include "snipplets/svg/instagram.tpl" with {svg_custom_class: 'svg-inline--fa fa-2x svg-icon-invert'} %}<h3 class="instafeed-title-user">{{ 'Instagram' | translate }}</h3></div>
				<div id="instafeed" class="instafeed-container">
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_1': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_2': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_1': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_2': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_1': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_2': true} %}
					{% include 'snipplets/defaults/help_instagram.tpl' with {'help_item_1': true} %}
				</div>
			</div>
		</div>
	</div>
</section>

{# Featured products that work as examples #}

<section class="section-featured-home">
	<div class="container-fluid p-0">
		<div class="row no-gutters">
			<div class="col-md-6">
				<div class="row no-gutters">
				{# This if shows the title in the first module #}
					<div class="featured-title d-flex col-md-6 text-center text-md-left">
						<h2 class="my-5 m-md-4">{{ "Productos Destacados" | translate }}</h2>
					</div>
					<div class="featured-item {% if settings.theme_variant == 'squared' %}col-md-6{% else %}col-md-3{% endif %}">
						{% include 'snipplets/defaults/help_item.tpl' with {'help_item_4': true, 'square_item': true} %}
					</div>
					<div class="featured-item {% if settings.theme_variant == 'squared' %}col-md-6{% else %}col-md-3{% endif %}">
						{% include 'snipplets/defaults/help_item.tpl' with {'help_item_5': true, 'square_item': true} %}
					</div>
					<div class="featured-item {% if settings.theme_variant == 'squared' %}col-md-6{% else %}col-md-3{% endif %}">
						{% include 'snipplets/defaults/help_item.tpl' with {'help_item_6': true, 'square_item': true} %}
					</div>
				</div>   
			</div>
			<div class="featured-item {% if settings.theme_variant == 'squared' %}featured-item-big col-md-6{% else %}col-md-3{% endif %}">
				{% include 'snipplets/defaults/help_item.tpl' with {'help_item_7': true, 'square_item': true} %}
			</div>
		</div>
	</div>
</section>