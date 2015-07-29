# Description:
#	Uses hubot-github-webhook-listener to get github webhooks and prints out the information
#   /hubot/hubot-github-webhook-listener port 8080
# 
# Author
# 	Leon Pham
#

module.exports = (robot) ->
	robot.on "github-repo-event", (repoEvent) =>
		
		switch repoEvent.eventType
			when "push"
				payload = repoEvent.payload

				# Check to make sure all required fields are present before formatting message
				if (
					payload.head_commit? and payload.head_commit.message? and \
					payload.head_commit.committer.name? and payload.head_commit.url? and \
					payload.ref? and payload.repository? and payload.repository.full_name?
					)
					commit = payload.head_commit

					# TODO: Should figure out how to do multilined strings (kept adding weird tabs)
					message = "#{commit.committer.name} (#{commit.committer.username}) pushed to #{payload.repository.full_name} - branch #{(payload.ref.split "/")[2]} with message: \"#{commit.message}\".\n(#{commit.url})"
					robot.send room: "#general", "#{message}"
				else
					robot.send room: "#general", "ERROR: Github Webhook is formatted incorrectly"
			else
				robot.send room: "#general", "NOTICE: Github Webhook test is successful!"