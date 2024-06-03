# Imports the GCloud logging library
import google.cloud.logging

# Instantiates the logging client
logging_client = google.cloud.logging.Client()
logging_client.setup_logging()

# Name of the log to write to
log_name = "mygcplog"

# Select log to write to
logger = logging_client.logger(log_name)

# Writes a simple log entry
logger.log_text("Hello World!")

# Writes a json/structured log entry
logger.log_struct(
    {"message": "My second entry", "weather": "partly cloudy"}
)