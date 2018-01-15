module ForemanAnsible
  module ConfigReportExtensions
    extend ActiveSupport::Concern

    included do
      class << self
        alias_method :orig_import, :import

        def import(report, proxy_id = nil)
          report = orig_import(report, proxy_id)
          save_ansible_origin(report) if ansible_report?(report)
          report
        end

        private

        def save_ansible_origin(report)
          report.origin = 'Ansible'
          report.save
        end

        def ansible_report?(report)
          ansible_report = false
          report.logs.each do |log|
            if log.message.value =~ /"_ansible_parsed"/
              ansible_report = true
              break
            end
          end
          ansible_report
        end
      end
    end
  end
end
