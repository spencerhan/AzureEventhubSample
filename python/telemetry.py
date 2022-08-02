import time
import json
from csv import reader
from azure.eventhub import EventHubProducerClient, EventData

connection_str = '<Your connection string>'
eventhub_name = 'weather'

class SampleData:
    def __init__(self, date, city, description):
        self.date = date
        self.city = city
        self.description = description

    def __str__(self):
        return f"{self.date}, {self.city}, {self.description}"

def send_to_eventhub(client, data):
    event_data_batch = client.create_batch()
    event_data_batch.add(EventData(data))
    client.send_batch(event_data_batch)

def main():
    with open('weather_description.csv', 'r') as weather_descriptions:
        csv_reader = reader(weather_descriptions)
        header = next(weather_descriptions)

        cities = header[:-1].split(',')[1:]
        client = EventHubProducerClient.from_connection_string(conn_str=connection_str, eventhub_name=eventhub_name)
        for row in csv_reader:
            date = row[0]
            i = 1
            for city in cities:
                sampleBatch = SampleData(date, city, row[i])
                send_to_eventhub(client, json.dumps(sampleBatch.__dict__))
                print(json.dumps(sampleBatch.__dict__))
                i += 1
            time.sleep(3)

main()