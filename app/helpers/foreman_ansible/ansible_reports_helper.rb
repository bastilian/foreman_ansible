module ForemanAnsible
  # This module takes the config reports stored in Foreman for Ansible and
  # modifies them to be properly presented in views
  module AnsibleReportsHelper
    def module_name(log)
      log.source.value.split(':')[0].strip
    end

    def module_args(log)
      parsed_message_json(log).fetch('invocation', {}).fetch('module_args', {})
    end

    def ansible_module_message(log)
      paragraph_style = 'margin:0px;font-family:Menlo,Monaco,Consolas,monospace'
      safe_join(
        parsed_message_json(log).except('invocation').map do |name, value|
          next if value.blank?
          content_tag(:p, "#{name}: #{value}", :style => paragraph_style)
        end
      )
    end

    def ansible_report?(log)
      module_name(log).present?
    end

    def ansible_report_origin_icon
      'foreman_ansible/Ansible.png'
    end

    private

    def parsed_message_json(log)
      JSON.parse(log.message.value)
    rescue StandardError
      false
    end
  end
end
