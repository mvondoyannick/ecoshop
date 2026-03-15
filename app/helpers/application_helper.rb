module ApplicationHelper
  def status_color(status)
    case status
    when "Planifiée"
      "bg-blue-100 text-blue-800"
    when "Visitée"
      "bg-green-100 text-green-800"
    when "Archivée"
      "bg-gray-100 text-gray-800"
    else
      "bg-gray-100 text-gray-800"
    end
  end
end
