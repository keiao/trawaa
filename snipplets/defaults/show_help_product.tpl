<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container">
    <div class="container-fluid">
        <div class="row section-product-detail">
            <div class="col-12 col-md-8 pl-0 pr-0 product-detail-img-col">
                <div class="js-swiper-product swiper-container">
                    <div class="labels">
                        <div class="label label-primary">{{ "35% OFF" | translate }}</div>
                    </div>
                    <div class="swiper-wrapper">
                         <div class="swiper-slide js-product-slide slider-slide" data-image="0" data-image-position="0">
                            <a href="{{ image | product_image_url('huge') }}" data-fancybox="product-gallery" class="d-block p-relative">
                                {% include "snipplets/svg/help/help-product-3.tpl" %}
                            </a>
                         </div>
                         <div class="swiper-slide js-product-slide slider-slide" data-image="1" data-image-position="1">
                            <a href="{{ image | product_image_url('huge') }}" data-fancybox="product-gallery" class="d-block p-relative">
                                {% include "snipplets/svg/help/help-product-3-green.tpl" %}
                            </a>
                         </div>
                         <div class="swiper-slide js-product-slide slider-slide" data-image="2" data-image-position="2">
                            <a href="{{ image | product_image_url('huge') }}" data-fancybox="product-gallery" class="d-block p-relative">
                                {% include "snipplets/svg/help/help-product-3-red.tpl" %}
                            </a>
                         </div>
                    </div>
                    <div class="js-swiper-product-pagination swiper-pagination swiper-pagination-white right"></div>
                    <div class="js-swiper-product-prev swiper-button-prev">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-2x svg-icon-text"} %}</div>
                    <div class="js-swiper-product-next swiper-button-next">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-2x svg-icon-text"} %}</div>
                </div>
                {% snipplet 'placeholders/product-detail-image-placeholder.tpl' %}
                {% if settings.theme_variant == 'squared' %}
                    <div class="thumbs d-none d-md-block visible-when-content-ready">
                        <a href="#" class="js-product-thumb thumb-link" data-slide-index="0">
                            {% include "snipplets/svg/help/help-product-3.tpl" %}
                        </a>
                        <a href="#" class="js-product-thumb thumb-link" data-slide-index="1">
                            {% include "snipplets/svg/help/help-product-3-green.tpl" %}
                        </a>
                        <a href="#" class="js-product-thumb thumb-link" data-slide-index="2">
                            {% include "snipplets/svg/help/help-product-3-red.tpl" %}
                        </a>
                    </div>
                {% endif %}
            </div>
            <div class="col product-detail-form-col">
                <div class="js-sticky-product">
                	{# Product name and breadcrumbs #}
                    <section class="page-header">
                        <div class="breadcrumbs">
                            <a class="crumb" href="{{ store.url }}" title="{{ store.name }}">{{ "Inicio" | translate }}</a>
                            <span class="divider">&gt;</span>
                            <a class="crumb" href="{{ store.products_url }}" title="{{ "Productos" | translate }}">{{ "Productos" | translate }}</a>
                            <span class="divider">&gt;</span>
                            <span class="crumb active">{{ "Producto de ejemplo" | translate }}</span>
                        </div>
                        <h1 class="h2 h2-md">{{ "Producto de ejemplo" | translate }}</h1>
                    </section>

                    {# Product price #}

                    {% if store.country == 'BR' %}
                        <div class="price-container">
                            <span class="d-inline-block mr-3">
                                <h3 class="js-price-display font-weight-bold" id="price_display">{{"18200" | money }}</h3>
                            </span>
                            <span class="d-inline-block">
                               <h3 id="compare_price_display" class="js-compare-price-display price-compare" style="display:block;">{{"28000" | money }}</h3>
                            </span>
                        </div>
                    {% else %}
                        <div class="price-container">
                            <span class="d-inline-block mr-3">
                                <h3 class="js-price-display font-weight-bold" id="price_display">{{"182000" | money }}</h3>
                            </span>
                            <span class="d-inline-block">
                               <h3 id="compare_price_display" class="js-compare-price-display price-compare" style="display:block;">{{"280000" | money }}</h3>
                            </span>
                        </div>
                    {% endif %}

                    {# Product installments #}

                    <div href="#installments-modal" class="js-product-payments-container row mb-4">
                        <span class="js-max-installments-container js-max-installments col-auto">
                            {% include "snipplets/svg/credit-card-blank.tpl" with {svg_custom_class : "svg-inline--fa fa-lg mr-2 svg-icon-text float-left "} %}
                            <span class="d-table text-inline">
                                <span>{{ "Hasta 12 cuotas" | translate }}</span>
                            </span>
                        </span>
                    </div>

                    {# Product form, includes: Variants, CTA and Shipping calculator #}

                    <form id="product_form" class="js-product-form" method="post" action="">
                        <input type="hidden" name="add_to_cart" value="2243561" />

                        <div class="js-product-variants row">
                            <div class="col-6">
                                <div class="form-group ">
                                    <label class="form-label " for="variation_1">{{ "Color" | translate }}</label>
                                    <select id="variation_1" class="form-select js-variation-option js-refresh-installment-data  " name="variation[0]">
                                        <option value="{{ "Verde" | translate }}">{{ "Verde" | translate }}</option>
                                        <option value="{{ "Rojo" | translate }}">{{ "Rojo" | translate }}</option>
                                    </select>
                                    <div class="form-control-icon">
                                        {% include "snipplets/svg/long-arrow-down.tpl" %}
                                    </div>
                                </div>
                            </div>
                            <div class="col-6">
                                <label class="form-label">{{ 'Cantidad' | translate }}</label>
                                {% embed "snipplets/forms/form-input.tpl" with{
                                type_number: true, input_value: '1',
                                input_name: 'quantity' ~ item.id,
                                input_custom_class: 'js-quantity-input text-center h5',
                                input_label: false,
                                input_append_content: true,
                                input_group_custom_class: 'js-quantity form-quantity',
                                form_control_container_custom_class: 'col',
                                input_min: '1'} %}
                                    {% block input_prepend_content %}
                                    <div class="row m-0 align-items-center">
                                        <span class="js-quantity-down text-center btn">
                                            {% include "snipplets/svg/minus.tpl" %}
                                        </span>
                                    {% endblock input_prepend_content %}
                                    {% block input_append_content %}
                                        <span class="js-quantity-up text-center btn">
                                            {% include "snipplets/svg/plus.tpl" %}
                                        </span>
                                    </div>
                                    {% endblock input_append_content %}
                                {% endembed %}
                            </div>
                        </div>

                        <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary btn-block mb-4" value="{{ 'Agregar al carrito' | translate }}" />

                     </form>

                    {# Product description #}

                    <div class="product-description user-content">
                        <p>{{ "¡Este es un producto de ejemplo! Para poder probar el proceso de compra, debes" | translate }}
                            <a href="/admin/products" target="_top">{{ "agregar tus propios productos." | translate }}</a>
                        </p>
                    </div>

                    {# Product share #}

                    {% include 'snipplets/social/social-share.tpl' %}

                    {% if settings.show_product_fb_comment_box %}
                        <div class="fb-comments section-fb-comments" data-href="{{ product.social_url }}" data-num-posts="5" data-width="100%"></div>
                    {% endif %}
                    <div id="reviewsapp"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<section id="related-products" class="section-products-related">
    <h3 class="h2 section-title m-0">{{ "Productos Relacionados" | translate }}</h3>
     <div class="js-swiper-related swiper-container">
        <div class="swiper-wrapper">
            {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_1': true}  %}
            {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_4': true}  %}
            {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_6': true}  %}
            {% include 'snipplets/defaults/help_item.tpl' with {'slide_item': true, 'help_item_7': true}  %}
        </div>
        <div class="js-swiper-related-pagination swiper-pagination"></div>
        <div class="js-swiper-related-prev swiper-button-prev">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
        <div class="js-swiper-related-next swiper-button-next">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
    </div>
</section>
