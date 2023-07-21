
{# Payments details #}

<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container" data-variants="{{product.variants_object | json_encode }}">
    <div class="container-fluid">
        <div class="row section-product-detail">
            <div class="col-12 col-md-8 pl-0 pr-0 product-detail-img-col" data-store="product-image-{{ product.id }}">
            	{% include 'snipplets/product/product-image.tpl' %}
            </div>
            <div class="col-12 col-md-4 product-detail-form-col" data-store="product-info-{{ product.id }}">
                <div class="js-sticky-product product-detail-container">
                	{% include 'snipplets/product/product-form.tpl' %}
                    {% if settings.show_product_fb_comment_box %}
                        <div class="fb-comments section-fb-comments" data-href="{{ product.social_url }}" data-num-posts="5" data-width="100%"></div>
                    {% endif %}
                    <div id="reviewsapp"></div>
                </div>
            </div>
        </div>
    </div>  
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}
