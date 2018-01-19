module ForemanAnsible
  # Scans ConfigReports after import for indicators of an Ansible report and
  # sets the origin of the report to 'Ansible'
  class AnsibleReportScanner
    class << self
      def scan(report)
        report.origin = 'Ansible' if ansible_report? report
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
