module AutoSelect2Tag
  module Select2HelperTags

    def select2_tag(name, option_tags = nil, options = {})
      static_select2_init_header_tags
      options[:class] = [options[:class], 'auto-static-select2'].compact.join(' ')
      select2_options = options.delete(:select2_options)
      if select2_options.present?
        options[:data] = (options[:data] || {}).merge('s2options' => select2_options)
      end
      select_tag(name, option_tags, options)
    end

    def select2_ajax_tag(name, select2_searcher, value = nil, options={})
      ajax_select2_init_header_tags
      limit = options.delete(:limit)
      original_classes = options.delete(:class)
      original_data = options.delete(:data) || {}
      select2_options = options.delete(:select2_options)
      original_data.merge!('s2options' => select2_options) if select2_options.present?
      search_method = options.delete(:search_method)
      classes = ['auto-ajax-select2', original_classes].compact.join(' ')
      controller_params = { class_name: select2_searcher }
      if search_method.present?
        controller_params.merge!({ search_method: search_method })
      end
      hidden_field_system_options = {
          class: classes,
          data: original_data.merge(
              { href: select2_autocompletes_path(controller_params),
                limit: limit.present? ? limit : 25 }
          )
      }
      hidden_field_options = hidden_field_system_options.merge(options)
      hidden_field_tag(name, value, hidden_field_options)
    end

  end
end