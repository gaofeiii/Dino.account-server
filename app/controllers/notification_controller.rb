class NotificationController < ApplicationController

	def send_apple_remote_notification
		data = if Notification.send(params[:device_token], params[:message])
			{:message => "Success"}
		else
			{:message => "Failed"}
		end
		render :json => data
	end
end
