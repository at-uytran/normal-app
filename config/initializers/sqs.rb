QUEUE_URL = "https://sqs.us-east-1.amazonaws.com/596865106215/video_render_queue"
SQS = Aws::SQS::Client.new(region: 'us-east-1')
POLLER = Aws::SQS::QueuePoller.new(QUEUE_URL)
# poller_stats = POLLER.poll({max_number_of_messages: 10 }) do |messages|;messages.each do |message|; puts "Message body: #{message.body}"; end; end

# SQS.send_message(
#   {
#     queue_url: QUEUE_URL,
#     message_body: "Information about current NY Times fiction bestseller for week of 2016-12-12.",
#     message_attributes: {
#       "Title": {string_value: "The Whistler",data_type: "String"},
#       "Author": {string_value: "John Grisham",data_type: "String" },
#       "WeeksOn" => {string_value: "6", data_type: "Number"}
#     }
#   }
# )

D_L_QUEUE_URL = "https://sqs.us-east-1.amazonaws.com/596865106215/dead_letter_queue"
D_L_QUEUE_ARN = SQS.get_queue_attributes({
  queue_url: D_L_QUEUE_URL,
  attribute_names: ["QueueArn"]
}).attributes["QueueArn"]

redrive_policy = {
  "maxReceiveCount": "5", # After the queue receives the same message 5 times, send that message to the dead letter queue.
  "deadLetterTargetArn": D_L_QUEUE_ARN
}.to_json


SQS.set_queue_attributes({
  queue_url: QUEUE_URL,
  attributes: {
    "RedrivePolicy": redrive_policy
  }
})

# PollerWorker.perform_async();
