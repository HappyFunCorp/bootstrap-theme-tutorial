ActiveAdmin.register ReportInfo do
  menu label: "Reports", priority: 6

  config.filters = false

  permit_params :emails, :subject, :models

  form do |f|
    inputs 'Details' do
      input :emails, as: :string, label: "Emails, Comma Seperated"
      input :subject, label: "Email subject (leave blank)" 
      input :models, label: "List of models/scopes to return data on"
    end
    actions
  end

  collection_action :send_reports, method: :put do
    count = 0
    ReportInfo.all.each do |ri|
      ri.send_report
      count += 1
    end

    redirect_to admin_report_infos_path, notice: "#{count} reports sent!"
  end

  member_action :send_test_report, method: :put do
    resource.send_report
    redirect_to resource_path, notice: "Report sent!"
  end

  action_item "Send Tests", only: :index do
    link_to "Send Test Reports", send_reports_admin_report_infos_path, method: :put 
  end

  action_item "Send Test report", only: :show do
    link_to "Send Test Report", send_test_report_admin_report_info_path( resource ), method: :put 
  end
end