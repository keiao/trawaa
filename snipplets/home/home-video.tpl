{% if settings.video_embed %}
    <section class="section-video-home" data-store="video-home">
        <div class="container-fluid p-0">
            <div class="row no-gutters">
                <div class="col">
                    {% include 'snipplets/video-item.tpl' %}
                </div>
            </div>
        </div>
    </section>
{% endif %}